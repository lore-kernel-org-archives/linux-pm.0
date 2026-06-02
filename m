Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD65359A8B;
	Tue,  2 Jun 2026 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406725; cv=none; b=s997BzzYeq71mEmYyVaLvYvQMdSB5Oad9dDRmYbJfISO6nZtcDyUriYDlT39vxSYYVSfOjesh4HynivX0vgoOMgiPuIEoiyvwLMursExGSj83kItW4Tabpbi4uuM97Ay8hGiYHg2EJg3d3Obr80lbxO/gYImucPULjBs5qLTqkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406725; c=relaxed/simple;
	bh=6zf0eOKWNxjE261YjrYLsiJDe7cUIoUxU90Ju/2Al1I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=h7guaHlbRB7ISV3OwGbtfbk/5UuMdfTqKC+pwj9MGhaz/H3UyUODmm+1t0XuWZvrRJkmfGKk9WRT3ZtBfTpdk38LU835kq7tZBDVVIOWF5Z3hkDfcNnMkFVpktTXh490XYwQxdyO4e6mGsozeimgqitna3GQvZrfJY05Ya2DYRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=Wfu2Hw/I; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="Wfu2Hw/I"
Message-ID: <5ed28c81-1991-4cf9-9e28-3b0b03111dd7@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1780406718;
	bh=6zf0eOKWNxjE261YjrYLsiJDe7cUIoUxU90Ju/2Al1I=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=Wfu2Hw/Ip/PzJUqBUs73DgMBgRc+u8BefBHRdIeNe2Bg1TCA6fa8OfxPai450B5ut
	 +giIaE88OXk7olYp7WJXnpEKkWQd37EMhEkGV6OUwXDMCzXYUVymt4vHi0cjkRmkGe
	 Ar6s8J7akKMFNJo20GZsv7+QWGIsdXvORvOrpMPI=
Date: Tue, 2 Jun 2026 15:25:17 +0200
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
 <376eec65-20ea-434b-a6ee-edbc12e6d7d9@aliel.fr>
 <49dcaade-4927-40e6-9864-9d4f3a8412d8@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <49dcaade-4927-40e6-9864-9d4f3a8412d8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/26 2:15 PM, Daniel Lezcano wrote:
> On 6/2/26 13:58, Ronald Claveau wrote:
>> On 6/2/26 11:57 AM, Daniel Lezcano wrote:
>>> On 5/31/26 21:58, Daniel Lezcano wrote:
>>>> On 5/31/26 19:49, Ronald Claveau wrote:
>>>>> On 5/31/26 10:41 AM, Daniel Lezcano wrote:
>>>>>> On 5/31/26 09:51, Ronald Claveau via B4 Relay wrote:
>>>>>>> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>>>
>>>> [ ... ]
> 
> [ ... ]
> 
>> Sorry for the delay.
>> The module issue was raised by the test robot here
>> https://lore.kernel.org/oe-kbuild-all/202605310154.bmdMBZHJ-
>> lkp@intel.com/
>>
>> If I understand correctly we can drop this stub change and only use a
>> "depends on MESON_SM" for the "AMLOGIC_THERMAL" config, is it correct ?
> 
> Yes, that is the simplest solution for now
> 
> Indirectly related, where is the mod dependency telling meson_sm must be
> loaded before the amlogic thermal driver ?

I think depmod should detect the symbol usage and add it to the
modules.dep file to give the correct order. Do you think it would not
work here ?

-- 
Best regards,
Ronald
