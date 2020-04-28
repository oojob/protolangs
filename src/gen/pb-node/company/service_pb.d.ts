// package: company
// file: company/service.proto

import * as jspb from "google-protobuf";
import * as company_base_pb from "../company/base_pb";

export class Company extends jspb.Message {
  hasIdentity(): boolean;
  clearIdentity(): void;
  getIdentity(): company_base_pb.Identifier | undefined;
  setIdentity(value?: company_base_pb.Identifier): void;

  getAdmin(): string;
  setAdmin(value: string): void;

  getUrl(): string;
  setUrl(value: string): void;

  getLogo(): string;
  setLogo(value: string): void;

  hasEmployees(): boolean;
  clearEmployees(): void;
  getEmployees(): company_base_pb.Range | undefined;
  setEmployees(value?: company_base_pb.Range): void;

  hasPlace(): boolean;
  clearPlace(): void;
  getPlace(): company_base_pb.Place | undefined;
  setPlace(value?: company_base_pb.Place): void;

  getFoundedYear(): string;
  setFoundedYear(value: string): void;

  getHiringStatus(): boolean;
  setHiringStatus(value: boolean): void;

  clearSkillsList(): void;
  getSkillsList(): Array<string>;
  setSkillsList(value: Array<string>): void;
  addSkills(value: string, index?: number): string;

  hasMetadata(): boolean;
  clearMetadata(): void;
  getMetadata(): company_base_pb.Metadata | undefined;
  setMetadata(value?: company_base_pb.Metadata): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): Company.AsObject;
  static toObject(includeInstance: boolean, msg: Company): Company.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: Company, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): Company;
  static deserializeBinaryFromReader(message: Company, reader: jspb.BinaryReader): Company;
}

export namespace Company {
  export type AsObject = {
    identity?: company_base_pb.Identifier.AsObject,
    admin: string,
    url: string,
    logo: string,
    employees?: company_base_pb.Range.AsObject,
    place?: company_base_pb.Place.AsObject,
    foundedYear: string,
    hiringStatus: boolean,
    skillsList: Array<string>,
    metadata?: company_base_pb.Metadata.AsObject,
  }
}

export class CompanyAllResponse extends jspb.Message {
  clearCompaniesList(): void;
  getCompaniesList(): Array<Company>;
  setCompaniesList(value: Array<Company>): void;
  addCompanies(value?: Company, index?: number): Company;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): CompanyAllResponse.AsObject;
  static toObject(includeInstance: boolean, msg: CompanyAllResponse): CompanyAllResponse.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: CompanyAllResponse, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): CompanyAllResponse;
  static deserializeBinaryFromReader(message: CompanyAllResponse, reader: jspb.BinaryReader): CompanyAllResponse;
}

export namespace CompanyAllResponse {
  export type AsObject = {
    companiesList: Array<Company.AsObject>,
  }
}

