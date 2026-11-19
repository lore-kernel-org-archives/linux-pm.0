Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088502;
	b=uNqfB4CIv5dmkyCBfeqfjCaZ4rkmm3KlV4CmSlFFP9skyc/PWDlN81xdlb9vBMfXDuTO
	 JVUBhwqRKpDT8dm7P4T0U7syPTkcFM17CVp+Sy6K7AI15ERhh76pA0EbM8kvmM0Vj4ws9
	 tmePd3UEyNOkYzLwMRnDCLch7P5MjVJbZBGjty6/j9mksDrNcGRBSphEkLmWTi5O8cHMv
	 jmmyuNK1QJnTh/ZKklnZ7PJ6l9W86l7fOXgDQqD9JImWiPMKf/W1UDKHnaRHZdUEYIQ0J
	 MFD8Cia1deABuXX1Exrv8boszGzWKUrmUOFx4sr3qD4QTLJsBaW5hJTFsaIOna6anIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088502;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VCII3XX/ebKpfvWD6KeCp48twovV+5/57+Y9fRp2vzk=;
	b=d3/rzpuakUGSAHR4exjpZr2okwRLgaLCuamB6K+Wibd+ShubimfHZjQltxkUYbgkLSMh
	 Hxo18CqZXdVYz5giedwgY/moa0tbHT6U75sMrGQoXO817wvYYSroTeUeg0fsVsnvUQT7K
	 tXtsDk7DAHzLyGwWmVVqtjjPFTXtioJf7wXU5WaV/FV5ITW3qBgIgbzwmn+UceJ+0T+mg
	 b/2ORAubKsKD4H5jo84Xi+MMgny5oUk6YwqC3hkEyKiRoRQoaaM69JK8gyg1RTDlDuuAN
	 4k0PYTeYZWJg8MVjIoLCG99ulYsalsXVknuW4cjnxqjiPi3Yktda+VgxcKInGesb2ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EMzUx5FJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IQao0rhy;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6AB606A324
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 11:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A6AB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EMzUx5FJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IQao0rhy
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJAufFQ869586
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 11:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VCII3XX/ebKpfvWD6KeCp48twovV+5/57+Y9fRp2vzk=; b=EMzUx5FJsZPwXonV
	qMvhlpaPfvRT2YQbRmsY/ZrX/OZnOAKLCxdwu+9eTRFgbtaMb5Ny+XuvsmaXrC3/
	i2zK0VZisTWo492QWv39hKnIsY1IFwXhZT/NdfmMeZMpX9/g3wJVOfKFOXojv+2E
	2k0Htmzi8l6toB0fgSbLP4LKHuKlxVYULIa28Un9yE1DcEHz2RH2VeWXIk0Aptkk
	vnOOhxFAOsdA7LrFY1A4dLlm6oykJayRyOudgONhaHc9r2TwjuE3mMDrOznrECHD
	oyDZ/LCZOdh7graKgFZAdHQNwif0SV411nELOOm05+zdb/SZ8kwk4afwOrkDLtgn
	nY1OZw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1fpnmb18-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 11:41:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2efe331887aso16862655ad.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 03:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795088500; x=1795693300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VCII3XX/ebKpfvWD6KeCp48twovV+5/57+Y9fRp2vzk=;
        b=IQao0rhy7TsQVGfFQahNkFb7lXuGyUaKMaUivVbZkLt6+LIr9bPLlCfGUoOUfHklBs
         pf+ibBqzjJFU06mmRumoMHJc7cXGTXqZCoEuwnofxE+MX2UoxfBSJmpoH1tP1NKwdE9C
         z8m0mkUuwQyx1ePunP2npvYhGbTm0v6sbKSGmTMMR86PjlC4arO9fZ/rtEmzOOne8aWS
         ITvAx6AD5POoXKgK4WOLdTXG5KraVfzDgNRq7AsH+HJB7OWHwZdBALH5D7vPAKNq2nnp
         2XuYkBzUHFsyyYCphz2vVvpzImvLcfG/5y+J2YErt7m26He/1zp17DHLQOI4daqa/xgH
         AWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795088500; x=1795693300;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VCII3XX/ebKpfvWD6KeCp48twovV+5/57+Y9fRp2vzk=;
        b=BTqBqfOL7fzsQMXUwjYglDgEfsdQj6+Ku5gWdjoBzFOQyk5wW3Doi4EEVuG9jtwPvU
         QQ6OX1NlTXeitIe3vxtALW/geaLaBQfUMEDs3t/bhsQp4pHoKupiYcH2AHi1km5rXZT4
         gIK8+VIKFWYmFNQWI/VsQsoqTtRfuyNrTdhKLM2P583a0lOa0NTsIAQfgyHVXSES8E4n
         f7xKuEmZzIAqs0X22Ip2rNZ2FKBdv0mr2R1VgwA0JbUcIYLD4CJU/EBUXUAl2czPgG8Y
         T/s+2KS33zEOzR0wyLbM52u0v1dOQkv+mnMs/ibXWh3GhLwD2BQ0EjzGcOaBdQSJ5Fjf
         oaUg==
X-Forwarded-Encrypted: i=1; AL+hErEdwAIu7cEbBDb3l76n12Z0DHigFor7+V2sw3yiqt50B6+qJqjS3KM1+jiBpi+prXo/epQIG0vtow==@vger.kernel.org
X-Gm-Message-State: APuU4Z/QzXAL0TTIidbJ9ctH8jVx7V6gPh+UwMmPpqgFOnGGBmq1MVrX
	3CcG96o7jE5pezTnOSOxjkK/ZCb2mQL0aQi2AvcPCGefAoD2DqiMI8VR3kaFARRk0wUAS+BJEta
	6UC1KEuqQtrkvynrx+FXWBDwDA+cIs2rQ7WsElXxf679KZqofY6czZOgGuG/kFA==
X-Gm-Gg: AZFdTZd2PAoydukrclQzPUrCjwbKvQR/tYYBPF9qQWpp/y09NlQRgMKNPoX1kytpYyg
	4UEgWplqEavoSosMz7Q3CvMM/WrbWr0Fkl4vuVfHaMsTwqlva8Zq/O9bCHjmXR3FaAjetxrcFvl
	/h09aFUckVghDXo9AaZkyXdrtD0mSVIt+Q7ndY/VyIV7WA+hclMsQ6PjWApR5LCWxDW/LVceMTZ
	mbHVJDVl2VNBS7vL1/Se26viD5Pv2hbWAj34nHIARqz7hEJ4s8/+PvQ7ZJOSWrhvlMoEnHss9XT
	GdBhtN299wt2HKygxxcg6978LAk5NO/RG4KgF0z+xyFfU4ymHuir/717db5tTSe227Wls2sEa4o
	FjnwXiekdKp2njJLoDg9fIIVoKQvQgznuXeIcVaeNGgKzpAEowhOn2/ta+/T0UWVRUryGZvKOeG
	EWX95M6nMaz9P6SIF0tFTwVUXYSEYqhxRxOMk4DYxt4w==
X-Received: by 2002:a17:903:2b06:b0:2e6:136e:f264 with SMTP id d9443c01a7336-2eff753ce5cmr53624325ad.50.1795088499948;
        Thu, 19 Nov 2026 03:41:39 -0800 (PST)
X-Received: by 2002:a17:903:2b06:b0:2e6:136e:f264 with SMTP id d9443c01a7336-2eff753ce5cmr53624135ad.50.1795088499431;
        Thu, 19 Nov 2026 03:41:39 -0800 (PST)
Received: from [10.133.33.68] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f021fdf305sm11054485ad.5.2026.11.19.03.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 03:41:39 -0800 (PST)
Message-ID: <2698e091-17e9-4a1d-acf1-19981ee604da@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 19:41:34 +0800
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
Subject: Re: [PATCH v3 0/9] cpufreq: tegra194: add Tegra264 support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: bbasu@nvidia.com, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261119111217.902071-1-sumitg@nvidia.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261119111217.902071-1-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7zVlA-xBE6dEWpw3QmfamnOeEQV4A7M8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NiBTYWx0ZWRfXy+ihepyJdJW6
 4kTmUQOJyVv43G9b9bfZ62bNgG5f7xGwvJhq6i2eD577qL5NKJzV/u3VUofsvboBN1xLsGSvsiQ
 QfVcwfeV2qusku9IsDjuvf3IASp2AE+iBK8FzQNG1kHZouuRYaE3QrgFpKGT0kRAnYbP7zmJ5Qb
 1RFmbbJKcO8Wl3lrBZX2gbmiDHhkWMRfSYVj7jwfvgzjbtdY5WjxndYez9sVSU+dxyKDFEAk6Zu
 OiWkw0tv7nN+MA/3B2WxBBM0fyv7R1p+A8nOX240pJ3TYi8lyWZ9PcI2R9ImbfY6BcF06ZPBll8
 wACbVwpRL2VQWVRoA1yoKFnChTS8S01BdSeTgS0MGheOs+gTMZQlZu3oMTs4loanGcwegxdYP+O
 llNg8OA0XBAec3ySnEThYKWKMYUKhU5MsvH0KyuHE7uppyQvR5SWof7zJIKjCRSUiE9lwYjl5oF
 2BsnTsxuwAPCwVYKqMA==
X-Proofpoint-ORIG-GUID: 7zVlA-xBE6dEWpw3QmfamnOeEQV4A7M8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NiBTYWx0ZWRfXxrd9r1TDzsV0
 j7CJi3+7cUKeoBUVCNGutDJeF7D/BLkK7oZvphTbJZ8/vVf4614dkGR2G+W6TlfOoLdSQFlSA8x
 6w4vcSihxTaf1oA3oCYW/63sFFs7QdY=
X-Authority-Analysis: v=2.4 cv=PJ6aavqC c=1 sm=1 tr=0 ts=6afee074 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=I7BNmAFbTgjmseqQuzQA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190046

On 11/19/2026 7:12 PM, Sumit Gupta wrote:
> This series adds cpufreq support for Tegra264, which joins the SoCs
> already supported by the tegra194-cpufreq driver.
> 
> Tegra264 keeps the existing model, where BPMP provides the NDIV limits.
> The driver derives the current frequency from the core clock and
> reference counters.
> 
> The main differences are:
>   - Frequency read: through system registers, as on Tegra194, but from
>     the 64-bit architected AMU counters. The reference counter ticks at
>     the system counter rate (CNTFRQ).
> 
>   - Frequency request: through MMIO, as on Tegra234. The driver writes
>     NDIV to a core_freq_req register in the CCPLEX register space. Each
>     register controls a clock shared by two single-CPU clusters, so both
>     CPUs form one cpufreq policy.
> 
> The patches fall into four groups:
>   - Fix (patch 1): read each CPU's MPIDR from a CPU hotplug callback
>     instead of at probe. A CPU that is offline at probe then also gets
>     valid cluster and core IDs.
> 
>   - Preparation (patches 2 to 5): cleanups, mostly of the counter code,
>     to make room for a 64-bit counter and for an MMIO mapping without
>     ACTMON counters.
> 
>   - Improvement (patches 6 and 7): group CPUs by the generic
>     "performance-domains" property, which cluster-based grouping cannot
>     express on Tegra264. Device trees without it keep the existing
>     grouping.
> 
>   - Tegra264 support (patches 8 and 9): the driver support, followed by
>     the device tree changes it relies on.
> 
> v2[2] -> v3:
>   - Patch 8: read the AMU counters with interrupts disabled (Zhongqiu).
>   - Add Reviewed-by from Zhongqiu to patches 1-7 and 9.

For patch 8/9:

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> 
> v1[1] -> v2:
>   - Patch 1: drop the cpu argument of get_cpu_cluster_id() (Zhongqiu).
>              Check for a bad MPIDR in tegra194_get_speed() (Sashiko).
>   - Patch 7: check the BPMP table in tegra194_get_speed() (Sashiko).
>   - Patch 8: fail probe if AMU is not available (Zhongqiu).
> 
> Sumit Gupta (9):
>    cpufreq: tegra194: move MPIDR read to CPU hotplug callback
>    cpufreq: tegra194: remove duplicate counter sampling loops
>    cpufreq: tegra194: add tegra_counter_delta helper
>    cpufreq: tegra194: add per-SoC counter mask
>    cpufreq: tegra194: split MMIO mapping from ACTMON offset
>    dt-bindings: arm: nvidia: Document the Tegra264 CCPLEX cluster
>    cpufreq: tegra194: derive frequency domain from device tree
>    cpufreq: tegra194: Add support for Tegra264
>    arm64: tegra: Add CCPLEX cluster node for Tegra264
> 
>   .../tegra/nvidia,tegra-ccplex-cluster.yaml    |  27 +-
>   arch/arm64/boot/dts/nvidia/tegra264.dtsi      |  21 +
>   drivers/cpufreq/Kconfig.arm                   |   4 +-
>   drivers/cpufreq/tegra194-cpufreq.c            | 456 +++++++++++++-----
>   4 files changed, 387 insertions(+), 121 deletions(-)
> 
> [1] v1: https://lore.kernel.org/lkml/20261104181521.3003578-1-sumitg@nvidia.com/
> [2] v2: https://lore.kernel.org/lkml/20261117154954.625126-1-sumitg@nvidia.com/
> 
> base-commit: e8017d29067fd1310a65c3494ce1a1b492adbac6


-- 
Thx and BRs,
Zhongqiu Han
