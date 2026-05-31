Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A19328631;
	Sun, 31 May 2026 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780249816; cv=none; b=AvJIF7wU47k5Uzw/TzaXhKOZUr+Aw2O5ePAl28hSRj74MDA9n4QqPLDJDhT1K0qpJQ3uULMGa6qSy0Ck3RAt3zuO3FCYdP8PkUVrjwqBbIJWnu9LS82J0AKUMb49IRLO94DNH1emLAr9SWS92eWqcgeqJAXcscP5Ck1fxrAl6mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780249816; c=relaxed/simple;
	bh=JQpEJWohU7u2PUrSQq5dK/MO03Qv9YI8notJ93T8T3k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GAZC+bW4+T1JP3JDGMNyziUff4/xHmqNYv874lgQ/wBjheKDLe1uCKjyL8YzMFdR9ujo+Igm0pw41V5Xfkh01I5oqdKOpaeY/qyCZUEeURF36aK5HAS+zH+GQiDEpmBPpMY6XhRGYvBD05wxMTcj+k65aQX/2h9G6fCNTZPLvKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=oJVEYD73; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="oJVEYD73"
Message-ID: <12d74340-0213-4f7e-a494-10ce147844ad@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1780249805;
	bh=JQpEJWohU7u2PUrSQq5dK/MO03Qv9YI8notJ93T8T3k=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=oJVEYD73f39ZQ8iUe8tM1mLjjbNxz4Aw2wpFEEW4h+E5It9PvmKzmqKDYSgM8dRCW
	 QmdyKnjKhbFuzVWjJHlmL4/ekhXpHSz8AXid6Fwhnpo5Iw5p+qp91UmNnJKACqV0KD
	 nK/0i3YsiVZdmB2M/Yy7X0I6YpjPuYYVPFIVp+C0=
Date: Sun, 31 May 2026 19:49:55 +0200
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
Content-Language: en-US
In-Reply-To: <8c11a91b-cfbf-4b9c-a46f-907989bf8305@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/31/26 10:41 AM, Daniel Lezcano wrote:
> On 5/31/26 09:51, Ronald Claveau via B4 Relay wrote:
>> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>
>> After merging the thermal tree, linux-next build (arm_multi_v7
>> defconfig) failed like this:
>>
>> arm-linux-gnueabihf-ld: drivers/thermal/amlogic_thermal.o: in function
>> `amlogic_thermal_probe_sm':
>> /tmp/next/build/drivers/thermal/amlogic_thermal.c:196:(.text+0x2f4):
>> undefined reference to `meson_sm_get'
>> arm-linux-gnueabihf-ld: /tmp/next/build/drivers/thermal/
>> amlogic_thermal.c:205:(.text+0x320): undefined reference to
>> `meson_sm_get_thermal_calib'
>>
>> Add inline stub implementations of meson_sm_get() and
>> meson_sm_get_thermal_calib() behind an #else guard so that drivers
>> including this header can be compiled without CONFIG_MESON_SM .
>>
>> Fixes: b21d88de6918 ("thermal/drivers/amlogic: Add support for secure
>> monitor calibration readout")
>> Closes: https://lore.kernel.org/oe-kbuild-all/202605291530.en7aGn7w-
>> lkp@intel.com/
>> Reported-by: Mark Brown <broonie@kernel.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
>> ---
>> Changes in v2:
>> - Replace #ifdef CONFIG_MESON_SM by #if IS_ENABLED(CONFIG_MESON_SM)
>>    to cover builtin and module in config.
>> - Add missing trailers for kernel test robot.
>> - Link to v1: https://lore.kernel.org/r/20260530-fix-missing-meson_sm-
>> symbol-v1-1-3fb672b989d4@aliel.fr
>> ---
>>   include/linux/firmware/meson/meson_sm.h | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/
>> firmware/meson/meson_sm.h
>> index 3ebc2bd9a9760..baecdaf263f41 100644
>> --- a/include/linux/firmware/meson/meson_sm.h
>> +++ b/include/linux/firmware/meson/meson_sm.h
>> @@ -27,8 +27,25 @@ int meson_sm_call_write(struct meson_sm_firmware
>> *fw, void *buffer,
>>   int meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
>>                  unsigned int bsize, unsigned int cmd_index, u32 arg0,
>>                  u32 arg1, u32 arg2, u32 arg3, u32 arg4);
>> +
>> +#if IS_ENABLED(CONFIG_MESON_SM)
>> +
>>   struct meson_sm_firmware *meson_sm_get(struct device_node
>> *firmware_node);
>>   int meson_sm_get_thermal_calib(struct meson_sm_firmware *fw, u32
>> *trim_info,
>>                      u32 tsensor_id);
> 
> Do you really want to compile meson_sm as a module ?
> 
> 
> 

I don't want, but if I send a patch to change tristate to bool, it will
raise a warning because 'm' is not valid.
If it is accepted to ignore this warning, I can send another patch.

-- 
Best regards,
Ronald
