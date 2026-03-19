Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405203ED5B2
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935872; cv=none; b=a5bLwf7R/lxse1qYN3DC7SIEAgnxjsgZ5Y25KaiOYvz3ttZ4VNAXqf2y+Fv9iemHZIgJoyuzeaBknl6KB5UtQlKReVsFmUJcGJjLgj0IH1o1k24e2+E/dDvxkZoRm7D+T9/3RI5lcbpS7ELwVfznQWTlVzgkDGcErJRdQmkqVVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935872; c=relaxed/simple;
	bh=U4GRtIXlAPJ+N8RHPzdWujLWnJfkTsO356fGf3wS/pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=e9CjRTZkpJIddKIWn4skwKDEzdzJhTNqGsSYbj1VhMZaG709Jc1MeIPQv2ijWyKaH88dRAYqnSF5PQUZT7+xjM0sgtVzntaloNh23xwDlPESNkbb/Kr9PYaGz0Yaeq5pDtLcezUDvYPO9IyNfzTy/sVW+DNG9Ra228hWyCrVehM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=a4hGFMUj; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a4hGFMUj"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260319155748euoutp02eb5a84f8d018b4b32a0664af02ec4161~eSUYLNI5m0120301203euoutp02M
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 15:57:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260319155748euoutp02eb5a84f8d018b4b32a0664af02ec4161~eSUYLNI5m0120301203euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773935868;
	bh=/SkmenYWfG03cyx26DQI0pNUhnOeHCO/bc9QSsDFeFI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=a4hGFMUjZQrJxLGlAv0a6Xv+ed/hDSCUPEp52Q1Tvit5ZroQsw4ct7+vBiyJJ/Pxf
	 KU/6zpu34PEJZXyXo7ze3AsA/qQSBfgxu4byZA1hsdUe9fN02d9xE98rtFPe5YAzoL
	 5ax71jDAP2+NQbUl51yNA0aGombxO+2o/gEupCCM=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260319155748eucas1p2b5301f0df591382d4f9d11bd0154335a~eSUX0VwA80213702137eucas1p2V;
	Thu, 19 Mar 2026 15:57:48 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260319155746eusmtip21015fbb23aff1c944126bee28a18b8b0~eSUW1P7_r0967109671eusmtip2G;
	Thu, 19 Mar 2026 15:57:46 +0000 (GMT)
Message-ID: <4809918d-fdf1-48c0-bc10-fcf75837cb81@samsung.com>
Date: Thu, 19 Mar 2026 16:57:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v8 05/10] pmdomain: samsung: convert to using regmap
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, Ulf Hansson
	<ulf.hansson@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam
	Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Peter
	Griffin <peter.griffin@linaro.org>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, Will McVicker
	<willmcvicker@google.com>, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ae31c62c940e99077d44e1935465dce7db0e4c06.camel@linaro.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260319155748eucas1p2b5301f0df591382d4f9d11bd0154335a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260319101424eucas1p2d5dca06240e8760046fb40507ffb3bba
X-EPHeader: CA
X-CMS-RootMailID: 20260319101424eucas1p2d5dca06240e8760046fb40507ffb3bba
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
	<20260318-gs101-pd-v8-5-241523460b10@linaro.org>
	<CGME20260319101424eucas1p2d5dca06240e8760046fb40507ffb3bba@eucas1p2.samsung.com>
	<CAPDyKFrprMSLOBMB_BHbi=j6UXV4dXBn-H8M1BsqDWNSCJwvuA@mail.gmail.com>
	<c5ba58fb-50f1-4067-a099-97169ea81f68@samsung.com>
	<ae31c62c940e99077d44e1935465dce7db0e4c06.camel@linaro.org>

On 19.03.2026 12:58, André Draszik wrote:
> On Thu, 2026-03-19 at 11:29 +0100, Marek Szyprowski wrote:
>> On 19.03.2026 11:13, Ulf Hansson wrote:
>>> As a follow-up patch on top, please consider converting the open-coded
>>> polling loop above into a readx_poll_timeout_atomic().
>> This has been tried and it doesn't work in all cases required for power
>> domain driver:
>>
>> https://lore.kernel.org/all/5c19e4ef-c4fd-4bf5-88b3-46c86751b14e@samsung.com/
>>
>> Probably a comment about that could be added directly to this code to
>> avoid such conversion and breakage in the future.
> I am planning to revisit this in the future and am hoping that we can
> figure out what goes wrong when using regmap_read_poll_timeout().
>
> Hopefully such a comment would only be short-lived, so maybe not really
> worth it? I can add it, though, if you prefer.

Well, I think I've already pointed what goes wrong with 
regmap_read_poll_timeout() in the above mentioned thread. You would need 
to use regmap_read_poll_timeout_atomic() and modify it the same way as 
commit 7349a69cf312 did for read_poll_timeout_atomic().

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

