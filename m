Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022B73438B0;
	Tue,  2 Jun 2026 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401583; cv=none; b=TZXiGUF0txm2lXc3776exc4YgqDBKx1gBrGoR9qpcmr5TBlD/nT6Qc8bcyeY7HfYAA+Sn/7sJ1czBJXO7zlFzAZA2DQffawLYcrbGQCLeGHI2daT4Er21g+vnbVtsr4WPMD4K/D/s+ggLclgHMe8oV52bcfRJvZVLefjBP/2tbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401583; c=relaxed/simple;
	bh=i/CLnyw+nMQ2TgMubNSEMNs34QegnKmLA2Cz5CageE4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D7AGphE3uFaS4yiSPab7ZZfqW8g65f+FYCEIwZiv8eGATcq1cZKjyLtu4sdneWQIFH8XSTP9reC+E5M3TokdLIja5852RmpqzlVcjyd9ddgdAcGx5pmkhlBE6q7YillqwiNOVD0R621JN+etxnE99u/hzKm3Dfh8FBLL0EFw7LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=JGqojs/5; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="JGqojs/5"
Message-ID: <376eec65-20ea-434b-a6ee-edbc12e6d7d9@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1780401571;
	bh=i/CLnyw+nMQ2TgMubNSEMNs34QegnKmLA2Cz5CageE4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=JGqojs/50utTbI7LUjY19Lnf8FUKDgj0EFRtclDac5XMgqfBGPS4/eqLsDCSFsbTa
	 HFF8w2+Etw02Rhc5kwyFq44Vb0gbVs3o3YKIuJkyEcNQMk6UJ107SKk91FP5Uu3DSl
	 7cxarQKmOI5M1zO0mgujXjXSEZ4rhKx12ioXpX/A=
Date: Tue, 2 Jun 2026 13:58:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH v2] firmware: meson: sm: add stub functions when
 CONFIG_MESON_SM is disabled
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, kernel test robot <lkp@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <20260531-fix-missing-meson_sm-symbol-v2-1-1def8c3c169f@aliel.fr>
 <8c11a91b-cfbf-4b9c-a46f-907989bf8305@oss.qualcomm.com>
 <12d74340-0213-4f7e-a494-10ce147844ad@aliel.fr>
 <0c5033f7-1535-49e8-a502-426e54333496@oss.qualcomm.com>
 <59afecd4-7749-4be5-a261-a850634178b1@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <59afecd4-7749-4be5-a261-a850634178b1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/2/26 11:57 AM, Daniel Lezcano wrote:
> On 5/31/26 21:58, Daniel Lezcano wrote:
>> On 5/31/26 19:49, Ronald Claveau wrote:
>>> On 5/31/26 10:41 AM, Daniel Lezcano wrote:
>>>> On 5/31/26 09:51, Ronald Claveau via B4 Relay wrote:
>>>>> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>
>> [ ... ]
>>
>>>>> +#if IS_ENABLED(CONFIG_MESON_SM)
>>>>> +
>>>>>    struct meson_sm_firmware *meson_sm_get(struct device_node
>>>>> *firmware_node);
>>>>>    int meson_sm_get_thermal_calib(struct meson_sm_firmware *fw, u32
>>>>> *trim_info,
>>>>>                       u32 tsensor_id);
>>>>
>>>> Do you really want to compile meson_sm as a module ?
>>>>
>>>>
>>>>
>>>
>>> I don't want, but if I send a patch to change tristate to bool, it will
>>> raise a warning because 'm' is not valid.
>>> If it is accepted to ignore this warning, I can send another patch.
>>
> 
> [ ... ]
> 
>> Compiling the firmware as a module means it must be loaded before the
>> amlogic thermal driver, right ? Where is the dependency declared in
>> the module ?
>>
>> If the sm_meson is in the platform, it should be selected as part of
>> the platform's component. No need to have an option for that, no ?
> 
> The questions remain and PR is approaching ...

Sorry for the delay.
The module issue was raised by the test robot here
https://lore.kernel.org/oe-kbuild-all/202605310154.bmdMBZHJ-lkp@intel.com/

If I understand correctly we can drop this stub change and only use a
"depends on MESON_SM" for the "AMLOGIC_THERMAL" config, is it correct ?

-- 
Best regards,
Ronald
