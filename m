Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0616439AD2A
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120352; cv=none; b=pvNUnzlozq/NWt3jDkdY/8JqJiqkX8lliC1kWrY4R47AtHkJ21rbdWrIbqeywCvd44GU5yagQM/3eZO683Z0k+3NbUpUrnOTOA0vhQu1ZMqLdnxwi8SZBhxqSZH+7/BVmk+LZpuhptTYwbAJ0zxEQQoWA6aVrkbYSuo9AOQV8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120352; c=relaxed/simple;
	bh=3NmbvHcdNHb2ax4IS5MGihMyuSj7LIc21eicMTlUGtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAZu+JYNh/DJUOGyvEOSX2+XxGDhJOZ/zpqYOUWG5aHVG6RK7c8AyeZQmRoiVkvWhhDxvZKV/27dL0L/HAJ7/hgrrUziPKVwngNhqn/1axZyoOxl1QahhiH4FYvxCVtGR3tYI98OY6wlM5cTR+yShY4rTvvuPGME+eE7Spi20mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMM/dxcy; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMM/dxcy"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9c60b9so54324766b.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 02:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789120349; x=1789725149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WTJ3Yl3D1Apzgbf0VLfYhSFknYE/u4woMT1MsBZYWs4=;
        b=cMM/dxcyZuYmF2kG3VuCYOFuJNyFN4D/eOCPBZpsg/xc7J7+vzUHTIDqgLHLfMIlso
         5FFnRIbCrW+ghZT4dTUuo6PwogfYe/mSgo84GNRPD3Ng/zB0xerx6tUstpF4vfXZLf/P
         JgSX3PMRf1X3syx17+5p7jtyWoDMuzdBZTrv4XJdEl/N7iQqkUMu1tM/xRaYEecIwlV9
         1vHklTyja3fJJkwMmlYttU8WoT/54B93gog4Y4luqZNDE7pSy985mw+YlCndS+Az1G2c
         avujHNL6OTxRE/OYdmrjlgbHATsA5RoQQFbNRJxhZCIsg8LyX3tnWLmKrkQCSN4MuajI
         Si6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789120349; x=1789725149;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WTJ3Yl3D1Apzgbf0VLfYhSFknYE/u4woMT1MsBZYWs4=;
        b=kmOSRwDDGFkIHyJ/YilxnOfkszPA0CeKS9YFGAk9zIN3YNhrMTFwdUtZOTdv2t3lxu
         cKX63LedqNZ/jCfUlu5A9FmI35YCLZrIZ2MAvlFWL8AXoSm4bbQyka3hfNyw/07CLisW
         aAhuvhrOyoTDyZFRKxIv1Sm3TXQqmy7ySUjRwsYO1CH71bvTf9NKG8nDbcTeImNG+lkG
         yyTwFNojLL1iv2cDZB5IMtqCZmUISXt9SqUhciPoxvMRpSPxpOqO/w9D23G4wXBOCcYM
         hHOZtKB4Pe8qFM6hODMjegoIXEEzw1n+p6deeW0dApYv39azFhEbDyxEyBaXdloEToY7
         NkYw==
X-Forwarded-Encrypted: i=1; AKwUvByeTkh+TVcBp33BstvQjp1/NvGIDAKIQvfMql+rB7SHF9VFLyDBhQD4D2CRojG3o8s96cs7OuRIIA==@vger.kernel.org
X-Gm-Message-State: AFuF++kYzecXoaK7/49sUAdNNBGKC+ruv8G50H4Lizk9GyN7UlpdIit3
	HmPUzJwjjDaW21l3lir4//2X4DfQ3l6/1QSboOXiOKKaSkYdvgpN27DUVtrJvbsT6wA=
X-Gm-Gg: AYBFou3C0EXyNzHmMU50xqS+suhfeF310c1RpN7sSxCgVlZCo0sEq/Eg4NYsKum6VmX
	Vzfp4+QP63STyIzpNFxn6IHuUsn73uXY71hKbzEQMDCJ6v8Zv6TIpQaT+ifThTubPyq9hDaoPNi
	sc64v7bteCw1Rk41ujgwhBarvVjnszhGKEFvjVdENsoQV708GhoDNJ7aYLoCoQIR0VPD/AClJZQ
	fTiPR825qzzjPVBsO60HIZWKy6h0jnaEkw/vQHu1nyJ9R91QjZMYho6W60fU0njWTWfXYwBFFHp
	IQeIEgcdKuTsSdC80O5lwZswE6hGsW14roqJyQ3xXaojg7f4zhKR8xv7xOC9p0lJ/8KmQtR+gb9
	RbD+UATrzvlP0DsmZjrY41J14CstODDLavh8Mz3iGF2kPO9xFsVzS8BkFYcYP6m/tMBvGhItCA0
	FDweuuFKPGlhfCdFNLWCOpT/gZxdXie7KqU/IAoyaS00uD3+fjbEL5/zLcVxRKsH+GftbldVkbL
	aeK24PE/64lhWIO0qRshiqDUmmOmQ3LvZj2
X-Received: by 2002:a17:907:980a:b0:c25:f7db:4beb with SMTP id a640c23a62f3a-c2962c415bcmr196891966b.17.1789120348977;
        Fri, 11 Sep 2026 02:52:28 -0700 (PDT)
Received: from [192.168.1.30] (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2966024941sm62574066b.14.2026.09.11.02.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 02:52:28 -0700 (PDT)
Message-ID: <930e17e8-8fdf-46c4-9e89-3eb1d7cd58aa@gmail.com>
Date: Fri, 11 Sep 2026 11:52:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/3] dt-bindings: soc: qcom: add
 xiaomi,taoyao-pmic-glink compatible
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20260821123711.1579539-1-zstaseg@gmail.com>
 <20260821123711.1579539-2-zstaseg@gmail.com> <aqHLuHr-Vf3gtz2T@venus>
Content-Language: en-US
From: Stanislav Zaikin <zstaseg@gmail.com>
In-Reply-To: <aqHLuHr-Vf3gtz2T@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 11:16 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Aug 21, 2026 at 02:37:09PM +0200, Stanislav Zaikin wrote:
>> Add the compatible string used by Xiaomi 12 Lite 5G (taoyao) so its
>> battery manager can be matched to a device-specific variant in
>> qcom_battmgr.
>>
>> Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
>> ---
>>   Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>> index 16ad4f5698fc..8ca057c4e3e6 100644
>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>> @@ -41,6 +41,7 @@ properties:
>>         - items:
>>             - enum:
>>                 - qcom,sm7325-pmic-glink
>> +              - xiaomi,taoyao-pmic-glink
>>             - const: qcom,qcm6490-pmic-glink
>>             - const: qcom,pmic-glink
> 
> Is the implementation compatible with qcom,qcm6490-pmic-glink? The
> driver does not bind that compatible, so I can't tell. Maybe some
> Qualcomm people can answer this question. Please send new version
> without the RFC tag, so that DT binding maintainers review this
> patch series.
> 
> Greetings,
> 
> -- Sebastian

Hi,

Thank you for the review.

Yes, we still need qcom,qcm6490-pmic-glink for usci_glink driver 
(there's a quirk that all sm7325-based handset uses: spacewar, dubai).

Will send a new version without RFC tag.

-- 
Best regards,
Stanislav

