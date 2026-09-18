Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C374E4E3EEB
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789730998; cv=none; b=BC1fAqQ0mTa/nQJ4Av99Oy58RQQkKz2YH08+AF+P2BfPStwvKuzfox1IlwxEfiJQCMUICnu1bxdR40DEz0J0Xzk0GBuK4HwntWUZnxfbmuYdTTUOHHbpzavsB4EzJYXYqH8dC1XP5Wevbu9R5YDss1tOQHd0R9dILsc9sg+szjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789730998; c=relaxed/simple;
	bh=NHdyr5irXkAWSK7SovevL6gz1Aqt/Mc1x9NZQLzd2j4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cd5ytMoD2P2x2tyOLPCH/iNShhmB+pyGiceixbuPk0nwMhkUuYdwBesjGUlUuwBaE8XJNw0gqqRrZa0Whr2imaGJfmU4YmJl521uG2cjauonyMKekSX4Y0xEFrw9eLEaZeVzmHKrJrVw4fpPyMfIcMJKzgoobhJSK4RF8vnpzbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnkP7CEh; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnkP7CEh"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6aa487e2337so852958a12.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 04:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789730989; x=1790335789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7+UlRdpKqeY/71MgfJXq5xM1feUDii+5U8Wx3BoLhe8=;
        b=MnkP7CEhHlUeledK+zFMFuPwFEBrH+frGemfVlXjx+b/cikFqSd9Z1MarJr3vT4kwW
         ULF4NSCv3OGu/sN2wtVQbGRdv0DnAAHCTsb+IzkO/wJTLtsumKDOkrAGgfxM0jBunTyY
         jwHj9sF8k3kK2q+tvBLIv5m5W/6KMMXvQNAzw7WzgEU6ZQXtNbhfNJ2AwGzfJY+neqH2
         VmB1kravRsbmcWNBiGI9Qc5FIu6cvyE+bwDaXF3i10f1NdG6OEmRCsa+AUyS5aXXRzK9
         h4LERPco4Ie1BNlggs74oQp9qE8yx+c929v9Ma49gRrMtPclCxJXOpVRLiltSNCjiLpS
         2+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789730989; x=1790335789;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7+UlRdpKqeY/71MgfJXq5xM1feUDii+5U8Wx3BoLhe8=;
        b=RjL4FjniwkrXWH0Yy6v4bIGCDiAff6B8HPFk8U3wCvuctQ938u3gpREOURrcA6ajXx
         drurQ78Yi/FJ5cNiRA5+WEyOy1UOitToCjLvWRgJkk2Fqa0SfpKUf1KFa0hOHsuCGr9p
         5wr5OjfQM0BTjJzZpQqmNYqMRlQfgeXSMoEqFdfkhZzQKP2WZTdQIpbjIgPEavIMvX2P
         IIttIXBox0Y4sJ4tlbnVloJJbSF1PtqUdVTlSY2k1i3e8n1l0q6W2PVBaoE4Beo+93dg
         +tEIOb7Bnvp12WBooka5gdsWeaNp5yvZbL3nHde1D3Hh8zVI/WalzwdurVoba0Cvr5eG
         xjeg==
X-Forwarded-Encrypted: i=1; AKwUvBxJMFKEAz39omp9/P6BNqBOWJSyTFAsAEQ5N2wQheWiH2+Vn1fnwbTV6gP5EXEkbrXwGSQ8WpgHqA==@vger.kernel.org
X-Gm-Message-State: AFuF++lIw3Om2bJ5cwHh24Uq8ahd0i1VZgEdrzMbFNOcadrlsKiHYYOF
	8/0PRdSA6n9iBnFWtClkW9gVk1EOeixQMsreHrGGEuMBtWsEZL23IvQb
X-Gm-Gg: AYBFou37IVXJ7RXxJ+nzfK9YrLUxa8qbSQeXiDQstT/u0f1TYnqXjYJjB23F81+nxRg
	uXNJQR8DMc06Z9sFWZUaD3et5y5/UVOTqrcmV0q3Ww8wDnOh6svX3gRf3WhQ8FutmkAc5eCagzE
	XGSTATq+qwKTBhcTKEW7x9eUoKAj+x6JBSUjfICxT862aBFOhHMbUgTnjTKbBmTkBiNSuzyOlBn
	0CsEgzuMqq/Qilf1nDTvBxKXW1qcWgTuexU4WaPpSd1uNgdwHq+8651IxFU689/k7Ox+FCWYF5t
	I5n7z2PbQK4WzO2gzkwiW4XYrgrWCGQ1vhmpF46gfD3Fom/Z51CE5fM6wDKdmk9bYtnX/oq/nQs
	RrVtZuCI15tnoMeNDdCwe5fFP8sY2UMsSyRalfmucChanCF2bln+RZUBjWwof92O2v7HbvrNLm7
	kb2Hpd1KxR/KMsiSGJESSL+xvEPf8yb5ycuXRQdCvTata6ZVX/ZEK8AoDjoBSphtMeTId/FNcGH
	wUl/GwVdQIns93bsxRnjPe9s6CeeB9RdzU=
X-Received: by 2002:aa7:c9c1:0:b0:6aa:17:3b6b with SMTP id 4fb4d7f45d1cf-6aa36cce9e7mr3591718a12.0.1789730989123;
        Fri, 18 Sep 2026 04:29:49 -0700 (PDT)
Received: from [192.168.1.30] (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa59710fb4sm775318a12.14.2026.09.18.04.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 04:29:48 -0700 (PDT)
Message-ID: <8e7cf0cd-5db8-4565-82e4-932fba96f21e@gmail.com>
Date: Fri, 18 Sep 2026 13:29:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sm7325-xiaomi-taoyao: switch to
 device-specific pmic-glink compatible
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260915084901.56622-1-zstaseg@gmail.com>
 <20260915084901.56622-4-zstaseg@gmail.com>
 <6b2c1fa6-5bf2-4c1c-8046-929576ddbc53@oss.qualcomm.com>
Content-Language: en-US
From: Stanislav Zaikin <zstaseg@gmail.com>
In-Reply-To: <6b2c1fa6-5bf2-4c1c-8046-929576ddbc53@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/26 1:31 PM, Konrad Dybcio wrote:
> On 9/15/26 10:49 AM, Stanislav Zaikin wrote:
>> Switch taoyao to "xiaomi,taoyao-pmic-glink" compatible so
>> qcom_battmgr can identify the device and apply its taoyao-specific
>> battery property mapping, required because its firmware shifts
>> battery property IDs relative to the generic sm7325-pmic-glink
>> firmware.
>>
>> Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts b/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts
>> index 6f8bc65bb99b..bc4dfa49ef38 100644
>> --- a/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm7325-xiaomi-taoyao.dts
>> @@ -72,7 +72,7 @@ key-volume-up {
>>   	};
>>   
>>   	pmic-glink {
>> -		compatible = "qcom,sm7325-pmic-glink",
>> +		compatible = "xiaomi,taoyao-pmic-glink",
>>   			     "qcom,qcm6490-pmic-glink",
>>   			     "qcom,pmic-glink";
> 
> As krzk points out, this should be a standalone single compatible,
> because it's neither going to work with qcm6490-pmic-glink nor with
> qcom,pmic-glink
> 
> Konrad

Only the battmgr implementation differs but the rest is compatible with 
qcm6490 (UCSI implementation) and generic pmic-glink (basic 
communication). So, we should keep all 3 compatibles.

-- 
Best regards,
Stanislav

