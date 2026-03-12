Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93873282F0E;
	Thu, 12 Mar 2026 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773301533; cv=none; b=FWg+mQvOqPEP2RaeoUihM+A+kGPXI7IJWB8wRCmETlOmeFXk79FChNigob3PK7hEhyZ96KAwvvWWM1zrgD5DYFiNXaeHhz0gj8v1p5eqALG1jgacHYh1sXqSzUMjKQ9Guy2TyM9QzNzrIruUDPmEbU5o/MZKoVhivM/IPeWWl7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773301533; c=relaxed/simple;
	bh=XjIyWo6sBf1wtax11firRqMIhml5w8X1N2yeZP5dL48=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=LAq3hQhRyBvEKojGT3xVGh+PeCBPk8Ns9Pwvet1/6zlgx5RO1JpfijaRo5Z/Nabz93Trsd3J/IJ8JUkJ+4XlkkXZhq92KoVhO4TG+8GJfUcKVqEHn9zIcVmFPEkYRo9anCK4BBmlsL+Fq4XHMsgZR6+xNd6i0y/4TzxLHB6Jhp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=WwL+dAsj; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="WwL+dAsj"
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
	by mxout2.routing.net (Postfix) with ESMTP id F0A8060244;
	Thu, 12 Mar 2026 07:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1773301168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGQFtN65jqZPHApCqR8fT1iH+UK6PY6v44zsFoBO/rU=;
	b=WwL+dAsjvDAwGuZnVMJgvw+33+ocdTXcPGYqWKyxtPC9CadFv0zPwLqzVKS/bB3ZOlOMKe
	BOfF0YtZEc+oTSCdBlCB4sqONtWFuk2NhKRDzkCtiyCun1BQOSsPf7F+AnWeb2uxhh8AE5
	Iyoh/UEenaJm83mHOngDw9ZmtPzgZj0=
Received: from ehlo.thunderbird.net (fttx-pool-217.61.148.188.bambit.de [217.61.148.188])
	by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 542F08007E;
	Thu, 12 Mar 2026 07:39:27 +0000 (UTC)
Date: Thu, 12 Mar 2026 08:39:26 +0100
From: Frank Wunderlich <linux@fw-web.de>
To: Laura Nao <laura.nao@collabora.com>
CC: angelogioacchino.delregno@collabora.com, daniel.lezcano@linaro.org,
 daniel@makrotopia.org, frank-w@public-files.de, laura.nao@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
 lukasz.luba@arm.com, matthias.bgg@gmail.com, rafael@kernel.org,
 rui.zhang@intel.com
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts: fix mt7987 thermal crash
User-Agent: K-9 Mail for Android
In-Reply-To: <20260311093519.15810-1-laura.nao@collabora.com>
References: <20260309064439.4296-1-linux@fw-web.de> <20260311093519.15810-1-laura.nao@collabora.com>
Message-ID: <8B371D2A-3C7E-4514-B495-9ED58FB60A80@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: 63a00dde-0e31-408d-98f9-570225501692

Am 11=2E M=C3=A4rz 2026 10:35:19 MEZ schrieb Laura Nao <laura=2Enao@collabo=
ra=2Ecom>:
>Hi!
>
>On 3/9/26 07:44, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>
>> On mt7987 we see a crash due to missing ops entry=2E
>>
>> [    1=2E518540] Internal error: Oops: 0000000096000005 [#1]  SMP
>> =2E=2E=2E
>> [    1=2E564481] pc : lvts_get_temp+0x84/0xc4
>> [    1=2E564492] lr : lvts_get_temp+0x60/0xc4
>> =2E=2E=2E
>> [    1=2E620900] Call trace:
>> [    1=2E631753]  lvts_get_temp+0x84/0xc4 (P)
>> [    1=2E645471]  __thermal_zone_get_temp+0x24/0x11c
>> [    1=2E656502]  __thermal_zone_device_update+0x9c/0x52c
>>
>> Add the new ops member added in 7=2E0-rc1 for mt7987 too=2E
>>
>> Fixes: a4c40559499f ("thermal/drivers/mediatek/lvts: Add platform ops t=
o support alternative conversion logic")
>
>I think the Fixes tag should reference=20
>"thermal/drivers/mediatek/lvts_thermal: Add mt7987 support", as the=20
>commit introducing the ops also updated all existing data structs (seems=
=20
>like mt7987 support landed right after)=2E

Ok, i will change this=2E Have not looked on order how commits
are applied=2E Both commits were new in 7=2E0=2E

>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>>  drivers/thermal/mediatek/lvts_thermal=2Ec | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/thermal/mediatek/lvts_thermal=2Ec b/drivers/therma=
l/mediatek/lvts_thermal=2Ec
>> index a9617d5e0077=2E=2E5671531d4c23 100644
>> --- a/drivers/thermal/mediatek/lvts_thermal=2Ec
>> +++ b/drivers/thermal/mediatek/lvts_thermal=2Ec
>> @@ -2026,6 +2026,7 @@ static const struct lvts_data mt7987_lvts_ap_data=
 =3D {
>>  	=2Etemp_offset	=3D LVTS_COEFF_B_MT7987,
>>  	=2Egt_calib_bit_offset =3D 32,
>>  	=2Edef_calibration =3D 19380,
>
>You'll probably need to define num_cal_offsets too, since the number of=
=20
>calibration bytes was also made configurable (not sure if this is=20
>already addressed by a separate patch)=2E

Thanks for pointing to this=2E
Should i change in same patch or in separate one?

>> +	=2Eops =3D &lvts_platform_ops_mt7988,
>>  };
>> =20
>>  static const struct lvts_data mt7988_lvts_ap_data =3D {
>
>Best,
>
>Laura



regards Frank
