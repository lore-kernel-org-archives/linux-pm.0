Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794308114;
	b=TvuiBizPfh0FLYY73rUwHwRadkaJbQm/ld+gXYtECyEacQxgrojRdRQWmNSUgwb14p0R
	 /vz7Rcc574h//WU4joljRVarzBrSBhGuaNK9LPdPj3jyPzDexJK3pYduaKThhYMhjMf7a
	 WR0MT1sD7ievAIR6DnVz8Lz2cn2R1N/FUTJQehKPuZRawUEg9qm9ZNpILNvNe5L3HaxzD
	 jdPWuzTITIvE0ch5syScvRVVZON6ZLSGOeAWSp0PNNDsjz+YglTBGzVkAzPAc6qlbv0/j
	 UeOKh1Pvrej/iRb6XoQhq86N2qp5hChmdkg96vSGo3wturwvmImMkbW/zuWJtRuI+iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308114;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FbM2beT/ufH5KYufSNvf3zwpdmcVzR6lfg5amoABbYM=;
	b=S8C/5V6Qa3jUZl+Gp5BVnkGeAirX0WBZeQbV7JPtFTaWyweoycnnit8AJvrlbB7h0PGU
	 Grb5HVit5qvi72tvyxRPd/QHUKBlSH7MR2AXoED5pddD4I4clixlpDt8DLoj/2K9dWtpf
	 uSUKGPpqzuxJrvD+dSP3nPmgJc/O/RudyIKWf7vu/HU2BDqU/CIDCp4Wn4BAIOkmKHj+b
	 r0X1bFMgGw5Tv9DAshJpUooRRUxWdSkQdO2qFSrxroyzc2yEStY38mRrn+cJ2KeTL2rGU
	 /4ueYqomEsgDlaaYqC6dv8/TjBvB9WWhMjP+dO296aHS7lPaPEmTtEHqTnjFeksdGxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="d27fe/gl";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bf3ZGGGx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EAA60A2615
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76EAA60A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d27fe/gl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bf3ZGGGx
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA8mqD62888536
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FbM2beT/ufH5KYufSNvf3zwpdmcVzR6lfg5amoABbYM=; b=d27fe/glQtKvSlKW
	CAKbr0p3yZ+zq7kpWozN7Of0wddOy+GbY8+15C74oKoRd6X8fM/xNQfXPyA2eF6c
	70y54o1E5S+YPwH+hVQkiQWDpXyviMaXUXWBWdcGYfZRdhBj2IDPVPvn1f26O9WH
	RcRE9boj8DQnBC5yoRcDxl435ldSMAPqY4JrLiQ0+7bBQB/8m7qwhQzr3u0BiaVr
	Jtyle+CtQP0IIxB9fbJbou3IYe/4rSFaev5s43I7bsNNtIUCFPmq2nvcqNcE6C/g
	YZneFWIHNazWtm00fYAEalEeb7Y2NL+Z4qUb87sEQ6plV6Ev0f8jGcwseKsPdWic
	ZRqm8A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv03creu9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:55:11 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdaf3f2a58aso1133386a12.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 02:55:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794308111; cv=none;
        d=google.com; s=arc-20260327;
        b=NgDKytcf6DdANU9pwg5LsbXnfo7GJNeyJSOP/YzjrHTa+vIfMg9GjkLo7mIWISJLE2
         hVOYgDSXwdvOnNThjJDcR5TXkhcci5jVMWvcqWMlYEA2F0ke9sq3ntNayaDGBmiFX8Ib
         VwMNGp3bk03Dnf3jNfhFrY1Hdm2cCz5Z0TeYKxcTsbTCW0H2iSKU89Xczr6FPIBDimlO
         DZPULJuHdnw1TLPVplIEZFZPJkXjMFZh63Ur0SF1SydkKCHEJYTQHInidLJwVlU1SjNm
         uAGA+TUTfvdzUns8JSGjvuA9ZMVpSTQ8hnljZo8zMd4SwjrUEj9qR//n6n2aOGi5Ca3p
         JikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FbM2beT/ufH5KYufSNvf3zwpdmcVzR6lfg5amoABbYM=;
        fh=orCKdVVtWqsQcseaDkLzy1x/Ai3Viff7dRzLZBihOp4=;
        b=GwYpZ1kRMnF1lIJj1abAJLC3Ftl6XZztuSX9yW+rMoNxZ06WdrF9dAfEYD61U/AbVd
         YcuFplDF/sNhHdqKB3uFISJSPA6E89kpfgnPncqRRSz1qBZVb/1vjG/g4AZSctAsIike
         XTeoKlmJqLGDvtjnoNonOAlfITyqEQvHXmNCSvb+iRAYNgVGSfoa7VKWAHA6UBUucV6N
         uiU062IkkSRq4/ijR1vKRs/NumDXtDkWi0EVjkNPETeyEGOn5LZcumRVeUoOLaGV2t6z
         HisBloXeFEGl6Z2j2lQqveUBcgru/gAq5bt1HMsuCuG2nErRv7lAnDAFNqyZvbVDG+gw
         eDWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794308111; x=1794912911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FbM2beT/ufH5KYufSNvf3zwpdmcVzR6lfg5amoABbYM=;
        b=Bf3ZGGGxK8PohCuLdp+XsIW9ySdOljx5IfeCJjwILBRmKwnUfFQRLhijFUGI0iVKi5
         a2W+aBzvVPZdiSi3FZ6ohiskzTG3s8ck8SzRMXTbDnBWuP478dxZRZdoyM+y1WveofSx
         iFNIoAhn39XqTy66/3rjiH1aCCtxnckoHHaOvG1/CmhegFz/Y7vuGsE8zEE9YMY0Md4a
         iBoAZkVOHmqfNqtCCEYOMmA3j4saBX1xXXpiBndqXwei1w6CcEiT8q0mzh+oK3FMzJhp
         L9llN8u31otA9I8DA0c89hF5Rr7pAIWn6thVfz9oQtcrMMapNdFHfcsSqKF3NUgAYSa9
         /y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794308111; x=1794912911;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FbM2beT/ufH5KYufSNvf3zwpdmcVzR6lfg5amoABbYM=;
        b=N0iSf7uknRbWLq82oTQcgK8Ddnnfh0sYFIfPcifpzdG48i/e0JBVSE70OyyC/9U4Lu
         8S0OOR4PeXw7aFp7e3ZKzCCnEekXaxOj8M3n4iuGY7oRPeDXkZBCFqhhOQiz+CuGs67O
         ptos6qs45Vg7yCE024oEOsL1Z0U8a+pUDBjgP+x5+a9VUpi2xagVwLSxJZk0Z1W7VoVc
         BRn/QpipXFSmzvFrI2sV/1cCeMjz6qweb8iDSYSs+8b9f6sI8y1GOxWcUxCFrUKk58o6
         NgZedDXrH5nouPooY0lIUI9cZ7b4R8oiVvaITFlMjJheoR2UScxsMcYkECu01l8m35sK
         UjAA==
X-Forwarded-Encrypted: i=1; AL+hErHQz4oP1sOJUz3y4qcJXAVoFPJoDX/eviqbwk5RBtrmaqIKpuvEmJoHQLb2Z4x7DqmJcfjzGSN7jw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8ImKTtGh1pQGf6Q6Qz/9nwJZvm6YDiJXThr6wFWKA4jeUYCToF
	4jrPOR5pHm5i+G62comAhpfq+LMM56B2Fvw+8HhuROnUFT5kKJTDJSjQQKQHiyy5LWuiC0KTY10
	k9JDsTGHoB9EdWsMYz5OqOm8KM2UzAjwXPOc9wSZWO62TToAxv9kew24JpgrCFhemafBSgWYsLv
	43bj7IdPbFgArVm6bk0sxzLKiEyr/evkwPjDVd
X-Gm-Gg: AYBFou3MlYJuxod0sjHmDEmcgItlyaqyqtkarLPdx4HlUNo2ElxSnCgARJ9sHeOjNg2
	ZLk8g6UTpmcBvEFvi9t063ZPZpMgfyJ/5UbysxwgZPiorlDOXLLVXU83XkWYcYj+i7fQwVqkPZ4
	vSYw3elh5k6yQ+f9CWILO+NgqRVVn116dMuzEpN3lzl0SxRGdPCh1PaUvBIA==
X-Received: by 2002:a17:90b:534c:b0:3b0:a757:e370 with SMTP id 98e67ed59e1d1-3b167a3863bmr1285321a91.42.1794308110754;
        Tue, 10 Nov 2026 02:55:10 -0800 (PST)
X-Received: by 2002:a17:90b:534c:b0:3b0:a757:e370 with SMTP id
 98e67ed59e1d1-3b167a3863bmr1285304a91.42.1794308110234; Tue, 10 Nov 2026
 02:55:10 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261006025318.503422-1-nils@buechner.me>
In-Reply-To: <20261006025318.503422-1-nils@buechner.me>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 11:54:58 +0100
X-Gm-Features: AclHuK-yZm3sakUxzv0BiFEttCIYN0ZmBsfWxz8lFwhcgpjwm5RE5v-I_qmF6-U
Message-ID: <CAPx+jO-18BxWDeKWrib+GaKNiy_DAjUqtT2-s2d9YgYtObJgXQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: Don't power off default-off domains
 in probe cleanup
To: =?UTF-8?Q?Nils_B=C3=BCchner?= <nils@buechner.me>
Cc: Ulf Hansson <ulfh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: fHdA5PwJAhZLWz66HZKDLly7tkDHlK0-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0MyBTYWx0ZWRfX8gB2qoDkcKNr
 JI4ply1R0x7AkfNOuW2g5wt66xntLT8rgl29TvdKR8wZPWYgDc/OhsjKyFWR2l5E5r5WhpCT808
 G80MuBbOKiTVxxcZqk5p0sHMkwGjVws=
X-Authority-Analysis: v=2.4 cv=FuiQbGrq c=1 sm=1 tr=0 ts=6af2f80f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=t40qi2bwvM8u8KFdrioA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: fHdA5PwJAhZLWz66HZKDLly7tkDHlK0-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0MyBTYWx0ZWRfXwATTbOhYO6Rk
 X6kBzxpq9duw+DMloFmL+gZNVsi9cJnCFs8Tg+2jK7C/9/5J2TqWS+ODtLHhKVtzHwkv40tKhua
 P6UdtNQ0x0IilZwVCqnF/Si9pCKpb7Wf8xcclWk3txvf/K+G1uU8Ddpn+F7ymrAZGK1CPmQUs7X
 adWIaMQBHzxZ/fOWJr7FcxhxGt5Jr6Gp9mHyMfjJ1vA9Tr+oX9M2UZ6elPTw/md/QdXrgHu4/ZZ
 agImAh3ModUTeToIhH0MuxISOsOqvH9kwHFKTRkts71b3Ym33mndxz5LEJNhVCA0Ie0UQF5KLZA
 FLY9oTo+DzW9NYQP0pvnC8htaSD8rAxxHdvtDk6Q2LsQ52qZHar9H9+V15JgL4Z2cEczQvSb8y6
 VS97e00vRtNkHTQ0qNm0os86E/4gl1ayu3VkV1ex5AORv7AVzwI/g9r+0+zAzwi5Hw8snhVcKES
 O84ioVz4Qd0Mw5Ee5bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100043

On Tue, Oct 6, 2026 at 4:53=E2=80=AFAM Nils B=C3=BCchner <nils@buechner.me>=
 wrote:
>
> scpsys_remove_one_domain() runs the power-off sequence for every domain
> that reads back as on. Domains with MTK_SCPD_KEEP_DEFAULT_OFF are
> registered with genpd as off and are never powered on by the driver
> before the provider is added, so their clocks are not enabled. When the
> bootloader left such a domain on and scpsys_probe() fails (typically
> -EPROBE_DEFER) after it was added, the cleanup disables those clocks
> anyway, triggering "already disabled"/"already unprepared" warnings from
> the clock core.
>
> Seen on MT8183 Juniper once the audio domain is KEEP_DEFAULT_OFF: six
> clk_core_disable/unprepare WARNs with backtraces on every boot.
>
> Skip the power-off sequence for these domains; only drop the clock
> references.
>
> Runtime-tested on an Acer Chromebook Spin 311 (MT8183, juniper) with a
> 7.0-based kernel (the hardware is not set up to boot mainline);
> build-tested on mainline with W=3D1. On the device with the audio
> domain marked MTK_SCPD_KEEP_DEFAULT_OFF: the six clk core warnings on
> the deferred first probe are gone and audio still works.
>
> The change and this changelog were drafted with an AI coding assistant
> during a debugging session on the hardware; they were reviewed and
> tested by the submitter.
>
> Fixes: c1f3163d8ff3 ("soc: mediatek: pm-domains: Add default power off fl=
ag")
> Assisted-by: Claude Opus 5.5
> Signed-off-by: Nils B=C3=BCchner <nils@buechner.me>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>
> This is a follow-up to "pmdomain: mediatek: mt8183: Fix silent audio
> from premature sync_state" (sent 2026-10-05), which marks the MT8183
> audio domain MTK_SCPD_KEEP_DEFAULT_OFF. With that applied, the firmware
> leaves the audio domain on at boot, so a deferred first probe of
> scpsys runs into this cleanup path on every boot. The fix itself is
> independent and applies on its own.
>
>  drivers/pmdomain/mediatek/mtk-pm-domains.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomai=
n/mediatek/mtk-pm-domains.c
> index f0fa79e01..2b41bb8ed 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -1100,6 +1100,16 @@ static void scpsys_remove_one_domain(struct scpsys=
_domain *pd)
>                         "failed to remove domain '%s' : %d - state may be=
 inconsistent\n",
>                         pd->genpd.name, ret);
>
> +       /*
> +        * Domains with MTK_SCPD_KEEP_DEFAULT_OFF are registered as off a=
nd were
> +        * never powered on by this driver (nothing can use them before t=
he
> +        * provider is added), so their clocks were never enabled. If the
> +        * bootloader left one on, running the power-off sequence here wo=
uld
> +        * disable clocks that are not enabled.
> +        */
> +       if (MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF))
> +               goto put_clocks;
> +
>         if (scpsys->soc_data->type =3D=3D SCPSYS_MTCMOS_TYPE_HW_VOTER) {
>                 if (scpsys_hwv_domain_is_enable_done(pd))
>                         scpsys_hwv_power_off_internal(pd);
> @@ -1108,6 +1118,7 @@ static void scpsys_remove_one_domain(struct scpsys_=
domain *pd)
>                         scpsys_power_off_internal(pd);
>         }
>
> +put_clocks:
>         clk_bulk_put(pd->num_clks, pd->clks);
>         clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
>  }
> --
> 2.53.0
>
