Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBAE42BEAA;
	Tue,  1 Sep 2026 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284859; cv=none; b=O5ywm/eLmVZQoqVHQIymOP/QCNIY43n1sFXQeinswuaOlz5CsVc/CuPvDEl58IC5mnZa/GXUVOCZPpJU/Juj6p6n1l0YHIYzDBEoT0UM+FXA02T/kNIM05EHqSGBOe11N2O9cciuEBXakUXRccbtcWnttzqULK5VkJXvYxUpUSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284859; c=relaxed/simple;
	bh=wIRXo+W1Y5nbg+WXe/4P+PdfNFVyerjk7vcydHkYvEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKj4bjcL3dKUYV57a/C+7b76cCciy/lGTixAZKG286O4t6NQJrwnEyorrynHA7PmANw7IA6Z75IrT4Sy6acapnpg/TRVZOssYMKr2ceB3WMRzJl3f9X8VWDvmwrxXdGPrLY/Am0lrDysQydy2MiFietwpD47H0XDZjeA6Qp/R/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=AseZTlST; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="AseZTlST"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6EDF411D491;
	Tue, 01 Sep 2026 19:47:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788284851;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=4+8PgNgJ5Ij4UdhznqcIK9s6t0P6PpU4tqKqhOgaAiE=;
	b=AseZTlSTc3JnZGWkciXYws+sV3jij1LDXgBqHRViuZE5kBrrkaPcMm6GiXtGGZjnXdpcgx
	Id7rsXqHUfYFJk7TJmAG1TeCE1H3Q3HnwD5DlvPAaxl36LX5JYzcOdFMuGi7wS3l5tSvtA
	OochtTRM0+ujE0DeGsyfQr+79Om4Kt72NbDQ1EEj08Z2UmMX2PQkg+WX6HFibxSGLG++bM
	nidMwL5+e6a4TTdgFjLNmmj10BcvI/huLOP57Rgn+uxdG383sund6Om/WnObeMivAKZ784
	67CHy5X+Pc5TZdKhXJrljjbSf6txnwgEVd/c6XvjKSsjp2GCGNX0Mtp4xSKGDg==
Message-ID: <f86a6a8a-6f38-4082-abb2-7ab6c91b269d@nabladev.com>
Date: Tue, 1 Sep 2026 19:47:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: hwmon: tmp102: Document TMP113
To: Conor Dooley <conor@kernel.org>
Cc: linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Flaviu Nistor <flaviu.nistor@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260901161008.46948-1-marex@nabladev.com>
 <20260901-untimely-wake-578b1a86b9fe@spud>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260901-untimely-wake-578b1a86b9fe@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/1/26 7:37 PM, Conor Dooley wrote:
> On Tue, Sep 01, 2026 at 06:09:20PM +0200, Marek Vasut wrote:
>> The TMP113 temperature sensor part is register compatible with TMP102,
>> document it using a fallback compatible. Unlike TMP102 and TMP110, the
>> TMP113 does have additional unique ID registers, it is up to the driver
>> to handle those.
>>
>> Signed-off-by: Marek Vasut <marex@nabladev.com>
>> ---
>> Cc: Conor Dooley <conor+dt@kernel.org>
>> Cc: Flaviu Nistor <flaviu.nistor@gmail.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-hwmon@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>> V2: Rebase on current next and resend, resolve a conflict with commit
>>      d67ec24d3f07 ("dt-bindings: hwmon: tmp102: move ti,tmp103 out of trivial-devices.yaml")
>>      Note that the TMP102,110,113 are backward compatible, therefore the
>>      valid compatible strings are:
>>      - "ti,tmp110", "ti,tmp102"
>>      - "ti,tmp113", "ti,tmp102"
>>      - "ti,tmp102"
>>      The TMP103 is not backward compatible, it only shares bindings now,
>>      therefore the only valid compatible string for the TMP103 should be:
>>      - "ti,tmp103"
>>      And that is all, no other compatible strings are acceptable here.
>> ---
>>   .../devicetree/bindings/hwmon/ti,tmp102.yaml          | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
>> index 55d9f106465d7..c0b747a9ce0de 100644
>> --- a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
>> @@ -4,7 +4,7 @@
>>   $id: http://devicetree.org/schemas/hwmon/ti,tmp102.yaml#
>>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   
>> -title: TMP102/TMP103/TMP110 temperature sensor
>> +title: TMP102/TMP103/TMP110/TMP113 temperature sensor
>>   
>>   maintainers:
>>     - Krzysztof Kozlowski <krzk@kernel.org>
>> @@ -13,11 +13,12 @@ properties:
>>     compatible:
>>       oneOf:
>>         - items:
>> +          - enum:
>> +              - ti,tmp110
>> +              - ti,tmp113
>>             - const: ti,tmp102
>> -          - const: ti,tmp103
>> -          - const: ti,tmp110
>> -      - enum:
>> -          - ti,tmp102
>> +      - const: ti,tmp102
>> +      - const: ti,tmp103
> 
> Should this not be two patches, one fixing the existing stuff and one
> adding the 113?
I can send this as two, sure, will do in v3.
