Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798113;
	b=RDD3TRHbmnafZMk4X3oIEWcqg+P6jsohNxHtYsmmUxgu8GZPIB//QJNMAeyeS9vZ93oY
	 5zeo+s3hFV4WsqABiaoB3OieQL0Hc3ZfQhA4Lo+WqIot5F1nfW0T3+2eSVZq4Cpyz2i4D
	 YgZL1YdgYon0cXA6vWKJAdrhFMiSF6HLpfcVFFRseEL3fo8Tngkuvvqb8DJuelAqrje5w
	 TbYH+4gFPXEiz17PcguiVJv9djPsrT8+rb19ij2eRGWSMXQ21snEwFqY8zPG7Yqx8v0UH
	 uC842IZ2NGY+QK7328FVcvkc0+PjPxwjgOlYOIAFHK1Pf01cbJYhKsFHmqISVJnIpyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798113;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Xh9EOmcuI9wyEV/Jmo9i6NtzTlnDgJymp46o7FRpHF8=;
	b=qzt4uI38t0aoOASNMJ5gACQvrADL+aTf60WoDJKaJNyvg7GgdklNJKxLhqiFNjRShq4k
	 yqo0XYwhe0WqOZFfafd3P+/+H1kN0OIQLRuXICC+0Pyw1YzH0AdGOrWGENXu2ajzYLijh
	 ZOoVTx+rINULvZqOxvKnE+RxORHNHQBWHM7WqQwBmf1RlUy2IbqtTx/03pgc4E41I1kqx
	 VhIy+vqpYR9EBUw04F4gf27TY8c7IQTq4flyco0jHW7PWDx1qSQh4qaf4y+EQPht22UMX
	 oydy1iqhWQnx1I9Ztf3jX8Y8BDrkzuFAyqWHx0omHKx4W+knA8eMVdvM8865BtpVmjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cNnOeYV5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a3Pf2Fey;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D678F606D809
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 13:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D678F606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cNnOeYV5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a3Pf2Fey
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BZtlk1667542
	for <linux-pm@vger.kernel.org>; Wed, 4 Nov 2026 13:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xh9EOmcuI9wyEV/Jmo9i6NtzTlnDgJymp46o7FRpHF8=; b=cNnOeYV5Qx+nStdG
	2Ty3Uxe5LC7IKPsYJsO+ryjcl1DMmkJGy2p2um6SfkUYaneSsxr05OTL9Eq8lamG
	MqJQEFjAreX3XliKerA373JHZSxtSnxFvRmR3iDzEG7xRNwND7+lGWvDFJFdo4Aq
	lRUrd7grcvT7R7JHB3P/kur93Qt+MxBue+N/dtrGY5ovuj57Pd8u9YBPuAIO4r0G
	rys9n+k7BKZ9I61CDD0nfbvOEpNeBxBagKuSFmJbqkLjyz1WVbPgWz/mLOgGO2L1
	Ik/HYXhhwAYbOUAC/mk1gYfJcbVH1HyJlNrYmXwLK/gFdDe2VLiYaeC4FSjSM6zG
	GPSuYQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8nky66-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 13:15:11 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-821de0b7baaso840330a34.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 05:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793798109; x=1794402909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xh9EOmcuI9wyEV/Jmo9i6NtzTlnDgJymp46o7FRpHF8=;
        b=a3Pf2FeyxDc7LBcmIIlojpt88fs6HmuduBK+QjrI1IG8Ja6H/DSy4XeEamSpu3pE5N
         UX6bVBhrm8XWZ4UHrLXXwII6ZJPkvxGGPat8Wjflq774d6CWaz84Iko0oJpT5NqPjtn6
         uF7cmATs8kbpRThULfRndjAm6iAshW3/ozHKw5f9rMYxniFns8Gz4jdhGGiOaDsWd28s
         QIg8JL6m5IGoOXKqYmtivr0HKqMHLaJFQXBeskyjp5DsEb6XYuoGMM4ycJaDC83geIGt
         KNwbjDwKQoONUyX5/frqGj6ei88Zx3opQ1y3C5byttXexOmdhPO86iKxGnR9n8AmgBj3
         d15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793798109; x=1794402909;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xh9EOmcuI9wyEV/Jmo9i6NtzTlnDgJymp46o7FRpHF8=;
        b=xanP9vYQMpQ1WT2TqNVuUccXJWrGCjqdzIuKOrvIJdSd+ec2hCKNNiFTSKWCdiIQ/9
         RgpTcSA72NEP4CsEpUCJf8MlugVND5uboIm6xFmIquKvc1JCeKgvhH7bkxAUMW+wKHNd
         v+ST6/TykW5gkMBh2HuVSZ93peoRrxHNB754bVK49tE/JNC/a5qhA/v2kFmt/Jt06czD
         VA902xwSaLinkp7ihcdekS2GBrDp5BBFl86Mv4zIGaXg/n7fHcn7IxDQkfg8v1LUHSiD
         YiB908qXaAHo5X4DFdZAoPINwl/I9xgL8bmag30WCl0/unI/pdluATvBydbhOnr8dMdq
         h7yQ==
X-Forwarded-Encrypted: i=1; AKwUvBzIJH4G4KskfSH1WLZkYlt5wQVZo2E3/p5V4DTxL+BzgFgLvLTzMesTOTAuAtu326wQBBz4y0vsxQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z85guEsOvFFQzJZiMhsfUm2SByBP968T1efSqNo+4zJQQPQYn/v
	GAUP5o7ZxoYKxDy/iiyKcEofCci6dISrXF5qNSUmG9brezBwl7MbbpUrqiJRxInujAdNNqNBnIe
	4yl/QPsx8uypfXd9qWFgXF0gMr8bgvE1KI2qDZoxdaJrS8O+CZSg5AFReoeUh7Q==
X-Gm-Gg: AYBFou0FWjrbvRdVIn0ICnhRs76/jhVbLS8Yw+oW1QMSVm3wLLAg4rvq9an/7pJNO/e
	Yh4Hgv5KBYtpafwmNqmvwGVuC9HbvKW7p8hEEtyO4z2Hu0QxLlXibCuZ9mOFSdOTM//ewwjwIPw
	Jefoffy5GIShn06RortdInas8VEcEk8UFxy90BZmbxcHPJYkutOgU66+tXhL+SyrdEvBhddoUdc
	4I0hr1uWwXOjZLubn6MDNS9rRndN18GKi/o88N7zXC3YoJ+dPHJz3zor6BNe7+NIkIVjH7YLmpe
	XjWpipTW8yfXvnUpO6VdfN0960SJnl3XpGud7WdGhpPRVrCfTkaZirUUIILefwVO9rpz/cknbWa
	robg2kfHNYPVkhcB6XhM3Knkhw7Mvaan/HmoQ19wnsGAsCpEd4Am7Xvig6kcM9xxkUzY=
X-Received: by 2002:a05:6820:1504:b0:6d9:8fed:b732 with SMTP id 006d021491bc7-714f29d7767mr8519146eaf.56.1793798108815;
        Wed, 04 Nov 2026 05:15:08 -0800 (PST)
X-Received: by 2002:a05:6820:1504:b0:6d9:8fed:b732 with SMTP id 006d021491bc7-714f29d7767mr8519124eaf.56.1793798108043;
        Wed, 04 Nov 2026 05:15:08 -0800 (PST)
Received: from [172.20.4.37] ([192.210.17.203])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716c1317c7dsm1583094eaf.13.2026.11.04.05.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 05:15:07 -0800 (PST)
Message-ID: <d0a13ee7-c3b7-486c-b3a2-6c4fc06694ac@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 14:15:04 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/7] thermal/drivers/loongson2: Fix trip programming
 and add Loongson-2K0300 support
To: Binbin Zhou <zhoubinbin@loongson.cn>,
        Binbin Zhou
 <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Yinbo Zhu <zhuyinbo@loongson.cn>,
        zhanghongchen <zhanghongchen@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <cover.1793690276.git.zhoubinbin@loongson.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <cover.1793690276.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MiBTYWx0ZWRfXyYD3itOtv3eb
 eCgwOgXBZD9eIpG+e7wkrMGpxbPDUrpjY8C1ymmtyCzkC5O63gmBjug/2M3z2Z9c8k6IuvCZ/m7
 qrN2+bxk35LKDjTnlpO1K/eKUIGjfTMiZvBkRRgT3Bc5vJRqkgq4b1WlcH2yctcPkqGicuQKW1i
 DGWBcDSQTKLyP2kksktyaN6HJNV4JwUlFI8/hWFM+nhGv5mu3YVckYQQJM41AWrRoymNQtm/r90
 hLYIr2VkohUdddEhjAvYUWrQjSD23zDKrhbATu59iTM/winStMi8hb8gtoZVE5Npv4hHIaH+tqE
 w5mJ8saycRmZNqKuCqOtTR3sY+4fOxWjKREx52/81CT3ZmroYAbG0ATcER+GREltkIQi+Ue7Ets
 9n94iY0p+Fn91gSnLx41gbFysPmHWbn5h7SlYSUY8JbFnrIMWjJKQRrL4W2Wtyh+mNPT26ZaiVs
 GPIQ1oJqJ5TvAqAsB2w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MiBTYWx0ZWRfX3xsE7CZFqKgd
 CNr+mrbU7HEwgj4Y8LLuDRT5/up2lwdZ1AQHa+Tcr+wFP0kIU2Sk+fuR10JtY6e2vzJhPfAt9MH
 fHHmFPddrHYZjla35ZuW94xrJZuAzcM=
X-Proofpoint-GUID: uNL7st7oi6YEXe3dYsep-jgdwLpAwgQ5
X-Proofpoint-ORIG-GUID: uNL7st7oi6YEXe3dYsep-jgdwLpAwgQ5
X-Authority-Analysis: v=2.4 cv=As17T+9P c=1 sm=1 tr=0 ts=6aeb2fdf cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=3CSVYe8HblTQFsWiJzwA3g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=PsDKY8HSHSVfbGAcyQIA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040052


This series still has report from sashiko

https://sashiko.dev/#/patchset/cover.1793690276.git.zhoubinbin%40loongson.cn

On 11/3/26 08:23, Binbin Zhou wrote:
> Hi all:
> 
> This series fixes trip-point handling in the Loongson-2 thermal driver,
> refactors the driver around per-SoC chip data, and adds support for the
> Loongson-2K0300 thermal sensor.
> 
> The first three patches are fixes and are marked for stable:
> 
> - Patch 1 fixes signed division when converting negative milli-degree
>    trip points to degrees Celsius.
> - Patch 2 fixes the arguments to clamp() so trip points are limited to
>    the supported sensor range.
> - Patch 3 fixes Loongson-2K2000 trip-point programming by adding a
>    per-SoC register callback and handling the split HI_GATE register.
> 
> Patches 4-5 are cleanups and preparation work:
> 
> - Patch 4 removes the unnecessary multi-sensor registration loop.
> - Patch 5 moves the per-SoC ops and hardware initialization into chip
>    data.
> 
> Patch 6 adds the Loongson-2K0300 DT binding, and patch 7 adds driver
> support for the Loongson-2K0300 thermal sensor.
> 
> The patchset have been validated on the Loongson-2K series development
> boards.
> 
> Thanks.
> Binbin
> 
> =========
> V8:
> Patch (1/7):
>   - Use MILLIDEGREE_PER_DEGREE macro instead of explicitly casting MILLI;
> 
> - Split patch-4 into two parts: the bitfields section will be merged into
>    patch-3, and the remaining changes will be merged into patch-6 as
>    preparation for introducing the new SoC.
> 
> Link to V7:
> https://lore.kernel.org/all/cover.1791512067.git.zhoubinbin@loongson.cn/
> 
> V7:
> Patch (1/8):
>   - New patch;
>   - Fix negative temperature conversion in set_trips;
> Patch (3/8):
>   - Use writew()/writeb() in loongson2_2k2000_set_trips_regs;
> Patch (4/8):
>   - Rewite the thermal sensor registration loop to clearer;
> Patch (5/8):
>   - Fix `loognson2_thermal_set_trips` typo;
> Patch (8/8):
>   - Read CHIP_ID1 only when EXTERN_ID is set;
>   - Simplify the Internal ID calculation;
>   - Add the necessary comments.
> 
> Link to V6:
> https://lore.kernel.org/all/cover.1790561983.git.zhoubinbin@loongson.cn/
> 
> V6:
>   - Rebase on linux-pm/thermal;
> Patch (2/7):
>   - New patch;
>   - Fix incorrect clamp() argument order for thermal trip points;
> Patch (3/7):
>   - New patch;
>   - Fix Loongson-2K2000 trip point programming by adding a per-SoC
>     set_trips_regs callback and handling the split HI_GATE registers;
> Patch (4/7):
>   - New patch;
>   - cleanup: use GENMASK/FIELD_* helpers, add named constants, and factor
>     common trip point setup;
> Patch (5/7):
>   - New patch;
>   - refactor: move thermal_zone_device_ops into chip_data and replace the
>     Loongson-2K2000 flag special case with an optional init_extend_resource
>     callback;
> Patch (7/7):
>   - Updated the 10-bit output to 11-bit in commit message;
>   - Temporarily remove the implementation of `set_trips`;
>   - Remove unnecessary header files;
>   - Rewrite `get_temp`, separating `read_calib` and `detect_old_fuse` into
>     new functions to be called during the probe;
>   - Use macros to define the relevant numbers.
> 
> Link to V5:
> https://lore.kernel.org/all/cover.1789546118.git.zhoubinbin@loongson.cn/#t
> 
> V5:
>   - Rebase on linux-pm/thermal;
>   - Drop patch-3 for it was applied.
> 
> Link to V4:
> https://lore.kernel.org/all/cover.1785829933.git.zhoubinbin@loongson.cn/
> 
> V4:
>   - Rebase on linux-mfd/for-mfd-next;
> Patch (3/5):
>   - Remove the operation that adds `compatible` to the `select` node.
> 
> Link to V3:
> https://lore.kernel.org/all/cover.1785480242.git.zhoubinbin@loongson.cn/
> 
> V3:
> Patch (2/5):
>   - New patch for moving thermal_ops to chip_data;
> Patch (3/5):
>   - Correct spelling errors;
> Patch (4/5):
>   - Add Acked-by from Conor, thanks;
> Patch (5/5):
>   - Keep loongson2_thermal_data->chip_data as const, and use
>     data->flags as the private data.
>   - Renmae LOONGSON2_THSENS_OUT_10B_MASK ->
>     LOONGSON2_THSENS_OUT_11B_MASK;
> 
> Link to V2:
> https://lore.kernel.org/all/cover.1784619512.git.zhoubinbin@loongson.cn/
> 
> V2:
> Patch (1/4):
>   - New patch form Sashiko;
> Patch (2/4):
>   - New patch for adding chipid syscon compatible;
> Patch (3/4):
>   - Use `loongson,chipid` phandle replace reg property;
> Patch (3/4):
>   - Refact `calib_offset` calculate routing;
>   - Add LS2K0300_OLD_FUSE_FLAG flag.
> 
> Link to V1:
> https://lore.kernel.org/all/cover.1783670011.git.zhoubinbin@loongson.cn/
> 
> Binbin Zhou (7):
>    thermal/drivers/loongson2: Fix negative trip conversion in set_trips
>    thermal/drivers/loongson2: Fix clamp() usage for thermal trip points
>    thermal/drivers/loongson2: Fix Loongson-2K2000 trip point programming
>    thermal/drivers/loongson2: Simplify thermal sensor registration
>    thermal/drivers/loongson2: Move per-SoC ops and init into chip data
>    dt-bindings: thermal: loongson,ls2k-thermal: Add compatible for
>      Loongson-2K0300
>    thermal/drivers/loongson2: Add Loongson-2K0300 support
> 
>   .../thermal/loongson,ls2k-thermal.yaml        |  73 +++-
>   drivers/thermal/loongson2_thermal.c           | 359 ++++++++++++++----
>   2 files changed, 332 insertions(+), 100 deletions(-)
> 
> 
> base-commit: 4358090906b01806ee483229e8d7163b806bd116

