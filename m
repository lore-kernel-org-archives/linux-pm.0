Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794398648;
	b=ozSPW+WoQrhDm+REkTVkPdgyuXIZgtm84V7j+R/gpJeaGZWe4nKmap5ZbPjcp3Y+Anc9
	 Q6Y/Y1tCt5e59hTzSy5rf13yB6ZJBIId9rN1b+MB+4gfdzTp5yBMOPNvSyY1hFrbGHdBn
	 s6eaOAFW1fSwblPzkau6tUXMe0KpWcB7aRnJ0Q7N84KcMAtAHJ+4e2glQXp6Z36ECkTbu
	 rEKa81cwgWIUH2UpVdtuVvAzyo41Ntr9qY5hKrg2oJuwIpPbDG1EWJreGl9YIZ7pt2DQ7
	 ccTxX5/VDrbr7pJYFoCLJ2iGg8R5tR13xIe6MO4NdzPQeHSbfD8oWu23jaLVhvV0uJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398648;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=97BeSVJCOsNBXayFIkPJjAeGpvW7WX8qTH2D2rdWJwE=;
	b=5KNwRAbLWp+ZlzQ19Hc+fDHqIcvXgF4p3WU+aH7zYZ3SrQf7S3I75bbMBpfyH5mKASwd
	 7S4QUutD67NVnDcfMUdhkR0y413mUrvjZqEbMq2UHg6yoCpcHe9BVNEyM4+RYuBiErl2F
	 UjA9+tOoiaYWyzyrFMG1O7Dhnmtf6EMN6u9F/jIPvIMGYTN2G+l0WJTLW1I3TDDLGoH72
	 aFdQtIKOYpejy5U1AiWR3JxHlykfJdVSWJ5eJnASojHIgQnDmc+h434h+GQHTD2XOhy2M
	 wUT6MskeVX2iqTmGI2Lx1GKKaHsBWPHuYTl7M/Xyu42/LUTk4z6XypfUdoPXUnRMc9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="X/CvY2lH";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OAcHUnVk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78F7606A331
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A78F7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X/CvY2lH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OAcHUnVk
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABBIqoX2350816
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	97BeSVJCOsNBXayFIkPJjAeGpvW7WX8qTH2D2rdWJwE=; b=X/CvY2lHnrvPCeei
	JRPs/8T6Bk5CJZOtU0EfTBYOS2lQmbTIVqOzkcqcqrNmsyZBuVmgUrDGritvAb+C
	xnmv36+J8fK4+sEoG4q97VH7WaUXP4gs0TuJR44UFCW3eooQDoDDZ6zRCV3bquGd
	U+j8qiiDNbWf2e5TzRLwxYgxASRCi6I3STt7ZMcMvGTZeBdEgVk19dnU/aUdTHeR
	kE1WWk/0UMYpIUG31V57uBShQCZcZjFbJZX1oWPV7v9xdi37mIZ1IO/2PDkjQT7m
	XEpXLPS+lfJYdvABe0yY8KfH6E7qcKT8lOp6JwJd+Hopj96CS01nt5iHdzKTNO3u
	3N30ig==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnp2cts-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:04:06 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-89e96c03cd0so2877371b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 04:04:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794398646; cv=none;
        d=google.com; s=arc-20260327;
        b=AG8jGU2Tktzc58Xr8F9wlQ06L2nHHRvsFLrDWKlAB6uBPOCNdMndMMWWp1D92+bfoH
         j8P63lkw1pxLTRixvNdX7GRWDfC5VkbsZqLsLwql3uvBU8yGGUBqzz82rnOJllgQ/fbz
         JB9zRCWFAUDuzcmp6EYHia8ki+YdpuL9RnE194z3V9/zQagnEZyGVwuyCAe3pBiqgnaK
         Amz/oHCBNw39dobN6ttmv3YlqwtLTtgl2bUwo1O90qtlqhwqUVmfhTzgxEoDWbyK0lX/
         GsYQo2P2Cc1s8rKouFQK30mgIV1Rvrs6JegiuaepcNo7HK9LQ8a46a4/vSFFsm4kjxSZ
         AVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=97BeSVJCOsNBXayFIkPJjAeGpvW7WX8qTH2D2rdWJwE=;
        fh=aSuq6VnqO20F0VurvDAo2jtXiwwXtKV8rNOvorlHR3o=;
        b=cpuyiY3qETEZcEO9Je9O2oX1Tkb1QSaA/P1mGl8W4SqR/WJxap6RhPOcDvydyMAMxc
         QGHJtz/u7EUQWOMl59i+BJ9cJKHbFglRGxbLI7UQ8RjX9q+hnJ/xu7pUfZWaGhZCPdQL
         H/A0tzDYozCSz2K6RyLE8v5Slc4VCaNIJbVOkMDEmMX0gNKtj9Jc+c+BBmV2WivnpmY8
         d+duN1+yRmalTo+vLVVX3LbDWQASY1PdS06jZrK6grNqLGyTZlFKd+Fv/v4XIuGEUApI
         +IXvtEuXLyEiJ9sSORI5fanZDQEPlDLaxDJhVt6dpSdWIyC0z02ZKhTmyxjpXk+ub/1U
         D1tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794398646; x=1795003446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=97BeSVJCOsNBXayFIkPJjAeGpvW7WX8qTH2D2rdWJwE=;
        b=OAcHUnVkbsxxCk9J1E5i4npIqER9Dolx1heJL/EnpuDI4PHROFyn6XS6Hy2JkVmObm
         93gXtpZ0pYlVfLgAE8i4B+eiGE0preKtX8CxNkWSJwGI0QKxAO4woewt6ddqjzSGJrV6
         kL+qrkI7jNnFX6U5Dx7w7LRbvcRAZfcll0lpphPkASGhs3J6nmUZjNBNK5MYxrWNGvhM
         fEMEZ3eOk9aTnErj1aUZqWSWIgE30ocr5f2MlWsXw6J2lTQFMWxcnzoYLW66ZMJrm2U4
         mgqaRvefOBOXF5YeWJBFaoEgNc0WHRW5Cd1mpKWY3oUphqQyvMgK8+EMCyAGk9RiJ649
         TjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794398646; x=1795003446;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=97BeSVJCOsNBXayFIkPJjAeGpvW7WX8qTH2D2rdWJwE=;
        b=kIiUeb22rLs3CDSFF2JpdRs3wb7fY4kVJRjaVu68lOooX5l9lLDoW8hA08iS+n75mq
         ZhmiyV3cVNtA4Ld3z/F+h1UTgDSQP/fFpZYquNkuwPwUTtMWJW5ntrjM0k3rW+mulzog
         B3u63RlrW0Xl1vqtHluJAd799Y1+zrq/uOIcpIDfCUtlyNypKFnh1DuLy8mCr++Kv4IF
         nhx/rv0LKRssgFf0efbC1ZnShq/YC8gQgcXcV6iPfN5ZyvfczIlRVV8OLDr+olCE9dh4
         eu+nEuCaFpEVR4qbVN0FmnoakVFjUan2j+VYZjociUj0MCmaFas9RDAa78CInmYmdYIX
         Qjrg==
X-Forwarded-Encrypted: i=1; AL+hErGPsNgRQnqnfTtfu8zq9CJQq8Rq7gI1A7CsByuTgXxxTyvSa1NLur3E0OlwU2/87RemJru8zfk6IA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8p8TT9o69/WG8cteIt19OioPxW+eEfDDlBArrU3piJ//+6GQQX
	AP2oEB+Xv6B/otHSemRngwNcCsIzu5qdBsh/qhp0UIoESF7gLYw05f0JyMkrxcFT5dlEhth4RNf
	LU7YgkioJ95Wu4lTDlIbZJo4Ueaaq/mbPYUeVYqKLwWRYHdnrMibJ7xN2UIXqGRi5gFX8y98Chg
	VJ+0vZj9BbJp8Am5MlkrV2ksMgvp7Hi1A81Ao4
X-Gm-Gg: AYBFou1EfY2Q/s+AOuxYQLOMLcZUM4Y/aeDqebGC0sMxxtTTIZISo15rzE/wSCRj4fe
	SsNGU0Z5cEtOtos8lKmkOMqVThGlGYuZ6C7eMBZE+hMvQW5Sdcd5brAhkN+3tDmeyLFOYhJpcA5
	spNppzNmVyWAuPjfBgT2qwumQ6DACEGNVrFzqaZt7oWDRFf1Cliyytfb3dPA==
X-Received: by 2002:a05:6a00:18a1:b0:874:706d:962a with SMTP id d2e1a72fcca58-8bc1cc6842bmr2465031b3a.28.1794398646201;
        Wed, 11 Nov 2026 04:04:06 -0800 (PST)
X-Received: by 2002:a05:6a00:18a1:b0:874:706d:962a with SMTP id
 d2e1a72fcca58-8bc1cc6842bmr2464996b3a.28.1794398645717; Wed, 11 Nov 2026
 04:04:05 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <avNHazNbGtMQJ5pV@sirena.org.uk> <20261110170253.2694265-1-sashal@kernel.org>
In-Reply-To: <20261110170253.2694265-1-sashal@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 13:03:54 +0100
X-Gm-Features: AclHuK-TQiAr8PSNCnxTwZnldPhQ9Cil9VcJUdagL6jktT0AFdXWIAAJvTIePqU
Message-ID: <CAPx+jO_hPY0wZHwE2QdryzgOOAPH-2C0KXZTpt=cT3Aca5d6ig@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pmdomain-fixes tree
To: Sasha Levin <sashal@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Ulf Hansson <ulfh@kernel.org>,
        Guangshuo Li <lgs201920130244@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pm@vger.kernel.org, imx@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0NyBTYWx0ZWRfX3gNU+9IHwQUx
 FWM4AV7OhMF2VrXDd6JQaI1NgzGD6ZUppKspwhrHZOQjQU39CXL7v/din6b8UpC5bkG2zg94+KA
 9YQHJLPp7SMeekLYOOFq4EM7pe2ATzaBYZPqnWtYbN4rfXVVkbgenABXlbj0pdY6/VC+9x2570h
 A9v4DB+HGiT5xsNkqiTJ5h26ndHPSOwkU/4NyqnO24ursXo/6sA3KgAAE7Edhg48j9VN+KI5cIT
 YKPBjtgIuhv2BLI4rUI/TRa7+64om3/YSwEGk3G2l2UaLRjHUuzP9VvhrlRghdXxqw2NHoAg8ZR
 wX7SnZ/JanXzstLtQNUwe07ndPumsSynmrvp9I7h9CAlLCw0vrvYG23nQXwbY+cK/UMtHAj3grh
 W7SG3J7K+4ptwgmd/V1ksg3otNCwgRiMPjLl2WCLhFdXPVqNXV64i2zIX76vQlmXCZYG8IrXjGj
 ZBx6PtFIeHxfXxsH5fQ==
X-Proofpoint-GUID: v6RK6M2jF-o_6LcGdKvlpWEbInrHpBni
X-Proofpoint-ORIG-GUID: v6RK6M2jF-o_6LcGdKvlpWEbInrHpBni
X-Authority-Analysis: v=2.4 cv=NK1AaE6g c=1 sm=1 tr=0 ts=6af459b6 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=FacbNd98rA_P5PhHUj8A:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0NyBTYWx0ZWRfX0WQnNEqT9lS7
 pV5D+gNj0cErcpGdoDbUdVpxPeDSTNCGB+7KcIPq6/nP+b9YWHeD9CIQGEOlJjS67hgZYUzHgow
 jOZ/Aiz37+5+bUBITnlZ+hWO6eLOBPw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110047

On Tue, Nov 10, 2026 at 6:02=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Tue, Nov 10, 2026 at 04:33:47PM +0000, Mark Brown wrote:
> >AFAICT this is caused by commit
> >
> >   d7262971a2acc (pmdomain: imx: gpc: remove all initialized power domai=
ns)
> >
> >though I don't really see how.  I have used the tree from next-20261109
> >instead.
>
> The while loop that commit adds to imx_gpc_remove() is never closed, so
> the function is still open at the end of the file:
>
>                 while (num_domains--) {
>                         ret =3D pm_genpd_remove(&imx_gpc_domains[num_doma=
ins].base);
>                         if (ret) {
>                                 ...
>                                 return;
>                         }
>
>                 if (num_domains =3D=3D GPC_PGC_DOMAIN_PU)
>                         imx_pgc_put_clocks(&imx_gpc_domains[num_domains])=
;
>         }
>
> The patch was posted that way [1]. gpc.c is only built with
> HAVE_IMX_GPC, which only SOC_IMX6 on 32-bit ARM selects, so x86 and
> arm64 builds do not see it.
>
> With the brace added, gpc.o builds with imx_v6_v7_defconfig:
>
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -536,8 +536,9 @@
>                                 return;
>                         }
>
> -               if (num_domains =3D=3D GPC_PGC_DOMAIN_PU)
> -                       imx_pgc_put_clocks(&imx_gpc_domains[num_domains])=
;
> +                       if (num_domains =3D=3D GPC_PGC_DOMAIN_PU)
> +                               imx_pgc_put_clocks(&imx_gpc_domains[num_d=
omains]);
> +               }
>         }
>
>         of_node_put(pgc_node);
>
> [1] https://lore.kernel.org/all/20260924142520.1594149-1-lgs201920130244@=
gmail.com/
>
> --
> Thanks,
> Sasha

Thanks, I amended the change like that and rebased my branch.

Kind regards
Uffe
