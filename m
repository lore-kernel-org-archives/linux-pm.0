Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1DD4D37B1
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983288; cv=none; b=glzUoxCdTihyoR5p5RIsmjrYNQDqPeqL0WG+yYfr6n/PRxOQPv8vb2g1SA1z3V5zqCOxRNr8ksxuvc4DO7uVNGVtFdCrgXOfJJcEHydKeuYRmi+nb3fInaExA7nfeZbu55H5bWNqwNmSQaDq+djBp3KsyhoFRbenk/rthmgmSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983288; c=relaxed/simple;
	bh=mFAeI1Kbat1wqbu2WyXO8Jw3D1ixAbjDqGG0r/VkSMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrxgfzK+cA22AlFxIAgRLTNoQ/WIZaAmv6cEEU/9H3heAbzPcPG9L/zR26TT4eqIS4sLP6ZjfEp3OZ2mSqFDiJsZmer/IVUZSYWsdR8LqChqqFbUIPbGxs2SxyHfStTx7Cwiwdy1YgCX8sfvofXcRYf3rNseCo7hlMBxHnVn1Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZmM7Z+9l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G+P2cNfT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZmM7Z+9l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G+P2cNfT"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EAR0C4466149
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2BzdfN9MeKD+vw8vNIfy4bpFCE2wbRiJT5GCxWv5jxo=; b=ZmM7Z+9l2TnQ7NFT
	jtVKnbUfei6VSgGmBY2io8fVrlg3QWdOutVkBEu5mb5fP1VTYuBjGxKmi0M3O8DQ
	lbMySfC517SUF6p+dJN8bnmniTZc5e53YdEG46KrQfKsksaePtf2vg1BZH7KCqZ0
	TLhHg/qw8zbbuE2HVs4JUPbDrNqR+vYNDZRv7KHq0cjH+6taKmUP3qDKMIKqAw3z
	NoAgPKX4BH9Q+wMUFwH1oYjLBaOEtCwDXc7y5MEhAl8gEbKCQ3KKRobY+g2qXjv2
	fFZZjjMMA8bbtDtL0zXcf95uzoVGZdm/TZOWFHLF5dgTYU7j7puBE5MXIHoJE0zp
	5IAu3w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha80crk50-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 13:08:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cc19d8e59so41547885a.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 06:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791983285; x=1792588085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2BzdfN9MeKD+vw8vNIfy4bpFCE2wbRiJT5GCxWv5jxo=;
        b=G+P2cNfToEbcowcGxQ/2vJP3DnpQJpx8utIKOEpJ52FNkIrQI1LyjlMcMIMkJJ5UjR
         9hyL/ZrRcGmVutly5DxInvl2zyDZ+DWMc3QdU7eqWDwrGXbw64h94dqVERhIP6mf4ncO
         L4BlopeOQhz81ryNYJkDcZ12jABQHWo6glpkR+lB2qKAnUW22fWFdmj1k+YNBstg53Js
         7WvhWlVeksBdpWZPkr9dpKyUjKKO5vD4nSpcjA/dBBi/4jhSA25v++MhVxm8yO+RTY6q
         zNQQPk1Tk/6w83xh/+Ykb8Vz1y7XHlZ726sckbqvxujeP1Tcgvypso51SSrGb0tDpY2O
         Y3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983285; x=1792588085;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2BzdfN9MeKD+vw8vNIfy4bpFCE2wbRiJT5GCxWv5jxo=;
        b=FR92fdBEch2oFtKTZr0Z5ujF7aVrJrUPcFnLV7RRVnqDKjQ+c7ygW/aug3UJBnv8db
         4G6BQ1hUC89Pz+iXAaDOCmJ+tdAn6fIvapYdO+Oi1wzHQWV2sywt5w8lgGfqtAdtayUZ
         mYk/e1EAPro8CGQrlLSwXI3xfwd6UxmawxG6CTeMsZRS1uV01P64y2tkGibFju1+PrJN
         oKGXfyX9DRwiCkHJWKrqDGsdkQCDyL88lt3BirhznPt5TC0RmBzzGj2wj4tqfH9cA72i
         C1436OiTc3SwJJakQhxo3puauZHQK3i+vqaBnxPwnMQuk2k4P4AIC3KAoEAeOI4XOvoX
         AW9g==
X-Forwarded-Encrypted: i=1; AKwUvBzhKz/SJ1Cd+IUOr72n5gADqBcXO/xTUgv4gM+N57bfRye9omd+DE+JpCYYIKyVaeN4TVb7/2qNKg==@vger.kernel.org
X-Gm-Message-State: AFq9FYI6enzsQdq6N/hIG/7QAX/x0DS6ZhipC7UeFNXftyAI9f6LiZie
	7MPNk43j7RTWa4H8imCg2oj3l4F0HafhkiKPSb4nnJkLbVrEMCdp62d6ITCeq7EIq2fn7KDquAa
	01Jj3IzgZCH4Gw+h2ZRaa818+fN1R8iH1O05u8xBO1iF/BNfUzKQFKfw6a4WeHw==
X-Gm-Gg: AYBFou2bFZ4qGx4rZqoYli9LJshvGoH2KiRbDPtVL7G7TABCydKlsb3olSu+KYQN95w
	tKauk2+LCTaYStXHpsEx+J+mdagI9gOt+X5bkpReWC3JTC2fla11KmY0btKRYhoiZLvCe5Mm87B
	g7vNVcBUiMyHlCm+I7YXY/DW0pWqIHnDtzZLxcLGSySn6nCb2FfnUPc+fLVj3zNPooYbrbZLA9l
	NJj3fMdyAyWwnN6lReyX17KrDin95xo1FUVoyzj2fiW+5FzwayCdgs7f5eYAOjt6/pSu77/8hB1
	apyCyyvmS/e6USzv2foSqg2y/XLCMT1+tEvda3gveGAAse4X7h7dwiBZArSz4de8rjfYEhgSk94
	5IZSkkZtUqDMa7Ab9LenUyQ==
X-Received: by 2002:a05:620a:8084:b0:93e:571e:94f0 with SMTP id af79cd13be357-93ebd1eabeamr2865610985a.3.1791983284156;
        Wed, 14 Oct 2026 06:08:04 -0700 (PDT)
X-Received: by 2002:a05:620a:8084:b0:93e:571e:94f0 with SMTP id af79cd13be357-93ebd1eabeamr2865600085a.3.1791983283581;
        Wed, 14 Oct 2026 06:08:03 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be33d90ce5sm640484e87.59.2026.10.14.06.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 06:08:02 -0700 (PDT)
Message-ID: <1807728b-2cf5-4594-b353-267f09d35548@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:07:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] power: sequencing: qcom-wcn: support SW_CTRL wake
 IRQ
To: Linghui Wu <linghui.wu@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX9luZHtDtDJys
 Rc4+8XmP/MyMf5tCLsUf7YDgzjF9HpM6/BovLxZvvRfx09842gLQb5+zv0ywR7OwRCTOqL/8Jpv
 7iTcUBw1h2UMQ7MLoDgsL/jzIfa4iXQ=
X-Proofpoint-GUID: 2y6WCF-rxuuQl55fttne4Ob63zVfQqa0
X-Proofpoint-ORIG-GUID: 2y6WCF-rxuuQl55fttne4Ob63zVfQqa0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfXwGO3qE03slNX
 OlZ1Q2x79rKOGnUoSdOl50SyPOxwxNOpdOylkBhkm23uA991a0539ogzoB8YBbOLZzI0JxeB7cu
 EM4aEx5NJYVd5CkwKYJCpfBtcYCenxUpHcsCwheETp+pH6B5wA6ZwbE37KDNwDhR52YrgxNO2TP
 n/ozmvSk3OsqcV5fMiIWuTc88hLtjzkaAiAulM4CMBTuBjsueX6/JlmWyRBA5R0mva+vwkoAYZD
 UV92Sbdsg4/FMVcqti5Y6z/IC5xq7ey/AIVjkEgE4tFi8VjjHfyWLjfLcmoVGB0h66yux2GzAMZ
 KHVamKRW6Zx/4Eg4hHV0Ks1U6hrcmxqs1InAJqHdxdNYSgcUuWmkrZVlKWX17sI+cNWAhjlLSCL
 rir2Pf6DUsZyb72g7TYk4qDPAhwpcFv8A9no9Rrdhh0DRvuxq54+3aB68Ds52N5ZzVdaq4J6wwE
 Xx+KfmDJELBsZqPtZXg==
X-Authority-Analysis: v=2.4 cv=JegpPkKV c=1 sm=1 tr=0 ts=6acf7eb5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=4stbDPrVBKr3fIij-fIA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140052

On 10/14/26 2:19 PM, Linghui Wu wrote:
> Some WCN3990-family designs connect the SW_CTRL output to a GPIO on the
> application processor. On Shikra, the WCN3988 SW_CTRL signal is connected
> to GPIO88 and is used through the MGPI/AOSS hardware path to request the
> required RF clocks.
> 
> Qualcomm downstream kernels configure this path through
> msm_gpio_mpm_wake_set(), but upstream does not provide an equivalent API.

This information is not useful to the reader who doesn't follow the
Qualcomm downstream kernels.

> This series models SW_CTRL as a dedicated wake IRQ. Requesting the GPIO IRQ
> resource enables POWER_SAVE_WAKEUP_ENABLE in Qualcomm TLMM when
> WAKEUP_PRESENT is advertised, while the PM core keeps the IRQ disabled
> during normal operation and arms it for system suspend.

This starts off good, but zooms in too much on the specifics, instead
of the functional outcome.

> This is an RFC because the intended hardware and software model still
> needs confirmation. In particular, please advise whether SW_CTRL should
> be represented as an AP wake source using dev_pm_set_dedicated_wake_irq(),
> or whether Linux only needs an interface to explicitly configure the
> TLMM/MGPI power-save path.

You threw a lot of Qualcomm TLAs at potentially non-Qualcomm reviewers,
so it's not really possible for them to give you this advice.

> The series documents the named wakeup interrupt for the WCN PMU binding,
> implements dedicated wake IRQ handling in the Qualcomm WCN power
> sequencer, and enables it on the Shikra CQM, CQS and IQS EVKs. On this
> base, CQM and CQS share shikra-cqm-som.dtsi, while IQS uses
> shikra-iqs-som.dtsi.

The second sentence brings no value.

> Testing:
> - scripts/checkpatch.pl --strict: passed
> - dt-binding-check: passed
> - dtb-check: passed
> - sparse-check: passed
> - Shikra CQM, CQS and IQS DTB builds: passed

The above cases are implicitly expected and shouldn't be listed out.
> - QIPL validation of the equivalent qcom-6.18.y implementation: passed

This is a useless test on a year-old kernel with a million patches on top
that doesn't reflect whether the change works on the target tree (which
is approximately linux-next/master). You must test your changes on the
base that you intend the patch to be applied to.

> An earlier experiment confirmed that requesting GPIO88 as an IRQ changes
> TLMM_GPIO_INTR_CFG88 from 0x942 to 0x9c2, setting
> POWER_SAVE_WAKEUP_ENABLE.
> 
> Linghui Wu (3):
>   dt-bindings: power: sequencing: qcom-wcn: document wakeup-source
>   power: sequencing: qcom-wcn: support SW_CTRL wake IRQ
>   arm64: dts: qcom: shikra: enable WCN SW_CTRL wakeup
> 
>  .../bindings/regulator/qcom,wcn3990-pmu.yaml  | 22 ++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi  |  4 +++
>  arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi  |  4 +++
>  drivers/power/sequencing/pwrseq-qcom-wcn.c    | 30 +++++++++++++++++++
>  4 files changed, 60 insertions(+)
> 
> 
> base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a

You must base your changes on linux-next, otherwise your base is
effectively 3 months behind the current developments.

Konrad
