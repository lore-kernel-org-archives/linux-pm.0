Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C422A48EBF1
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284938; cv=none; b=LV/2kx9DiOa/I7jqSWcXZSUKmAPiEAGmA25bWuQzQ3ed9aNnsZWYkjXT4Al7Ov54GSF5Ps12fdSvp+TFR4S3q5OMjyE/27daNv984EAWASEtmAD/yNXVhgtxgMlDnGyk4h5Ix8JYEGvi6ZA9o6cKG1AU2NJdHmX28aBIKKuyEmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284938; c=relaxed/simple;
	bh=i53NAywJaaV600MD9wWv3pYldiMh6wk/lXIJKv63y/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJKFsYL8o8U31Rpe2XNLoq2ZH2EPdUjwK406XUb8N/xdU74ldDGERht44cHrgtm51DZHXC6fBOCS9IRVraFBToFKXDiCtRVbN5EQM2D/xjAkGnyl3ggOOY4WBgzCLz96WUykCqyh1G8pXuHSR5x6cpoqDxCdd9YlYJMnN8gegas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AloOmOLj; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AloOmOLj"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-39675172593so101447a91.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 10:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788284936; x=1788889736; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UjROwqeMkSNlzuU3TEoF5fn5iOEmAQo5NbwEKf5PfyE=;
        b=AloOmOLjjkC9nSfX+Ln4M3zNZhhu95Ebcr45oLQCnNuvKEYx68xytED9r3XzlKqNxr
         Z/xvMgIL7mBiHDMwUBOMI4gLuQL0I8mf37oEV0kxQXKEaiaI/kvvOhQATWyhmxSZPJzi
         JMW3OJzi7EkOd5xPSht/lfuzqNg9VEl9szXD0OtC1GKdPpzhWLJIUTY08gZHjEVmk2Dd
         sZO2INJdF5w3USfLlxg+b4wLrB8ejmh1DXtNWpvg8hZR+8H6zswTiarTC1dtY1E1U4CA
         3Y8wWar0kYl8WDPvPmhgR7uZiG8GZ5gEsKHutIcoKoOwHfHQMHNuA5mDt5UJCbtuKRIa
         07Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788284936; x=1788889736;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UjROwqeMkSNlzuU3TEoF5fn5iOEmAQo5NbwEKf5PfyE=;
        b=qyApXiGWv1Ub5EEJFKXFOtTt3o6ow6IPB9imtFtI5XRc477OqkJvjcM83HGTnW22OJ
         dylqDdqjMTMSJb2HlZqgVMmF7g6fJd3IV+m8VT60t749CgdH3MA5gwx0ntDWPuQLbKF9
         X5DvFNQ4WcW+rQa0MkxCNQOhYbmJa870S4UIHWhsCl2F1a6S9y6+vH3pTvlM6646Qmhr
         D1KBxIXYJYe6/XgcTXHrjV9eBhtFEZOiVhSJ9Qc5YIQbrZm7PFXlGQbqcsvhYl/ohdoO
         CG0hwWyGJJTWDSrjCxodweWCp3jyZP7Lh6khT3UoY7CZ9qOEddXQOEqSRQ4IVpOnQeeR
         qZJQ==
X-Gm-Message-State: AFuF++m/jzbTcog2bueNbxVmedd6cpU2+qNWsFZC7UDFTU7caj9/FVVq
	VjrS9snEUG88LoCB6FLHPr6aAq9a2M1ejiyX3vt49t4FWQblV+yI8GdK
X-Gm-Gg: AYBFou1A7f3HphQj86qXb02YG//ndQz8SUAMd6zPKCvsb8qJELJKgl+UdKJSS8ZseM0
	H9XBJUs/xkYw/kO1cUoFJ874xT/qRthaUrp/wHWaIk7WJTutboberXlTn6HVBaDIRALg4p4OOco
	rhyq0J05Dy5+Fr3BsiwI3qsPHoy1Et2HowFwInj1nrVu3bVB5RM0AmT2q626/ANymNba+le2Z2a
	jUCItsE55UK95p3bADaJ2y2R/ALQEcNA3tMYWHz5LCLFFl5YN0vWI9POpk33DkT+FsORn8ODzu0
	hQWaUNqXUQTmey9Y9cZYBMuAInOf/dR/U4dQqDRqKoJjnAOVleFM6gIZFGIXvtYc32e9sDuSRWh
	JyuMAiQ60+MrJLe4p2tTMBlKugNtw3iMC5/v/cmYtxpIm2RC4QOj/4RaoJMR3DViAhLTo/utNjD
	R1AjtQUcIdNiT4f0UaVWsJ+IzYfUXaxacgCecElCk3B8BX+pN7PFtSHn45DW54J3QynHjF2/HaV
	5sIR/9hRtwmHcc8f4FKybtAk342hyMeEY7vAgI=
X-Received: by 2002:a17:90b:4a90:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-396d0f8e9f9mr51852869a91.11.1788284935948;
        Tue, 01 Sep 2026 10:48:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae0dfcd65sm740565a91.3.2026.09.01.10.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 10:48:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4bbcc5fe-86a1-4299-a0df-e9f44d5c237f@roeck-us.net>
Date: Tue, 1 Sep 2026 10:48:54 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: hwmon: tmp102: Document TMP113
To: Conor Dooley <conor@kernel.org>, Marek Vasut <marex@nabladev.com>
Cc: linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Flaviu Nistor <flaviu.nistor@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260901161008.46948-1-marex@nabladev.com>
 <20260901-untimely-wake-578b1a86b9fe@spud>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260901-untimely-wake-578b1a86b9fe@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/1/26 10:37, Conor Dooley wrote:
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
> 

It is all in -next. Looks like I resolved the conflict when combining
"dt-bindings: hwmon: tmp102: move ti,tmp103 out of trivial-devices.yaml"
and "dt-bindings: hwmon: tmp102: Document TMP110" the wrong way.
Sorry for that.

Instead of adding more patches on top of it, how about providing a
single patch moving tmp103 and adding tmp110 as well as tmp113
together ? Alternatively, I could drop "dt-bindings: hwmon: tmp102:
Document TMP110", apply the original (non-conflicting version) of
"dt-bindings: hwmon: tmp102: move ti,tmp103 out of trivial-devices.yaml",
and then tmp110 and tmp113 could be added in a single patch.

Please let me know.

Thanks,
Guenter

