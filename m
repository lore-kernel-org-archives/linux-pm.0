Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBCA383C86;
	Wed,  3 Jun 2026 05:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465024; cv=none; b=bmtI0fSiv+WWkTqfhbiefdorKmpypCRCXlKLBCmy5A2Q/Ii/HwvKRpKYnFk/OWLxExLyuSB6CUSKY93pVgG4ceQkx3xllGZ8dQRnWfkpk2xVNaTJ7RZis/aPKhGxEBwUg9KWbaBVWHHNNSXWM9i9gdqqfYu3ReSMJeG/ZO30lz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465024; c=relaxed/simple;
	bh=hi6gNubcDNseMOAElaWu/w1hNneeIoZV+WFrRdpCF9s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QVF5zhMfN/+brwlcdhJSAdbZgHERLEPuhYKcOxy2Cs9pYfKnSyimB5qUZr8iRFJ1vX1pw8QGV4lGm3moXe+77HwKMrSl4LpnQxaZ2nozdi7CABDMATPv4iljUwBuLBDMSTtq6KCh4qJOf6JgN3753dTKkZpTnfj+8LvsWly3Enw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=qtoo+ItV; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="qtoo+ItV"
Message-ID: <3f94dc8c-82fc-4941-bb16-408d01da5280@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1780465013;
	bh=hi6gNubcDNseMOAElaWu/w1hNneeIoZV+WFrRdpCF9s=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=qtoo+ItVSgx3QVaOmiMHqXPvOKNpzvlJ0ZuCigrvHBUv1h+AZMT853NV33ZVXw2vw
	 AcVvpEKC0aPhU+PlxtixDUbN1/gTPRoS9WAWgoez+tm/pFDFRS9iwtxOgD2y7NT11E
	 2ceszJZ7Uqs4w/amue08R5U29pZjO2nhRU49+ThA=
Date: Wed, 3 Jun 2026 07:36:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: linux-kernel-dev@aliel.fr
Subject: Re: [PATCH v3] thermal: amlogic: add missing dependency on MESON_SM
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
References: <20260602-fix-missing-meson_sm-symbol-v3-1-6f7f69cd7d6c@aliel.fr>
 <f5118303-d7ea-402e-84d6-794d6860f992@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f5118303-d7ea-402e-84d6-794d6860f992@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/26 11:08 PM, Daniel Lezcano wrote:
> On 6/2/26 16:19, Ronald Claveau via B4 Relay wrote:
>> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>
>> The amlogic thermal driver calls meson_sm_get() and
>> meson_sm_get_thermal_calib() which are exported by the meson_sm
>> driver. Without CONFIG_MESON_SM enabled, the build fails with
>> undefined references to these symbols.
>>
>> Add a proper Kconfig dependency on MESON_SM instead of relying on
>> stub functions, which makes the dependency explicit and prevents
>> invalid configurations.
>>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202605291530.en7aGn7w-
>> lkp@intel.com/
>> Reported-by: Mark Brown <broonie@kernel.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
>> ---
> 
> Applied, thanks

Thank you.
I think it will need a reorder for bisect to be ok btw.
It needs to come before b21d88de6918 ("thermal/drivers/amlogic: Add
support for secure monitor calibration readout")

-- 
Best regards,
Ronald
