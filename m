Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9556F3C1409
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155656; cv=none; b=mcDAnDwaE1vFQgrsZSn0H4NWKm8sM/LkOk7nPO4rebehh++NSUHhaRSJl2+lLJZM1fM4R4qIXCVBTI5Th2YOPoBMrcJXMztkx3ojgI1zXct1qvL2BVkFngvZdiJTgnZwScKfYxHCp7YS+GT0LsTxifYhKpgexw1i8eR2kDX1l5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155656; c=relaxed/simple;
	bh=OVudXei1XMX+Hk0vFE/KI/maetr0rgXz6TaXIWcvCYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3VtgWBHWAWUMrgUd+YjMhGSne4sdhHyzA8185iuQ0YtQirEdg9X5k+vLWRPJjBNjo928uWobV5hw7W93YpSsoq8vtuF57fOSpXmMLZeY8S8jz2Gkcu+Fs1qg30FzCUbI9fd7F9JUJO+qX3riAqiTQ/bqHU7KiBLGUuy5simfZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=owql1B9m; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="owql1B9m"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c56aa62931so2681586eec.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2026 11:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775155654; x=1775760454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MpykImWK6bjT2nlpOYqPcIo7o07mstIYTD+Wq8ULKFw=;
        b=owql1B9mcaC0eOg4VNCiuhWkg/5iwr+DNvkHZxi74p7vcNh9DPI4i07VvHU+En21OV
         JAUuKT0JDx6TZuVOtXRpCE/0xDlh2MVYPJrILlRAb3k81bHYVpWhwptxA3ZVwbDuR5VX
         gy8HWzaysceZNknsMiL2bEF9dTt7vz6FrbuFZhbaZTjgxx69m7YgQi/ARDsBSy/PqAf8
         o1EreyeoCam0/B0LrFd3QvOysLr3QcU0hoyPo0mTnfm16nHWic0BNWhXFe8jU/9nDi96
         giuIi/h5SowRAI2FEma/5EgETouteSIOZiszBjvyro1Y7U9XLZkD0p4glfnsrjYkRSPC
         h2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775155654; x=1775760454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpykImWK6bjT2nlpOYqPcIo7o07mstIYTD+Wq8ULKFw=;
        b=izRk6Q+XnAeLk20fRT4Heyil26h3tKMfp4zqgMmo0FxJYfm5flT5OFi//C0tfBg9Ib
         1IzoQTp/TB8BwuZHZh5e4RInKNTCsXaB2uzli1CMisv6VytqOYApV6UFu7iNHJatEyY6
         nEJD8p6gwxEUCJwWBHgERXurqLDpZ/2nm1bBmMT6pFbr9gEGUcMXNxSzxV0fXXbZ1tHj
         2ooOgygG4G0g+09n+dwTJRrOidzYyH5BiFDGrwi1HGctQLMGc1rInr/lWChfBGmeJBLb
         uuBgUBU8TUOuCzvJ+7gz2/xLiJ+jtpD0vIOEI5l3hpfaH5vlELdddJ0O0gV9iRURRNmX
         754A==
X-Forwarded-Encrypted: i=1; AJvYcCXh5+43AOt685EULTKTmtJPPtDVePxq4S7lp/vkFQA3qUG1Um/tQl0ihQsY1SZLRmDXtwdpj0iZNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSK5fpPoQ3DCfxTZr+upwSZ2sUoGMpkfp6f9hvoKV1eUcvuYB4
	qQ9uVmGRtdncU3dxbQJEMfQjSTNHI9MW0R47t8VkqTEUENk/DtGLCAei2pFmNBEXVg==
X-Gm-Gg: AeBDiettciXMk39PFH1CgMkjIkTVcctcM4Ngg6/64yP/kOvCbFBg2saK4/GpKfADW6X
	eHFVciYqykfvhqjPoVp8Y6BT+jWql/hUNgwl/gmBx4m5FypE/svaJ5XVzgraKqnJBvVbe3hO9iQ
	bcxbKorsvCpm63SORIzXomQT5OVQ2+FQ76zRJ0/UJeoRKq+Hfnt9v9vThirSznz/0zocgw5iwis
	DlQpqeMzLpwO+x7SxdnyQrFYgvvFOgJQdxLvlBnRKfUldW5m1enTrINjmzV/x+pQwpRJfs/NEjn
	16QqZksecIS/qM/EppCnQbDkJBu25TNuDUH2o1grU4KjDILyX6/Cigi2gDWdm+ZW9e10jlKjIgB
	8mcUFSLYVrVUag77521puBlMVEalNR7RGSHL/1t5ydigHOXOdE/KwDx2n58/P7HhESx7oOp/1cp
	Sk4Na4Yppv0n2U/GSM55YPJsk4fdvMYxmEJhnh/5MLvgolvX3b4Fl0k1pTp4OXBM0jkgm/k4Jex
	Uwi9RVv2mV1sRZB+u8j2R7lYA==
X-Received: by 2002:a05:7300:e8a7:b0:2c6:31f0:a025 with SMTP id 5a478bee46e88-2cbfc4623eemr138794eec.27.1775155653050;
        Thu, 02 Apr 2026 11:47:33 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e7c:8:2412:bdd2:9fa6:2acc? ([2a00:79e0:2e7c:8:2412:bdd2:9fa6:2acc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20b2b1sm3319049eec.18.2026.04.02.11.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 11:47:32 -0700 (PDT)
Message-ID: <017b8552-87e2-4409-ae34-9a3ab7365a68@google.com>
Date: Thu, 2 Apr 2026 11:47:30 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/6] usb: typec: tcpm/tcpci_maxim: deprecate WAR for
 setting charger mode
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jagan Sridharan <badhri@google.com>, Mark Brown <broonie@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sebastian Reichel
 <sre@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20260331-max77759-charger-v10-0-76f59233c369@google.com>
 <20260331-max77759-charger-v10-6-76f59233c369@google.com>
 <ac5-OzwQkczTWtMg@kuha>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <ac5-OzwQkczTWtMg@kuha>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Heikki,

On 4/2/26 7:33 AM, Heikki Krogerus wrote:
> Hi Amit,
>
>> +static int get_vbus_regulator_handle(struct max_tcpci_chip *chip)
>> +{
>> +	if (IS_ERR_OR_NULL(chip->vbus_reg)) {
>> +		chip->vbus_reg = devm_regulator_get_exclusive(chip->dev,
>> +							      "vbus");
> Sorry to go back to this, but why can't you just get the regulator in
> max_tcpci_probe()?

Thanks for calling this out. This was an intentional design decision to 
break a circular dependency.

The charger driver is guaranteed to probe after the TCPC driver due to a 
power supply dependency (the TCPC is a supplier of power for the Battery 
Charger). However, the charger driver is also the regulator provider for 
VBUS out (when Type-C goes into source mode).

Because of this, the regulator handle will not be available during the 
TCPC driver's probe. If we tried to fetch it in max_tcpci_probe() and 
returned -EPROBE_DEFER, it would create a probe deadlock, as the charger 
would then never probe. Therefore, I made the decision to get the 
regulator handle lazily and on-demand.

Thanks,
Amit

>
> thanks,
>
>> +		if (IS_ERR_OR_NULL(chip->vbus_reg)) {
>> +			dev_err(chip->dev,
>> +				"Failed to get vbus regulator handle\n");
>> +			return -ENODEV;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
