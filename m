Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794656025;
	b=h5Yvd101L6tOpOSaiLDfFcEmZ2iwC0eEjoG1/ILmjHFTiV6PR5S7d0iDB1R9GJbMBlPz
	 UOSmYG6KOgo4kmgbrpO4fHksYW/jsld/uYX4qfldiw3FVw3Ja9JgPQ/k6zr2eb9HqDP+p
	 WlCIynL2TdXumyanw8sJIRM8hQ/IiRELpoLYq9dJShdkFTcwt8d9TmWx3nPfG+yAuZVt+
	 kgvHHLMeHp8G/FoEZu/4LwZv3SzzUw96MdGiSi+BcYuAvzAGpR7MqoVeSginOyfyf66U5
	 6iNtIwRhoE6zOgV354X/oLGRcp0vYx/pdr29o+GRe2pBC6ifg8vQ32QHDkv2wNHWO3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794656025;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=oEfA8gRWLRRIMFKx9bwTG7AarFQoMaM1TYcn8ru1TlM=;
	b=0WVonc5ING2CCq8ca8Xu+3MrQzVVG0hlb9JHGTwVGO5RBorqS0bWgx96WCZEb+Xr+vo0
	 sTrrAwPNhWvZrc403ezdEgdbcCuTJdy1b1nWdMY14XuJhV4/NmhwSFaGpxk0teK2V/Je5
	 APFuIczBQbnBbqfsQ2G7vOxrWi5yKL/5uz5YosusLlDhdSl/23/hwrLrvrTVPUZ+kWA4C
	 Tnd55k7XqCnp1w7HQ+hKZGQIjVsfQMX9Nj6l0aoo4U1lOM7Hf9Faz7BfpPJejoFKFqKAq
	 MSekOaAxQ9OCgQKd0Tx+KgQzLDriBRINhgOnJU2LnqivEx6fO9OLxM3dcIoGGc3uJlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dlGROvAc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EDOgslyD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6876606A323
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6876606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dlGROvAc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EDOgslyD
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9wBpY3649923
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oEfA8gRWLRRIMFKx9bwTG7AarFQoMaM1TYcn8ru1TlM=; b=dlGROvAcsPVce7rB
	7jYMcmpMP5EC7n6vqtae59gEYYfiazxVySMuuNPHGrMjSQq9gTt6ETbaSLGoxNaj
	6jOcBI5CV6fOuutnW16tj8iSGO6rvmF64l+JacIBdSB00LPDbcXDY3Fg/fhTMAdJ
	KFt8pyuCCXOGz+hFbtpXGhCU6906mvDJ5LyfoiERzRN42yKzt9e8B2kh1OyuLJYG
	UJqi1zUYrQ82qGjwmWJ2G665UuHEGinAFyG4UwA6mRksm7UhpnktbZmjAugCgvM2
	455gZ7uBXnFG1wi8/9bOybFZsbG4sKImEQVnC/+p95oGmHdgxmrNeN6N+5NsIlK8
	+ql11w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhjrnw2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:33:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ada6ccd402so1348432a91.2
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 03:33:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794656023; cv=none;
        d=google.com; s=arc-20260327;
        b=MtHvPexmX64KmZqU5lzCpBjt7z/435W/Y7SANF7T7ev3cFIAMnhC0jfvkEXpYoNBjV
         d4PZl1FUW1TLiEJwvKWso6gafaYCxvAWMc5bKHHvWOo8xpFrJZYdTzGKG5KBZa4zoZcB
         9ppgeihNQtueeDXRcr/sCFKb73Y7jZ6WSxq8o/xKHTZDjBgjnEQI3YQvmjp9N509Uq9m
         0dOZFAWKfPft9iuhLVeRkpO3owp4QDcndiLmgIWu8tqmFCd3pUyi3fVcAyCywWrzQhZQ
         U3MWpxZ+cLfK9GS/UtAkIfOiaqBU7soEKoADKsFsAMAusE06WXyTOFhYUYC2dOPQk//3
         ENWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oEfA8gRWLRRIMFKx9bwTG7AarFQoMaM1TYcn8ru1TlM=;
        fh=BXp/sYLhtG480VkgP/OResl2N7mNyMVs39LvLxnTFSM=;
        b=klKuM2Ns9z73SrwgF9y3DTNtNLGG+o+HDmBZm3jwdL9CbuW9eYoXxmSEnCeNT57GMH
         biuxETvIdRRuw7J4hnXFAhUN7wGIeW7jfZPCUI0o9ljdH5hpuUwPx/AyE08+uj6TGlA/
         j2YutPBOqRbA2ba5iI8NY6kDn1S85D1BAocg0GlqqHgGzBqox5aAK23Gs+WGMWKT/1HF
         V4s7DwH95Z7Tk0H5jtnQyrHGQJBLS5rX1BkeW+0rlc4418sdOs0ZYo2A6xlbX0RccGN+
         UAIb6kxBmnW9ihYmiwIY2gOqW5cYbNz6Du07FBiLuCcHaDFT5JvC8mI9f9U3JIBysGYk
         7k7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794656023; x=1795260823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oEfA8gRWLRRIMFKx9bwTG7AarFQoMaM1TYcn8ru1TlM=;
        b=EDOgslyD+i3gVKiwSkulBThEPQ52FYMpFeGxjDLvkBu21131nQQaX72VmRs/Ld9AV/
         7J0Yi800X5ZpEyJMcPxSQHCFbU7531CcpH+ZU7ZY2GPq7DBlwg7FIjTIMiP/C4l+tYtE
         32C7Xk5+lGFuHOUFMXb0kQPLSG8Q6ehfJagOU5evBtrO8th+HtF6sCMliqPo6Q9jqfd7
         uQDIAX2jRhwKZ+juaOzqrjtJ6D0xFplXRUD3REVWf/dUms1zDygLkcBLI2syw/uGjRx4
         XS4L5R+iT9e5ZNiizoIx+Gv+5rhpjrbj7jUpXdnkMSUOlCWjbZfKOtWLPWlf+mRrLgbF
         ew6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794656023; x=1795260823;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oEfA8gRWLRRIMFKx9bwTG7AarFQoMaM1TYcn8ru1TlM=;
        b=duOm4WKk7LOBDY8FdpCO5MC015tNb/I6a2UmWUpZQRGNBl7AYBqgoJB1nVwziuTFWy
         d02PiqQ+KiNTmL7qZSuVVuzRDSPnbTtCEm8jI1Cvi2O+E1tAvH460tqHWnUE3rzWOkwF
         NmAaem0b293/GOTyYEho82OwhQ5CMYDnhJmKWaJ9MoojvaBWnutGoDfNHV3XLTEh8OWW
         D42DMhuaUJqHMV2s8NHCqU2ZKk2BoloH5RMJfMewIsPiSgiYG3hrt4zDJZ33z2rhUAlT
         xDG0XMjlL13s+/PPki7pznJwKI1N2f9y4d7HyRptR7QZH88SZ2UjC/HOxK9A4/cLckfZ
         LSIA==
X-Forwarded-Encrypted: i=1; AL+hErGsNpb+0ejEtlbHMkqn8GG4cukeWIEUWgR4VnM5nVoNl7XqGlj7oRYxcpyWIPAcjwQlvq/IB1/IoQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8TkkXk/8xMtcKKxv7l6CIjMwskYDe2uSvDyrcpaDeQMT8w+tQu
	40KXuBJ6SzWVQT7fzOhcrHJYdpLZtf9eLhBUIS6n1GC758ng7PxBpGqKnrKvRy+GiL1BhVXEz+6
	cYtJWlVB1BK7slH6Kt9PTQ74907oldV6mDphroHl1Ldm2iJ8UycK+kCVD9JxGezfwn6KtQ6U3N1
	4HB/mZ2veXWAsgiyPvefF3hgS+f4VIhS4m9LEJ
X-Gm-Gg: AYBFou2ZmfMnC1xK24/JMpnnTW5VKm1QjlnKdOoV8XcqGePU/Zf/R6wQxbueFF/PFTv
	8+7gxrV9eXd5zt8ERMp1Q0j8pA/Vioqru49SXseAsttgIsFyitFVespxaSqI+Gj1RQ3npAf689l
	FlAVyqJ4t9vYvPl8jW2jR0EvgncjJ/Zs9qF2JTti70IrWCTwWpogZc3d2xDw==
X-Received: by 2002:a17:90b:5910:b0:3a0:516d:9f88 with SMTP id 98e67ed59e1d1-3b1b0a1fe6emr4265338a91.26.1794656023189;
        Sat, 14 Nov 2026 03:33:43 -0800 (PST)
X-Received: by 2002:a17:90b:5910:b0:3a0:516d:9f88 with SMTP id
 98e67ed59e1d1-3b1b0a1fe6emr4265318a91.26.1794656022663; Sat, 14 Nov 2026
 03:33:42 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-01-pm-device-link-v1-1-8932e0862378@kernel.org>
In-Reply-To: <20261112-01-pm-device-link-v1-1-8932e0862378@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 12:33:31 +0100
X-Gm-Features: AclHuK_taegd5bAzuybJmQPC1z-fZC_MIChsvwsEmWXiwFzgCH5zCy6riPEsdLY
Message-ID: <CAPx+jO-37Km71oSW+zOO7BBWLj86SNCn=U=EGmBXdC5SfX4nbA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: connect consumer with supplier via device link
To: Yixun Lan <dlan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Troy Mitchell <troy.mitchell@linux.spacemit.com>,
        Icenowy Zheng <uwu@icenowy.me>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX81kJMUyJs9TA
 mPhsFfIdoFrsITw8i7AuS3Wxug7Hkn820bbsW+oHeh30NpAkmme/3ZGdxJhymuMCAaz2FEbfa7X
 T23ouANNXg/q/M3Bd6gUuMw4D2GE/xhM25S5EintMmE96wOl7Ni1X+gkdl8LmulhblaaGP1+GPq
 2U/IPfUxCz4kzRHIrJOHf5lGsru224q1ooj1HN9GcXmnM8slxeAUV3q6zHEFR5mNlhzbcIwTwEB
 smjIgBpeioEvOLKqNvpXB3hcqco5IMkcU4Xv3ZPquLihbLYIE3jayIxm0B2c3yGOBnruuhgnxz1
 nQjt26tg6rLuJj3e8cMnuBZ/4vr+z3O1Y9ioBMrzrDTtGour/kTb5tB426vbVndS4oGCr6/vUBI
 fwWt7Yhi9D3lTCwNOcqlfMdxCYYbZcx2z1fu8mNeYAHYyE6Rf+a/bmD3u3WuClsfzS8AZFjhcJx
 0ezLJ0l9qMSWcERmmPQ==
X-Proofpoint-ORIG-GUID: 1eQJwm0LUM1qzaw_kXTxiZWD0wP2jxqh
X-Proofpoint-GUID: 1eQJwm0LUM1qzaw_kXTxiZWD0wP2jxqh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX/sY+ySQUiaXZ
 6gT23kPD+fMtihydK5O6MdCDeMM7MgN66YK84Zh00gYBe3NnmF8V3U3PB8lwhSHlZfuLgqPEzG3
 ba80KkaCwz0dodXVID5orfFziLFpEJY=
X-Authority-Analysis: v=2.4 cv=X9rHu2Te c=1 sm=1 tr=0 ts=6af84717 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8
 a=7_BkkAeRn8r4wxPsRKMA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140045

On Thu, Nov 12, 2026 at 8:45=E2=80=AFAM Yixun Lan <dlan@kernel.org> wrote:
>
> Connect downstream Power Domain consumer with the supplier through
> the device link API, So when the pmdomain driver is unloaded or unbinded,
> the consumer can be automatically notified and purged gracefully.
>
> Signed-off-by: Yixun Lan <dlan@kernel.org>

Can you check if the below commit that sits on my fixes branch solves
this problem for you?

e279833a5362 pmdomain: core: Wait for device link removals before
dropping genpd->dev

Kind regards
Uffe

> ---
> The power domain drivers under pmdomain subystem suffer fom
> the problem that unable to notify the downstream consumer with
> module unload or unlink event, left with stale sysfs interface.
>  Curently, the solution is a) use builtin_platform_driver() API
> to disable the module unloading b) adding suppress_bind_attrs flag
> to disable the unlink interface, which prevent it from being
> triggered from user space.
>
> Take spacemit K3 platform [1] for example, without this patch,
> Removing spacemit_pm_domains module will trigger a failure to
> remove power domain, access pm_genpd_summary will result an
> kernel oops, See detail log below
>
> domain                          status          children        performan=
ce
>     /device                         runtime status                  manag=
ed by
> -------------------------------------------------------------------------=
-----
> lcd1                            on                              0
>     cac88000.dp                     unsupported                 0        =
   SW
> lcd0                            off-0                           0
> audio                           on                              0
> gpu                             on                              0
>     cac00000.gpu                    active                      0        =
   SW
> vpu                             off-0                           0
>
> gpu  lcd1  pm_genpd_summary
>
> (gpu and lcd1 isn't clean up)
>
> [  181.353671] spacemit_pm_domains spacemit_ccu.k3-apmu-pmdomain.3: faile=
d to remove domain gpu: -16 - state may be inconsistent
> [  181.353889] PM: genpd_remove: unable to remove lcd1
> [  181.353896] spacemit_pm_domains spacemit_ccu.k3-apmu-pmdomain.3: faile=
d to remove domain lcd1: -16 - state may be inconsistent
>
> [  206.228045] CPU: 5 UID: 0 PID: 2560 Comm: cat Not tainted 7.3.0-rc12 #=
81 PREEMPTLAZY
> [  206.238002] Hardware name: SpacemiT K3 Pico-ITX (DT)
> [  206.243027] epc : summary_show+0xaa/0x308
> [  206.247081]  ra : summary_show+0x264/0x308
> [  206.251224] epc : ffffffff809f50fa ra : ffffffff809f52b4 sp : ffffffc6=
01273a80
> [  206.258542]  gp : ffffffff82333b98 tp : ffffffd601d5ec80 t0 : ffffffff=
80026b38
> [  206.265859]  t1 : ffffffd6092d3cb0 t2 : ffffffff81601810 s0 : ffffffc6=
01273b10
> [  206.273177]  s1 : ffffffd601b92470 a0 : ffffffd601b92588 a1 : 00000000=
0000000a
> [  206.280494]  a2 : ffffffd609ae8000 a3 : 0000000000000000 a4 : ffffffd6=
01d5ec80
> [  206.287811]  a5 : 0000000000000000 a6 : ffffffffffffe000 a7 : 00000000=
00000000
> [  206.295128]  s2 : ffffffd6092d3cb0 s3 : ffffffd601b92470 s4 : ffffffd6=
01b94040
> [  206.302447]  s5 : 0000000000000000 s6 : 0000000000000003 s7 : ffffffff=
8221e3a8
> [  206.309764]  s8 : 0000000000000001 s9 : ffffffff8172b8c8 s10: 00000000=
00000004
> [  206.317082]  s11: 0000000000000000 t3 : 000000000000017a t4 : 00000000=
00000002
> [  206.324399]  t5 : 0000000000000000 t6 : ffffffd609ae7178 ssp : 0000000=
000000000
> [  206.331804] status: 0000000200000120 badaddr: 0000000000000010 cause: =
000000000000000d
> [  206.339829] [<ffffffff809f50fa>] summary_show+0xaa/0x308
> [  206.345206] [<ffffffff804b67f8>] seq_read_iter+0xe0/0x390
> [  206.350671] [<ffffffff804b6b86>] seq_read+0xde/0x158
> [  206.355697] [<ffffffff8063dee4>] full_proxy_read+0x54/0x88
> [  206.361250] [<ffffffff8047a03e>] vfs_read+0xae/0x380
> [  206.366275] [<ffffffff8047adc2>] ksys_read+0x6a/0xf0
> [  206.371301] [<ffffffff8047ae68>] __riscv_sys_read+0x20/0x30
> [  206.376944] [<ffffffff8101fa6a>] do_trap_ecall_u+0x19a/0x518
> [  206.382674] [<ffffffff81033acc>] handle_exception+0x16c/0x178
> [  206.388503] Code: 0a13 c00a 4c05 4b0d 3783 540a 3823 f804 3423 f804 (6=
b9c) 8552
> [  206.396050] ---[ end trace 0000000000000000 ]---
> Segmentation fault         cat /sys/kernel/debug/pm_genpd/pm_genpd_summar=
y
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> With this patch applied, either unload the module or trigger an
> unbind operation, the downstream gpu, lcd1 will exit gracefully
>
> or
>
> domain                          status          children        performan=
ce
>     /device                         runtime status                  manag=
ed by
> -------------------------------------------------------------------------=
-----
>
> Link: https://patch.msgid.link/20261108-04-k3-pm-support-v3-0-b9dc0857039=
b@kernel.org [1]
> ---
>  drivers/pmdomain/core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 964e44c2f78f..870fc8083bca 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -3543,6 +3543,8 @@ static int __genpd_dev_pm_attach(struct device *dev=
, struct device *base_dev,
>                 return -EPROBE_DEFER;
>         }
>
> +       device_link_add(dev, &pd->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> +
>         return 1;
>
>  err:
>
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261112-01-pm-device-link-9fdd0fe59a49
>
> Best regards,
> --
> Yixun Lan <dlan@kernel.org>
>
