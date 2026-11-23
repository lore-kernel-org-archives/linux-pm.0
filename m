Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795450889;
	b=493kaApeo08x5yQ1DMjtrxxOB/GmWfUM4TDfl/tMIo4N+36jiMPZaZRFlUKtb05R+xTi
	 8ZixXI/InEtLzh/d2IKQFcz7aNTEUdazrIiVRGbIEr3HjzoiK08iEI51WIQ/FkTctuW2g
	 kTQ1s8q7U0p1H5J9XNU62rVWhQbgsiYOiDLV1sdVtKbquIZDcyFLsNSiD2Mqkos/dIpxn
	 ukU7EWpIjsK/JMxvaxUcOid8SiFuAGBbSdJbsYWnXXMkcWoS/7U6jbS34sqGULU7xhkPT
	 6iX0IuNUzOttUmxOXuSZe91xyBlqHEIBLnSx/j6ypW5+n+0OfJqY0GKKgmXAYg3Qgew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450889;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/NnFP+NSq0yyiHjtLtbCC56s3jL1Oe1DEEGxccAA6Kk=;
	b=4ZdaE0rlk2tPBpU2tWAlAUuSXO4cgkkhLELJVs98U7QaHrAkOPbJswWWchioXc2sqgTm
	 G5VstlYSqdsG+Gm7L95ureGq7mpp2toG8MRbS1FqK2AM3yqEX5pKkuQ2/sNPXYBI5OKdO
	 AbKQ1Xv1xfF0Gx4Nmqm9Jekqph5SkD131+q/uT0fTwoGsxAdK6rdtdkKWkaa4oMSTMVrc
	 muxqG2ChJYAoP+VMv4MJE+Fkbt7xxx32eUgFdoH9EVqSNQeBqMCAx9e+kcpMW7xxdd6kR
	 yDh65ow5ZbLInphJK1dU0BGANWOsz3iOZJkPeE0YPOEXvYRaAiraBgox1AEJu22uIkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RClXlg3b;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O2nA1LjA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31368606A31F
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 16:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31368606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RClXlg3b;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O2nA1LjA
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGH5BH2340472
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 16:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/NnFP+NSq0yyiHjtLtbCC56s3jL1Oe1DEEGxccAA6Kk=; b=RClXlg3bWSFVwFHL
	QIIvMS4osiWGN6plNZ3HSiPYDwk15ExQT2v5rJk2V0p/KYwCTbk+5E/ggifEOVMx
	0VCoGsGrILpuAIPnr6oaLHg2vAOcMH5jtYG04gNG5SMrFgRqAIvwKsIaWxfssHQ7
	06BTXyxsS1ECvl1qEoKkVu4K3OFk0diTyq2HBMVpvObIIc7NSrWyufmYPo3t5ex3
	2CvvJjAKatokjGr0b6B2EFfiVyVw/ArN1NPzw6FQzL5tTsrs/pY3Ke3MDuSypnxs
	3VG5iH0OtjCFw33UpDHw7fsnMMohUbqeG00xpa1hwVanubq3qlrPgoSHh4gRtRhp
	0gdbVg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4exx2hrp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 16:21:28 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdb91e288d7so2830588a12.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 08:21:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795450888; cv=none;
        d=google.com; s=arc-20260327;
        b=GQmHYApC1kRiMzInP5t3OJ0nUSYNlUF/kjfGvmywMNyviLB/r3A2MipAN8jccTSjAE
         Q3jGYwPKj8IhXmIOklyf0X+pMsx6pjAaLjaKnJAJ3jQz4HiIRgzItyUoUst8G3HQrKWL
         SbbeblDV/o3aUzUku6U6UMLlHxmWckX7GbTAqVih0zAkTYLd/BHx+YiskfmTZOiClqeo
         wr0oKwPpNWX6ohSUhHbQ1pZmGfpnLKB0gJzXqGxppywHXJzViNRjm69Wi2MyuKgBARCv
         LnSPEwW/RgyvRETxaVprlADl70RkJqrh/raCJVUMFth9Ssk8BwRP8/Hr/HekpK+k18Vi
         qnbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/NnFP+NSq0yyiHjtLtbCC56s3jL1Oe1DEEGxccAA6Kk=;
        fh=3KWIeNhRNAiwg0sBbti+a/EKXNx2URBRZDuWB29qs6k=;
        b=Y1heuIoal1DQhaYuRyY1+gZDdHoi3y/Vsxw4pFfiE6fQ8ECBdiURL8Cme1+A4+iGzo
         PC897rmufCTuGHxoHq0AniX5QX+PIELTplzUmoAOQlPhOGpP2jenavd80PPdfdw9T/LK
         dsPIdZGUBWaPnFvIgM1sUih/sTOmeDMdNzCIdX4m3ZDLBTUqrCGv7/uxq8LRFFGaA52r
         QqnaEIvBSKe7/wQYwexXvHlhj4NWgb55IuFWwFOMhdq+Gwm7oORO3KCO+ZwXlL1GEWDC
         BUnue+rFZrklwuPirPzsrxUmhg/i5mn3vaACpTPgbfI/0rhyxfwOrntKbU/RL8LvIj2f
         d0yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795450888; x=1796055688; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/NnFP+NSq0yyiHjtLtbCC56s3jL1Oe1DEEGxccAA6Kk=;
        b=O2nA1LjA659hTozxTrpLI5fRtA4103sYk2ThZhvXEDjOPKawfOma/kqHkR3zwqU72i
         lu6vYZrbCaQ7nFCPG4fy3BG1q7DNEbOQKsmmJM/LR8O9T0zOKtbFvjFNtg/8u0dJkQZ9
         UO0oH6U8DXLKPm8sDKQxSH2s9ls5X8qCU3eGvjyXuvYvk0pRj8DN2QNQ7jJo7niLhmxN
         4xmHIyAxg3jQUbgM6WaIREC/2JS8J9EhtDraMO+4ITkA0ty4WpcqnCidmtCrDFqJ0RIY
         fHl5t/OZhCLA+lyANVKz30ye/mA59AJo3J6kmaTD90YbClfyspRBuGV1++YQ9EXlWEgs
         vgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795450888; x=1796055688;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/NnFP+NSq0yyiHjtLtbCC56s3jL1Oe1DEEGxccAA6Kk=;
        b=Nd6sKZ7ktsVfpRQ6w3ZC90iiToTP6ykP7e2vh/bnY4J52vBVadQ8r6MZhLF4YYlgXh
         aDph1AeeE/H4nahDaHljZ7bsW4SVADhAQybR5mFl+TXVbuOGEb3I8nhvRUjBDcM+ww9p
         t0ydHtfExL3bsa5+QaZl3qyXrczRA+cHl0fAaxloKuA822ljNuTc7WVPRd7hkE+Xyqj+
         OScLYlrH4TEkgQloaImghc8JBVuObxIt0b5Lqcauj+F3CfWtOJlO21uQ3Y4qFog4NZph
         0L+goqFyaMCkEayeZwNXXCXAw+b4ElmUp06QDhIChdWKMRVAOZD96yldHw6AAM/teRyD
         Ropw==
X-Forwarded-Encrypted: i=1; AL+hErFXmxdlvXvasgPjqmXR0+qfmFqvIwwXtBlAD5CKIkaxqZmhb8jsvyLvmVcS7Fi5FHpVjsUdz+RHYw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/O3Eu1e3voFwjYlYvgCwrT+xV+UfuHyXM1ju74iWgaXpwcMZLT
	Y0HK9zCl/tw20sniNjmCraCaDEQoUQ/TyDG9+IsFZL7ldXVsFQSJoBTLOkDEWXSLxllU6jrOtA8
	nLba9Ftw2HWa/9UrjBXxbrZPmdZyoBj6a2SpqmxNahBlWy90FtqPCpoys39THfP3Dmbl9UUrjqz
	yTurhQeoW4PQdqGPLDzRujaLYvLKmrWbi74YEU
X-Gm-Gg: AZFdTZdCms3AF/YFCOEs1pXv87pqUWTshkuebrMfelpCqipV/GnnpFg6Q2VZ2P3jczU
	V3mGCiULl2aZgnixgFjiuYZTlR9LG9zx8/DgcO3oXSuuoY6hlai7PX0kGsyOWkpNO1YG6kFePAy
	mNLG9FuP3IPB7yAp/iz1DWALpgVBCXPzIXhHVvEzkGqEqYJj+k6xveQGJzggOE2XgtXcyOGxAGs
	ZC0Tx1ykVf6RdmJ
X-Received: by 2002:a05:6a20:7c20:b0:3de:557e:5ea6 with SMTP id adf61e73a8af0-40283cbd05cmr5442947637.27.1795450887599;
        Mon, 23 Nov 2026 08:21:27 -0800 (PST)
X-Received: by 2002:a05:6a20:7c20:b0:3de:557e:5ea6 with SMTP id
 adf61e73a8af0-40283cbd05cmr5442928637.27.1795450887142; Mon, 23 Nov 2026
 08:21:27 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794615323.git.gahing@gahingwoo.com>
In-Reply-To: <cover.1794615323.git.gahing@gahingwoo.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 17:21:13 +0100
X-Gm-Features: Aa3M54rrQb2REYtBcbw06BpA4JyTdY7S7pcOgeKDB2ZGguRFDoBBypEfHT-AJbA
Message-ID: <CAPx+jO_F5T8zW3D9CNjH0W5pLLM9srGovUmqvVeWL2Z8dDDo+Q@mail.gmail.com>
Subject: Re: [PATCH v17 0/3] pmdomain: rockchip: RK3576 NPU domain supply and
 settle delay
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: ulfh@kernel.org, heiko@sntech.de, finley.xiao@rock-chips.com,
        shawn.lin@rock-chips.com, sebastian.reichel@collabora.com,
        vlwwwwww@gmail.com, leonard@lausen.nl, abel.vesa@oss.qualcomm.com,
        tomeu@tomeuvizoso.net, linux-pm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=FKKOVOos c=1 sm=1 tr=0 ts=6b046808 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=9GNsruGHAAAA:8
 a=NEAV23lmAAAA:8 a=HctJ1lBftkvV2UQOCVsA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-ORIG-GUID: c7_Pco_9AmHRDyyHreblFo3R2PaGY_JF
X-Proofpoint-GUID: c7_Pco_9AmHRDyyHreblFo3R2PaGY_JF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2NSBTYWx0ZWRfX9HZLEzTVwBJo
 8ciE7uwp3PdFbUKdfdYMfxxYg4gKrLibEyFUtBpxwjIBqngJzWMIQfxJ+f4o3UyyPM53wYc301L
 AA5MXvNeYabr2QCTGo0eiOuBax0Sc0o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2NSBTYWx0ZWRfXzLVbivXPsVZ2
 SCsEgOaYKMCSylJa0MRrBVdCIyQljsl4C3kBWok8LbAi+898rrsn3k/PPgEqQHPBJtSntOxmeN3
 L6ZQQXhuIceSL8tQwH7LkJ6/ZOjW50uLC52CHnaMW+rxVbYRopPNSilzagozACbeFhIXjaG9IO7
 C7iBBpnkZlyRjXgaw1a4yezXQzvCNFD2UQmZqHIKWT069Ulklcwi5AJDyBCzCXMr0G50g9rKypQ
 JRIAZ3qN1lrn1YLVmBqui0FZPnFdBZ93B7ByXum4jq5zqfhnp1HVPWZgWl4C6uxDypL3e1tgUmc
 H/ODpgj0cwkMdk8Oow1uFd56ysFAl+aGa4mIJCbyfpF0YdknZnMLFIQSwRZ+JW9F0/qmOQEbN6k
 nwrtq9UGX1kLZYqZqVhiVOnsgTqP5nv/i+OSfBdqbxyEKL0Jf6R++C3PVMhlpDUCo09ygUqfNF1
 RaMeN3+tveuq+Pa+yfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230065

On Sat, Nov 14, 2026 at 4:05=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> This series fixes how the Rockchip power-domain driver initializes
> domains that need a regulator, adds proper regulator handling for the
> RK3576 NPU power domain, and adds a settle wait after power-on for some
> RK3576 power domains.
>
> These are the pmdomain patches of the RK3576 NPU series, split out and
> rebased on Ulf's next, as Ulf asked after dropping v15 7, 9 and 10:
> https://lore.kernel.org/all/CAPx+jO-KKvgRS0br-3QGh6Jt4efWJ+A6YoRZKFV_bcfB=
+8sm6w@mail.gmail.com/

Patch 1 applied for fixes and patch2 and patch3 for next, thanks!

Kind regards
Uffe


>
> The accel/rocket and DT patches follow as their own v17:
> https://lore.kernel.org/all/cover.1794615324.git.gahing@gahingwoo.com/
>
> Based on: Ulf's next (844a13010b0b)
>
> Changes in v17:
>
> - Reorganized the series as Ulf asked, and split the fix for regulator
>   domain initialization from the RK3576 NPU regulator handling.
> - Following Finley Xiao's (Rockchip) review of v16, the RK3576 delay is
>   now 15 us on NPUTOP and VOP only.
> - Fixed the subdomains of a regulator domain being left in the wrong
>   state at probe, reported by Vladimir Bely (1/3).
> - The RK3576 NPU power domain uses DOMAIN_RK3576_R, the same macro
>   Leonard Lausen's GPU patch added (2/3).
>
> Testing:
>
> Tested on a Radxa ROCK 4D, with these patches and the rest of v17
> backported to Armbian's 7.3 kernel:
>
> - With the NPU disabled in the DT, NPUTOP, NPU0 and NPU1 are switched
>   off and idled at probe on every boot (16 boots). Without 1/3, all 14
>   boots left them on, and one of them hung.
> - With the NPU enabled, 30 NPU power-ups after a warm reboot and 30
>   after a cold power-on, with identical output and no SError.
>
> Logs: https://github.com/gahingwoo/linux-rk3576-npu/tree/main/board-logs
>
> Tag changes:
>
> - 3/3 changes the delay values of the v16 patch and is organized
>   differently, so I've dropped Abel's and Heiko's Reviewed-by. Abel,
>   Heiko, could you take another look?
>
> Jiaxing Hu (3):
>   pmdomain: rockchip: switch off the subdomains of a regulator domain at
>     probe
>   pmdomain: rockchip: manage the RK3576 NPU domain supply
>   pmdomain: rockchip: settle RK3576 NPUTOP and VOP after power-on
>
>  drivers/pmdomain/rockchip/pm-domains.c | 115 ++++++++++++++++++++++++---=
------
>  1 file changed, 85 insertions(+), 30 deletions(-)
>
>
> base-commit: 844a13010b0b93f8561ef2c088f843647d5e552d
> --
> 2.43.0
>
