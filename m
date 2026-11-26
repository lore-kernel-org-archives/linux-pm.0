Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795697013;
	b=ETQCV9jHb5iD352fowP/n4Gm/2rwrsd889v5QILJI5fwHGgEJnw8eD8JyohhlN7a6aWE
	 LJAfVjZjcbZTOU6XMHGlVol1o+mAK+n2odTVcZ5ecsWFRAKSM4t1QzLJ4ZLSboLRcdd9/
	 IziMHCq9YRwXPnTsR6VT8G/eKlsKXuvMA5K+3LtLcuqDiAhdGMIykTd8rup/WsSUhP63Q
	 E+87+YLXADlfR5FQcHwBM6Ow2Z8REaqnV7hGKULwWqOALi1zFu1b2jadlHhUAkwfTDbqT
	 L201Y2oEBssmoCEANK2WIZxkDhNtKWDdp4MIqaRXt0a1B1pAEbaaIzebsLf3V981QSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697013;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=GnmeKXoTKhOyCDZP+GpD1/6T8nYJ3ksjxHtTGDe1aX8=;
	b=bc+lLOi7UAr4hRgGKscKq6RxKq5+a90TAavutgapUBgIGSAW1/ephmaeyAz5Ty5zXCcn
	 tVxjNWvXmVEtK+U2bQ3fQ7IgxyasIC8sjKb+20HHn+P/RWRXSY7Vj37GcN285ms4dEyNv
	 mB38jhVMilpyxcbzF9Q9mbelNgrLFafscmdWFuDFB+AQSwFL0v1AalULs+2+vPe3/Esdx
	 5daQ2Juo+ZeHC192IRHn9goyUOJVWTx76jMqXwJgjMeZ0tSqfwBm+dK46VkltMRFXAJUr
	 9Fcptd3nbgp1A1kemhUVhr9jasLsNqG40x3W8cuXwPZWI8freTMG5yMFgl+fMbbTg0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NcHOfw8r;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="eM/RtD19";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D86D606A326
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 12:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D86D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NcHOfw8r;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eM/RtD19
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBVrSp2264017
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 12:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GnmeKXoTKhOyCDZP+GpD1/6T8nYJ3ksjxHtTGDe1aX8=; b=NcHOfw8ru6Y4BXRC
	0ngT9SOy7f+e+5Ym7yuEXiV3KRGQrhm4JE82z9Iou0J0bbzl9X4lvf+zywRgQdpD
	TBfAJTRsYLTDjJnAgHciPvBW/7u+lHPgftMCwp0Pq6y85EelLE9spIXbYru4/l5+
	Ghjf0ZINuePAwwp4+85m0Gp9KW7jOtZY6MZXyRAOiiDeleDp9b6UxTFK/ELAT38n
	JcblSv4xOPp+vs2eAVRcQLspbT3NRwlSpcAIlvuVuHAc4yJfsG7OrX5BfXUsk5Cn
	7yLJf57Fv0/W8T5D2QvfmxOepgDEShR7miGXlIitqgrG0xP6mqn3VM4NRiCXpQR1
	G6YuMg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j62aem4tn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 12:43:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b167bc8e16so5493885a91.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 04:43:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795697011; cv=none;
        d=google.com; s=arc-20260327;
        b=jLarwPrwUtSNog3U27nZeYnmtUzfVHFUJ+iC+J+ewAEF1KtK1bNkvcqh01QltjtmLx
         Ql6L8zE3lHnh8f2PP3S0EHRJACAqS6M0Pe9wqjOg2IP7SHLsFHsXUdX+mOIK69YzClxr
         AHrbN3apnYWTnhnyGMHDKms/ExisnmNdjcCd6G3LkbSMrWOCMQpmK0ARTWWzDv5DY9bT
         +9BPNprJLRV25aZ0OiXzaYMO4RMuKvkVWgOagrvBO5XVYuwrjp0FJsFNHfyPjF61u8dj
         ZCh0OIHe7DRDg06vapqsGnw5sjns7jwF9ia1jJc0dL0a7P6OUYVLknbq4O5LCE7NfwIj
         fcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GnmeKXoTKhOyCDZP+GpD1/6T8nYJ3ksjxHtTGDe1aX8=;
        fh=HmClAShTydP8fr7q4bYxIH83PJLRZRNcSwvc9zmS8Vc=;
        b=DSv2jCFPCnWtVpkFGgs4h+Rp05rNH0veTOsXL8cJPcIlCUd9DcKAjWajYwNgVh4EZF
         piLQUpzOrec9IBLWoSnKohOOZ+t8H5A/8gbY127IBPH5Uww9zIkIih835/G326X/BLfP
         CCE+ZUbaq5POfIBTqm3PSs9yXgFCon1FUW4iKsAujxHcOax2cL+dwWKWyCaWU08LspVO
         L38w3lD0MMRp0VhyH/HoMntrDjP9w0AlTFPTgVqkVXTrFjVCKYHhPYrnOOe01nMOBtI3
         yjze4lVYSoIoJP2+E+AM8dpn1uNv7rPyq1QZ0/EuZvkuKXNFekUUf/S2MfGTzOEri5Sp
         toww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795697011; x=1796301811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GnmeKXoTKhOyCDZP+GpD1/6T8nYJ3ksjxHtTGDe1aX8=;
        b=eM/RtD19C3LI29nrDkTTn+1ZpgabUJvOR4AijaZeNETf13dIYMTs4MpRGVmlGsCZB3
         DmbMOfMyX9s1bqYyJ6U7VBg+olxjdHnI4AszJXR+2uVLCqAeKeB5yZWIkTaUyGJzSe04
         nr4Jab5B2LGOiQ31sQUqShiGQbMon2SsPOkR3Akxf0H3zKHeKex02HR086T3EEdACwFb
         u2IHDdMv6GUMSjp4xA07zTG5OAQmDGw1BMNlyFKiKrpmoiGX0ZhCtJfESHVmvLOt5lVV
         TqoHglQqD+sOizuA5cPGi+SEd6Kp/GoFtjMtzp3bOGxbgVqDIXj+CxEl7ooMNF/GPC5J
         H3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795697011; x=1796301811;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GnmeKXoTKhOyCDZP+GpD1/6T8nYJ3ksjxHtTGDe1aX8=;
        b=1Ss9YPFYaeTc1mq6hzd5cYGa3F+a5fmTmFjSy7Hm2sjVz4qaP6nfE1nR5atSxx0E2l
         l5bZFC4mCTKr1amAcOn+8usKsxB8MWkFC1G0Rke4XkCy5k4cvviTmNAw9h9zwjlxl900
         2Edz1xlHjqAUoEAyMU3vGeY9gSec7AIR62VxjEArZ6Pcn5Q+CpZaF3ZaJ161mTPMW0Fs
         6sQfeVSi1vOx4Gcs1qkkhKMxa0iLU/eg1a7aMY/O6NaCFfQUH6M2/G9b9Gs1Lhdr6BaB
         ugbV/7Mv3c9kBI3RbMT/QNr7C1li/vPxopdakUkJsMCU89UjjuOK4G5G8w3fUBxMpfNt
         gRmw==
X-Forwarded-Encrypted: i=1; AL+hErH0NajY84eVSWNICahyV+f4hysjx/6hYN4v56ikLVUGmJ68reTF+rGri0UghF5aaUsjuPm0Ai6c7g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9PRAE/dWri+UBi3DmXWuFDzs3wHZHRKZStNo0lDYuG9QIBo/4C
	Mrp1z9qOM2SwNX+cEzoIn27FAswhztvTLLxD01NSHFrf+kpcbQnDCm9AbiVsnwE1GdhFmKsqmPz
	TlQSrVJrnOJtV8jYIXYAFLK3XxoBpXkh7Zcb9yK1PXE9TsGT5DCwickTENQUemQQbFNdIEuQgdX
	78Tc6VVQ+oA2bAXdQV2K0j/11SRTUcuanmTpYd
X-Gm-Gg: AZFdTZcCw3osTw78Pbhg0NcmtFe1pNosqosWCfTC95CJbuO1Q2Ob5cqMTdm9hCbXt/z
	Go3CCtSAw6nwRJzWBRHJ5knsz9lmC8gPXX37sNqYFdSqGIpfdpQu+YMHk/ga5e+JW9EsZDUaeRn
	xe7nJ+N6Ro+H0l1V8P90P6OE0QRzx3TK3PDLX6i0BkaETIq7T73gwMFrxwwA==
X-Received: by 2002:a17:90b:4ad0:b0:3ae:9944:3bf0 with SMTP id 98e67ed59e1d1-3b41c938c77mr19665429a91.34.1795697010840;
        Thu, 26 Nov 2026 04:43:30 -0800 (PST)
X-Received: by 2002:a17:90b:4ad0:b0:3ae:9944:3bf0 with SMTP id
 98e67ed59e1d1-3b41c938c77mr19665406a91.34.1795697010325; Thu, 26 Nov 2026
 04:43:30 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-rockchip-pm-defer-v1-1-5b41635e3410@bootlin.com>
In-Reply-To: <20261122-rockchip-pm-defer-v1-1-5b41635e3410@bootlin.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 13:43:19 +0100
X-Gm-Features: Aa3M54oXEG0UXV0h1Ay8EFT6l0_fiX2X2Hu5kQov4OoBP9nRPaNYuRXl0Vc7i6g
Message-ID: <CAPx+jO8+WAK+W8BVOSJVHoLEvQUUr0-d7gEEK+yNwhJH5skYUw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: rockchip: fix warning when deferring probe
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0OSBTYWx0ZWRfX6dbIuwO0jhBO
 QNHz0hsjt5VUkcDFbN4FskC/8lPb5gzgttyMaC6F53d6ObVhIKofJ6BeIXzjkfZElnDQV6gGpb+
 1eeaLfn/AI/3ifaz9W0JMIGGauxYUEV4gsu++ZEp6x2A+b1KOWCk0HrEWj9bNH3Nw7HSttC0/1i
 0sbYS7OC5bIj68rR3unnfIN2PdUta7F87igAd+VF6VtTN1CyDOzPAjGfALgVOaDZA9dXGvj8HVO
 DbzS0cRjSjzNqXyZrFLzj3uJw0Z7A0TSD7+zHW9RVs0ifR4quz7CgCEWCr+WMEss8K9QEeuRclA
 QfoP+FlRfaBFm1brB52OO7KMG1D0oQZnJS5+1QmTmPQx4yATGNLz4jCJLismLYRE43+lrV/bkLp
 hNy/XtXCxcQbIZMerztWa0rdEq4EhnZPtEeSDELtWc53CSPgHpq4LbPYCaMOLYuQBCIP63lIetJ
 ur8+7iyJhhGFQo/UvRw==
X-Proofpoint-GUID: 9VkUbfu9fwk2pKs9dw9dSzplJEUfk3Iz
X-Proofpoint-ORIG-GUID: 9VkUbfu9fwk2pKs9dw9dSzplJEUfk3Iz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0OSBTYWx0ZWRfX+JD+JRptOZ1V
 +Q0IlzEDeZ0YIxc7JZciMarBIzTyS08GT5N/yJMAMJ+btAEFpRbEQDT5JgHwau4GzxxqbB4rhYP
 fGzTzP/1DbxTnTIBvM6+kpqaN5dn/Pk=
X-Authority-Analysis: v=2.4 cv=PqoG/AM3 c=1 sm=1 tr=0 ts=6b082973 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=P-IC7800AAAA:8 a=cFyDgtjIdI2ehFJVjNoA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260049

On Sun, Nov 22, 2026 at 2:38=E2=80=AFPM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> When the PMU probe fails because a clock can't be acquired, the
> pm-domains driver raises a warning in kernel logs:
>
>   [...] power-domain: failed to get clk at index 0: -517
>   ------------[ cut here ]------------
>   WARNING: drivers/clk/clk.c:4831 at __clk_put+0xf8/0x130, CPU#0: swapper=
/0/1
>   Modules linked in:
>   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.5-00004-g552d0d1e0=
9f2 #103 PREEMPT
>   Hardware name: FriendlyElec NanoPi Zero2 (DT)
>   pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>   pc : __clk_put+0xf8/0x130
>   lr : clk_put+0x10/0x20
>   sp : ffff80008192b750
>   x29: ffff80008192b750 x28: ffff80008147aee0 x27: ffff8000813400bc
>   x26: 0000000000000000 x25: ffff800080e5d5c0 x24: ffff00000074f280
>   x23: ffff00007fbe6bc8 x22: 0000000000000000 x21: 0000000000000000
>   x20: ffff0000004f78b0 x19: fffffffffffffdfb x18: 0000000000000006
>   x17: 70203a72656c6c6f x16: 72746e6f632d7265 x15: 0720075207450746
>   x14: 07450744075f0745 x13: 0720075207450746 x12: ffff8000816ee830
>   x11: 0000000000000058 x10: 0000000000000018 x9 : ffff8000816ee830
>   x8 : 000000000000005d x7 : 3ffffffffffff000 x6 : ffff800081746830
>   x5 : 0000000000017fe8 x4 : 0000000000000000 x3 : ffff0000004f78b0
>   x2 : 0000000000000010 x1 : ffff0000004f78c0 x0 : fffffffffffffdfb
>   Call trace:
>    __clk_put+0xf8/0x130 (P)
>    clk_put+0x10/0x20
>    clk_bulk_put+0x3c/0x60
>    rockchip_pm_add_one_domain+0x298/0x4a0
>    rockchip_pm_domain_probe+0xd4/0x310
>    platform_probe+0x5c/0xb0
>    really_probe+0xc0/0x3e0
>    __driver_probe_device+0x164/0x1d0
>    driver_probe_device+0xb4/0x120
>    __device_attach_driver+0xbc/0x190
>    bus_for_each_drv+0x88/0xf0
>    __device_attach+0xa0/0x1e0
>    device_initial_probe+0x50/0x70
>    __bus_probe_device+0x38/0xb0
>    bus_probe_device+0x10/0x20
>    device_add+0x604/0x850
>    of_device_add+0x44/0x60
>    of_platform_device_create_pdata+0x94/0x160
>    of_platform_bus_create+0x198/0x520
>    of_platform_bus_create+0x1f8/0x520
>    of_platform_bus_create+0x1f8/0x520
>    of_platform_populate+0x58/0x170
>    of_platform_default_populate_init+0xe8/0x100
>    do_one_initcall+0x60/0x1d0
>    kernel_init_freeable+0x204/0x288
>    kernel_init+0x2c/0x130
>    ret_from_fork+0x10/0x20
>   ---[ end trace 0000000000000000 ]---
>
> The warning is due to rockchip_pm_add_one_domain passing pd->num_clks to
> clk_bulk_put, but pd->num_clks does not reflect correctly how many
> clocks are correctly acquired (it is systematically set to the _known_
> number of clocks, before attempting to get them).
>
> Only pass the number of retrieved clocks to clk_bulk_put by setting
> pd->num_clks to the number of correctly processed clocks. The value will
> be dropped anyway in case of failed probe.
>
> Fixes: d8b384777066 ("pmdomain: rockchip: fix clock leak on domain probe =
failure")
> Signed-off-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>

I have already queued a patch for this at my fixes branch:
c671660ea0af pmdomain: rockchip: Only put clocks that have been
successfully obtained

If that isn't sufficient, please re-spin the $subject patch.

Kind regards
Uffe

> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index e193f978d5f3..adc3bebcd928 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -854,6 +854,7 @@ static int rockchip_pm_add_one_domain(struct rockchip=
_pmu *pmu,
>                         dev_err(pmu->dev,
>                                 "%pOFn: failed to get clk at index %d: %d=
\n",
>                                 node, i, error);
> +                       pd->num_clks =3D i;
>                         goto err_put_clocks;
>                 }
>         }
>
> ---
> base-commit: 988117cc1bb17338c586a4e21ade88b5397eac33
> change-id: 20261122-rockchip-pm-defer-adb33313f110
>
> Best regards,
> --
> Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>
>
