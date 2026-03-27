Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F504273803;
	Fri, 27 Mar 2026 20:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774643915; cv=none; b=RaW6En1Na+B3t4VPXYhxx3kjMfNAGONQwaE2OUya+Z2aQbMk3NlWIWggys7rBdYg4nnMtMtZvJKwDxtxgsFiFf9HIQfBDsfI9rXqdWRWcjjAERUcjvGar1OgjWgCiwd4DWQ7e06E0xc03EII/bHhRUY9OK/dUT3mROC+GH0YDNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774643915; c=relaxed/simple;
	bh=velu1am4+VNpqkfzGyKXqWSHvGvMVzzmAvWH2+YtEts=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=u4AvnJnxJwabg2yuZ+WSFteUhrzvIcx78F7yD2qYEtY5BkjRvb1AxGTyYbF8O7Xg0za3CsZV2Oa56Y9bI/JqfSquDT+JiTNhTEkYo7BRkoxZmicz4xPtSSrjN5+LxFvzO8eB0kMqqUrI3Mjfx6TzggVqpk3uM57QSHb/exlPGq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=KAp/Dnec; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=YZPJBYH4; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="KAp/Dnec";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="YZPJBYH4"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1774643900; bh=JrpWE3E6WVfMaCdcXTL+7Ee
	X9ScqCGdL5vmEJuenNCg=; b=KAp/Dneca9rUA1QoJ5vbE9VM52xETH0OIMpB16RMHQS1rwWXXN
	9S5tndzLZy9mTXJ4t0PMwUBBEfAugylgXpcXgdipWpMzXFUvZuNNHFLtF/Bufdk83JaBs81WcLP
	AZ0N+hT/6e6wX8GfjZBA5RXv7rZsnemKtsOfRgsXq/gCU2/3EOPkRMO5LEZzU1cwCrblEsLgJ2J
	61QG4OtBPeofGCi6nea48gHRwYM/hxIbkrEAMHJd1qbRu+u8kzMSBV6rDIU2KweMEodq8/Sx6k4
	wHCuQEA8ct4X4v5jdM0TG+SaXpG2LoB/A7e5B7Lhja2HsRWvIHZcmSMOZtWbGEqNnzQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1774643900; bh=JrpWE3E6WVfMaCdcXTL+7Ee
	X9ScqCGdL5vmEJuenNCg=; b=YZPJBYH4+g3k/3zsJvUayccpePSEyWtbOMbP3Mtv+R7I3vXf9N
	zC1P5dnV0mg48ab5vcnhf75ZznEeNCgzZPBA==;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 Mar 2026 21:38:20 +0100
From: =?UTF-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=
 <barnabas.czeman@mainlining.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Mathieu Poirier
 <mathieu.poirier@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Stephan Gerhold <stephan@gerhold.net>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 0/7] MSM8953/SDM632 rpmpd/mss fixes
In-Reply-To: <lv2ali4zgsfdh54yd74cx5mvec2z5kg7v4rkayyukpjt6juyft@vzprb3rvewkm>
References: <20260327-sdm632-rpmpd-v1-0-6098dc997d66@mainlining.org>
 <lv2ali4zgsfdh54yd74cx5mvec2z5kg7v4rkayyukpjt6juyft@vzprb3rvewkm>
Message-ID: <083d2560294855857663df23e8900f9b@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2026-03-27 21:33, Dmitry Baryshkov wrote:
> On Fri, Mar 27, 2026 at 09:11:42PM +0100, Barnabás Czémán wrote:
>> SDM632 pm domains are different from MSM8953 because MSM8953
>> is defining pm8953_s1 as regulator but SDM632 is defining it
>> as pm domain.
>> 
>> This patch series correcting the pm domains defined in rpmpd
>> driver and splitting the MSS resources for the both SoC to match
>> the reality.
>> 
>> These changes was discussed in a previous threads:
>> https://lore.kernel.org/all/2b057aa5-4416-4fd4-aeab-6bc23acbb53d@oss.qualcomm.com/
> 
> Was 4.9 never expected to work on MSM8953? Or did it require firmware
> changes?
There is no official 4.9 kernel for MSM8953 devices, all of them are 
using 3.18.
There are unofficial 4.9 ports for those devices but all of them 
defining s1 as
a regulator so the regulators were changed back like it was on 3.18.
> 
>> 
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> ---
