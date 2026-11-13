Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794592036;
	b=u1QqAGsqtw44WZRGV5x9znbBYZyX/v76ENnmDeaW1uCXnnLb/vzbfWlQfmUGIA/cQGYT
	 mfrCDZDMFAyln9YXbxILzasR6ucdWU5pqj0XZPk+h8WpHW6kiC5qIFMzqFL3jiRli2ErN
	 ie/3XbnjNjcHQh11fFhtkZTZiS2ZR7YjGtUQ+rJ03XNnAcpAnf+YxR0VfbVmg375rTx70
	 M/zw5pFgOsJbJZ5PTXIQVagcJdvejdRKK3YlTgKkXHucPvQvFQSb7UOiIu02LX9Id+e55
	 F0NVTW/81/b8zfEhhAaB2theF+wFk65wzfG5LHbfqbxCUvDLbV/mycHzpvue1B5EILg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592036;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XUtAykq3hDRsL0/US7WOum9GrsDms9AB2V3NWupV8pE=;
	b=tAQl4LdejidzZAxJzAAlkT4SBlVeosrQoQLc+PfKk0LKVY7h5ojhW3njPZ5jIrgy7Hvv
	 MRdzMH/RIMW6L6aKyIor81CcRjNdGSQKq8LuAXNTBjOnGs01mY5TAE96PDE0zSOwPU2s2
	 ZIoPjB8AkqKaUZdk6x9/W9HJlbeEwYAlbpa9rgauOCrUFJWdpWUUWRG0TvSAxVQqVjPF/
	 o6E+t0UqdrIulkmbnnjMeckiGTWoEWwBplgP+/dJ7faWjjFtN5KGUF64bC+TSiKOw9VGs
	 ViwHTuTkIrnD9O1nop+GUfC9z9AsgsO34lav2xg31lQOYwsh3dcHU4VZYuavbpsKSbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XLgYD711;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="c+/JnLdQ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D3A606B205
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54D3A606B205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XLgYD711;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c+/JnLdQ
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFR5kx551933
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XUtAykq3hDRsL0/US7WOum9GrsDms9AB2V3NWupV8pE=; b=XLgYD711Nb6RdnRZ
	pQM/51Q183vY/GeyYUbr8tGR4RkZZkYV2YZLlpgqyAn6ep8vMEH3k7k5XmsTr6Zm
	dg4JtobSMy2N/EQQcfrNKmRJT5MRHku+6LyZ696Kz4uqWEnfZDpGBQIiY5yMuVtq
	/vvumqxB+tt/zkmIDA6XX7vwN/iLx/oPCpTqQsI6KcS5POxjqi3RVrrQzff1UhCu
	qb8l4Ow38i8jqlUuWr8EBtw+dWgLGU2bfB1M33C6drxYHw5GpzI/bDQRlKe0GEuI
	4xveG2iHz8mEJb50e8UCyeyD2PMSmP8dSapmmAeePBNVReEyHsGi+9Eo+37VDu6M
	5P6New==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwc3wa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 17:47:15 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cddc4bde4adso530120a12.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 09:47:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794592034; cv=none;
        d=google.com; s=arc-20260327;
        b=BGGQ4aEysk+qyCz+zlQ7w/aT+p1TMCp6jYjSyj/04Ry3hcJaYmZyUiHS2r332op08k
         /7x/YTTKOmmjXUAhlzaY9lzD35OLPddwXoe14iEu/5z+CN2LH/AlzezXvqFpt41FvYW0
         Wumxb6g5szN5B/vTx+f8QVm5BI4aplMDF7oE5Pt+GRBXxW+wWSOGSaGaei/YyJjcChVW
         vn+2U4FSxPErHJIvnyvHNH0vSSupxPk0lmWwhWzmrC3QWrpt8JmILf8pZ4wnQULYvuhj
         3nHTPGNUFNsODbnUk1NPSBikkGek6NS9YjWpF3aOE0ccP4iMPrj3tI818gqbx4UxWyu1
         E3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XUtAykq3hDRsL0/US7WOum9GrsDms9AB2V3NWupV8pE=;
        fh=Gc1/fc29g/8CTKkyrjPSrgtEEG1Tnmt6vJclKp+G9Ls=;
        b=KI2cLuQTyFbxhSkCVPE+p9+vf9JDm7upSDEuTHQgGvszPM7LLZVOOYYENd9tEdR8N1
         MvppWHpyS/lOksa6+PVUYRVlJhTrPUImUuu9QRI96EQ5fcQdl2a/0a2yHSaylSlsIPKF
         c2QuDvAiVwKcP4jqTwoK9xeLt2JuEietLHdjqzFT7+pxZ6RIhrgUijT1PvIawUNrLxUA
         9bo4jf/JY8tJOZbFs/Sqa2AaSAC6Klq2JM9zvOVLNP0GW9DLtf8auI+j2msPTQP8O5KG
         cXy0eIjezgZBAPEY1viGpR+FAwNIG1EvFhn6OrErYbF9Xz3KhMh+cKCmQxOFfiyD5Kmm
         Q5ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794592034; x=1795196834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XUtAykq3hDRsL0/US7WOum9GrsDms9AB2V3NWupV8pE=;
        b=c+/JnLdQhX6F1a7DHfl1cUH4zp8dgXgNYqDJxHsjF5oXW5dxAFIUA7TbUy+LwlDKbS
         CsMFj3E+scMnV5FV3X/fc+fzU3robIDtwnv5pZpyz97MXlgTkHboihJb6W/J9ygdIqpq
         57ACxjlSYOwx2kilV1OKEeCNZEk1oGbH77L16dkR3GO+DFY9esQMICUlXbu1ABQZlfAw
         ffquzZvlNY3Tr7mj/y1D/0Q/Tjyq3hFbhtmpOFYekGtDteWgx1ekN65ndpaD4JFewqnH
         2r0mhhzp+YKvWGdH6rqXjVp4qzcbvu3pCbZRzatdY5BmOas2rrsz4bvdYr/r2dI8BYGB
         OQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794592034; x=1795196834;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XUtAykq3hDRsL0/US7WOum9GrsDms9AB2V3NWupV8pE=;
        b=ez8em0D/LlQUa2A81u3w1qKYyZIcPV8pIKDbMSopuj79RYgfxK3I6+ex5FfSgnpD17
         WmyaCCgx1dbYU79/9ow1UWpVJJvQbdeTaLta5gC8TgUG/sJ0sDrVNLHT0b7fDs263pc9
         SpFdwye8skd5TUV3FnZ1jkseG4ig9QmZxhuvxpzWLucKjgu7I2PMxAVfo4eO179wVELi
         K3l/TrY+659Y8F3w/IWe4OYEyilpR2bE+ox66VGGk/+UwkEwIVOhZexB00tvMkNoSUY2
         R61uOkEDYHh5sqE/Lu+bA0HHzbLnru4N5+YUO1rTawMk7j/20cp7oUhPS9v6ZyriX2e6
         cODA==
X-Forwarded-Encrypted: i=1; AL+hErFXO1uemJaX2JptqABAroY48xtqo81NrZJ7xy0p3kPPUcKviaif7t2NQLzAqM603UaYA38Gti/MnA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+NDzwpPwP05eq6tnHr6mTICAISNczj71J7pNd1F9LCbiLI+7Ww
	8mqORvbDfBJOMFySE/Tcid6mp6BjOrq+WSTALXhOOqywxaBSo1WOhquasTaJL5DGch237Y0V1Vq
	nlqQlKAFaGUs3jz9kWqEob9DEMqtbxDIu04QwrcffG58TZXCWIkm66d05R90rSq8skvq/iuGJMf
	dYYAVsk8TWTJgD2FV6FEaO4DmewaoeHcAjPTUv
X-Gm-Gg: AYBFou17IPX99GJyMLYwSDE89IBf0f8ALG3CkTnlsp2xrmS9w7k0bx2WdmvS5zEMf5O
	/tDrMEzU1NTKZb6cgCwlHAcGE2mJgde9RuMOoyJSSy8ZznsJlB1IvZhKxDTBaXpmDbNZJeyh6O9
	ySdpXQSg3jtg6gV1FVFqM+iACQ3UvRzTlwUleLW2bZCwbJC/YGMDZRz4I4/A==
X-Received: by 2002:a17:902:f603:b0:2ed:4456:fb2a with SMTP id d9443c01a7336-2ee0dedd363mr31379235ad.36.1794592034226;
        Fri, 13 Nov 2026 09:47:14 -0800 (PST)
X-Received: by 2002:a17:902:f603:b0:2ed:4456:fb2a with SMTP id
 d9443c01a7336-2ee0dedd363mr31378845ad.36.1794592033770; Fri, 13 Nov 2026
 09:47:13 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101082307.151957-1-gahing@gahingwoo.com> <6777074.j6PcuT4dK6@diego>
 <CAPx+jO_gRtipR7iuh0D7G2Wi25GZoqFD1JHVbJNmhd1UyC3Bmg@mail.gmail.com> <20261112072146.41218-1-gahing@gahingwoo.com>
In-Reply-To: <20261112072146.41218-1-gahing@gahingwoo.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 18:47:02 +0100
X-Gm-Features: AclHuK_xZYTfne11hVPWnloCpcRGvh8w3tWYpN49I_tY52oUY-lip7RnFHUhpQI
Message-ID: <CAPx+jO-KKvgRS0br-3QGh6Jt4efWJ+A6YoRZKFV_bcfB+8sm6w@mail.gmail.com>
Subject: Re: [PATCH v15 00/15] accel/rocket: RK3576 NPU (RKNN) enablement
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: heiko@sntech.de, finley.xiao@rock-chips.com, shawn.lin@rock-chips.com,
        tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
        ogabbay@kernel.org, zhangqing@rock-chips.com, royalnet026@gmail.com,
        abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
        sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
        chaoyi.chen@rock-chips.com, diederik@cknow-tech.com,
        alchark@flipper.net, leonard@lausen.nl, jeff.hugo@oss.qualcomm.com,
        rfoss@kernel.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af74d23 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=s8YR1HE3AAAA:8 a=9GNsruGHAAAA:8
 a=KA_qeCUQCZmkxMg8J8kA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=jGH_LyMDp9YhSvY-UuyI:22 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-ORIG-GUID: BcN5c4PL0prPX2PdXVIfrQgrJtZ-KWqG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfXzKZw4pPnl4DD
 po5zp/Hz5gx+SEWskFBhtDewNTRa7J2BLcQrlS1EcGqt0ohMcNug9KFqecAW3UEOfYH81vbooRF
 7gWpR/htbRiQlLUTI/DPI7LuuN5e2zwO5gXSHslBV1sfULQbSP6R3iQJbphYFj3+CqDjEOsFZW2
 4glJx32fY7Hhr+MSoJFZ9kXNr9yqixq+S6q9O09ewCejsjf0CrB6+SeDCn0AGoKOaCfC0ozxhK+
 CUGhP7aNDAQNxWjPXhrnug3kiKsK0L6fSroquFgdU8AKrC1ca10Be4Zrz1zkyCuwr1K0rUcwuUj
 WuduXjfEbwwvMW+0vusDrIcqZ7thLG+rNIs5RjrebSS5ptzetJHPerzWm9fea22NWCN9HfbZBvG
 WdJY7/bPVlB49szlFSY3QW8mfZe4ohY2pKy4yGaTJB8ej5C1g31jTBM+NCoBlVxKBrD5PlwVh+y
 AMJEEo0Jmjxdb2sWSnw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfXxlnGnJjPljbH
 L/hV3RAAL7/pYa1stmQCLy/+aGlGsWeo/rlngXv1etq+ZnNXXXa3w3feaYSynx4WOqXLy5Cmm1p
 ViIx0eFZWehRQwL5qT/pK8UGOD41wk0=
X-Proofpoint-GUID: BcN5c4PL0prPX2PdXVIfrQgrJtZ-KWqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130070

On Thu, Nov 12, 2026 at 8:22=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> Thanks Ulf!
>
> On second thought, I think it would be best to drop patch 7 (the
> binding) and patch 10 (the reset) from next. Once patch 10 is gone,
> patch 7 is no longer needed either.
>
> Finley Xiao from Rockchip pointed out on v16 that the reset is not
> needed, and testing on the current code confirms it:
> https://lore.kernel.org/all/ca90a994-70cc-410a-902d-5c4c0aacc9b7@rock-chi=
ps.com/
>
> Patch 9 can stay. I will send a separate small patch to fix the delay
> table.
>
> Thanks!
>
> Jiaxing

I have dropped them all, let's start over! I needed to apply a fix for
the rockchip power domain driver anyway, which caused conflict with
these patches.

Please rebase on my next branch and submit a new version.

Kind regards
Uffe
