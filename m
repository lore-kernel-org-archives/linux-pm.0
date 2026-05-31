Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAFC3264D8
	for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780216906; cv=none; b=e7e9BpGs2cwLJ3bFzMEXjdcd1c2RBgPdMrwN+2L5hvL2lnTtsJJVYfntuug7ZEA1UZ3WtH9gVKNuzm90t9e5wOXIK17yGRK2AmxrPjFsPzaQ/gXsBvnwU7+fsM15cZRHAF/9co/1M3TPdhe608LiBrcdNApEJ/vGkw8wM+DE9bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780216906; c=relaxed/simple;
	bh=WjW2TCULk7ImYaO1PL/U9lqUXRRTZGUQQU7iKntLWoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ke9D7pNl0jJ9+klKmOvHLRoPJfyMoMVBXgb3RW2GmtekzOUbH3Cmh7DxTyIp8A5y7lkKpzpkyO7ctvXi5WEqIWPpNSedXVWXTFFbZxgOPg7pGWboGUNuGo9M3UhjkwJh0IqPtYbDJD6v751MCao69LypDuRGCvLyawuqz2BRYig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cZ4EEOxo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LHBlHxnR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cZ4EEOxo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LHBlHxnR"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64V3eMfV1850478
	for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 08:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LSSHczkNGcyBGltE9n3/Qlzx5H59gm8hjXNQO9LCZb8=; b=cZ4EEOxo0R0xP1cU
	uqEA0gxK3qJB1dGa68+Nwb6j4ak5fuDQlS+mSQwNHLxzaWQugt7N/jSHX7xGjQHU
	/Wx7Biv29sb+3uEqCwmeL/3HlvBvd7Ez9cXTqGkIyr7H9GzeA1vrscAzIxVlcQTz
	QKPhnJiszl/4ncCOB0uKTz2mvSS+s8D1QTjL7TCYZe373Pf2EweWbOmho5rKUzlt
	iWmuHqsHfVwtdjZmdEqtxeCeGfm1drRIff/3atjIOM84xaQftodrJRA190q8/nup
	ezmg/o/mi5XtNKReiCHe7kjKMgR/E4o7FGHPRtGaqMmCHaIuIHdyZEd592EaJDY+
	2CMboQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efux52q1e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 08:41:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-516cde13e8cso201052471cf.1
        for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780216904; x=1780821704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LSSHczkNGcyBGltE9n3/Qlzx5H59gm8hjXNQO9LCZb8=;
        b=LHBlHxnRHCCgqLdecEXHfTMGAu27KQ7omV1851KNQxWERdG3JgsANpnFTZ5BiO2hw5
         If1hzlr5WuDiV3LagljqhmsqPSNArFh4JmYHvGO1iJUqGaaSPQJbBG5iZTYMARYEsGSc
         RPti7nHDNAP2FOxWGZc/noGpVkQA/1w/f4mGaLo+3mdWT0Iv6x059abRrXo/PG9IJjxu
         3JSLXdPpbEfp0eIiFjwohUehRPKEhuziHDbBoyf5ttLVdiUsvb1sBdDZmST+PrHge+Yf
         CZIsFGaxIs6YZjTt6N3KnVLAkUh/pVi0dPVU038PuCO6mlUKcg6hjv4Qk8vmzbMWFl3s
         G0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780216904; x=1780821704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSSHczkNGcyBGltE9n3/Qlzx5H59gm8hjXNQO9LCZb8=;
        b=Vks7pf6OBMuE6+5JTQiO+zd9IUuInzU90alaxaismuE5BQrZFDF4j0LPf3z+rwlPeF
         yIBkj0Tbup3EngDUjEc26WxihFIDOu0bcRSU4I+9TW9gZ5EHkkMj8aoSiTNOq1hFHSK3
         oYW6OWoBUMbcB+0McTy3W3pJUcb3DfWxJaSrMO1+jNmnEaG0OF9fxkCAv1EzKduOrhuu
         v4KuL2ntn0GqeqcjLWURWUvKhqGFOX4HXzjJKyUbHbIW7Abiiq0jYX8scfYHhL3kVk/o
         Br9wbpTP364GyshrRz4mKLO4dPEPfklF8TwdWT1iNp8Hp3RfJTsCB063/WIZcSy8674K
         L0fQ==
X-Forwarded-Encrypted: i=1; AFNElJ+KFOmm4PAz446JO4+Uui/k8nxPJ5tezb3jmJH1c0qFGvMbPC4opxjOzc5gk17joL04PmFQ2JyK3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mYsliv2CjwkVXRKr9I2h6uoJlyuWReV9UPZRzuElGYL1ocFG
	VSaQkux4T/9M7ujwddilFh/e+iM4QrZIxG4/YGm5h6uhhT7wSMoG7pQ3+ABqjXhVY4XOfQxfel2
	Du7TuoXBLmXpXzXf2VwrQW9reBBqiHOPPHCQdRYkLxqUfxXTbb9HuQdJ8lpuRTw==
X-Gm-Gg: Acq92OFVb1vikTGiSg5VKy9HQxJy6lMiEpm4gXbe0SVNsvFOZyGWXP4FKoU+muLI7KP
	ls8EPBfzS8md5VbynVl+QtcMb0k9uzYVtFQ0/mtXluOo/v+goFTEePxFr5Np03V+g3zZQHbqxnz
	a5of8RWndynCEK91+kbO6NcfY8DZHY6z1C8+KxWIJokDTNTs/Rmpt167Ce9MqiB+T5ELJWErk7N
	tv1m2b9q8CdEuwHiILOO1f2UWzULQwb/jnTJv7L4HuLdbrbEhvD/GDvX95IjnYbvzquNJE/XZRq
	FNyF0MS+grCM6YbsWifxyf5OQ6oVUP9ZqdfBiE2meEEcPAsp5yoy2XpxNs58KfAZvjoI8LF5q2S
	7bdtPbsAZujQ6E+/xfDgFGNNP+z0u9DL0m9cQNxApmXO8hkzRpWZkYo0uvdOwSb9GooEimIYB9t
	x3
X-Received: by 2002:a05:622a:4d43:b0:516:e031:9321 with SMTP id d75a77b69052e-5173a6ce03amr101633871cf.11.1780216903609;
        Sun, 31 May 2026 01:41:43 -0700 (PDT)
X-Received: by 2002:a05:622a:4d43:b0:516:e031:9321 with SMTP id d75a77b69052e-5173a6ce03amr101633501cf.11.1780216903167;
        Sun, 31 May 2026 01:41:43 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909cabfd6esm166065495e9.15.2026.05.31.01.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 01:41:42 -0700 (PDT)
Message-ID: <8c11a91b-cfbf-4b9c-a46f-907989bf8305@oss.qualcomm.com>
Date: Sun, 31 May 2026 10:41:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firmware: meson: sm: add stub functions when
 CONFIG_MESON_SM is disabled
To: linux-kernel-dev@aliel.fr, Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20260531-fix-missing-meson_sm-symbol-v2-1-1def8c3c169f@aliel.fr>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260531-fix-missing-meson_sm-symbol-v2-1-1def8c3c169f@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rfGW4rLxIetmL3gB8UeVpKYVyfzo9eCE
X-Proofpoint-ORIG-GUID: rfGW4rLxIetmL3gB8UeVpKYVyfzo9eCE
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a1bf448 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=QjikovrxREX5USwBPxUA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDA5NSBTYWx0ZWRfX51+jRUluOSKX
 ZqCd4INOqOAOTPkvGYlZrQEiH9G5fuTNiJu61TY6DxQeQQ7xMsm6en3AKYSXgvRn9ATlZgc/LTy
 KCulEXT5uzh+VYVMOXON/Wtk434QfoLhTn/xgfoT2SLVD2MgxCnfENEGq3lJoFTzMylCmjDR2CQ
 ku6+/GaxjVdGu8qYdXnNa1N1lNFKwzM+TR6vwVsnwefJwkPLoCBo9ufzleYlU26eSk0g90A3nzp
 nLc1MNSAZOR9wA/cfKFrjVtgiIb5akJjWZAqG04KSchvJY43xERpxkgSNp39PGOcsqO9UqnIGWI
 LQ1CEyBxfrPggtPoeiK3uu3/myrQh8dIsMGx6oTBnX7fk+6rs8HXXwJ9XdTsyxg4uhJXEDhjJkj
 jGpkJmKqTRrddwLJoBCRFWiCBeyimQLvwi9MMaVTTCI3K6XeMr5KG3SW9/CXzWnpKBnLDgPh5JJ
 /zlZqyu3czeyGHRf38A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310095

On 5/31/26 09:51, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>
> After merging the thermal tree, linux-next build (arm_multi_v7
> defconfig) failed like this:
>
> arm-linux-gnueabihf-ld: drivers/thermal/amlogic_thermal.o: in function `amlogic_thermal_probe_sm':
> /tmp/next/build/drivers/thermal/amlogic_thermal.c:196:(.text+0x2f4): undefined reference to `meson_sm_get'
> arm-linux-gnueabihf-ld: /tmp/next/build/drivers/thermal/amlogic_thermal.c:205:(.text+0x320): undefined reference to `meson_sm_get_thermal_calib'
>
> Add inline stub implementations of meson_sm_get() and
> meson_sm_get_thermal_calib() behind an #else guard so that drivers
> including this header can be compiled without CONFIG_MESON_SM .
>
> Fixes: b21d88de6918 ("thermal/drivers/amlogic: Add support for secure monitor calibration readout")
> Closes: https://lore.kernel.org/oe-kbuild-all/202605291530.en7aGn7w-lkp@intel.com/
> Reported-by: Mark Brown <broonie@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
> Changes in v2:
> - Replace #ifdef CONFIG_MESON_SM by #if IS_ENABLED(CONFIG_MESON_SM)
>    to cover builtin and module in config.
> - Add missing trailers for kernel test robot.
> - Link to v1: https://lore.kernel.org/r/20260530-fix-missing-meson_sm-symbol-v1-1-3fb672b989d4@aliel.fr
> ---
>   include/linux/firmware/meson/meson_sm.h | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
> index 3ebc2bd9a9760..baecdaf263f41 100644
> --- a/include/linux/firmware/meson/meson_sm.h
> +++ b/include/linux/firmware/meson/meson_sm.h
> @@ -27,8 +27,25 @@ int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
>   int meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
>   		       unsigned int bsize, unsigned int cmd_index, u32 arg0,
>   		       u32 arg1, u32 arg2, u32 arg3, u32 arg4);
> +
> +#if IS_ENABLED(CONFIG_MESON_SM)
> +
>   struct meson_sm_firmware *meson_sm_get(struct device_node *firmware_node);
>   int meson_sm_get_thermal_calib(struct meson_sm_firmware *fw, u32 *trim_info,
>   			       u32 tsensor_id);

Do you really want to compile meson_sm as a module ?



