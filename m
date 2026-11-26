Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795699951;
	b=N0HWKm9w01lpH5lqHuNV7zPi9mCi+YnFDFtSf76pq8rEdDR1JghJEXfedvHnbglgXsbJ
	 hjM0l7yoWAmX9ZgHcPdcwk64ZYTQ9XyiUB+N/8WMn0tv6GhO50+bb+fWVt7v1Hkykj+D/
	 hl6YRGua+C7n3VxiRHCZwK74q6+1jOyWoejTlehWBiMydz0oDZgcvhA/+lCCi5C4i9YQ+
	 /yeXGF5M3n9aEDFkpffJ5eP2169YFcoWDwrOoE09Qhige6f1G7lXzbjHg25Ot0AcC+DAl
	 xzv3zLJBws4HNBdIsNlXArqSguTNamH+OoYD6AkFYsUTvrahrc+t8AsuVmvJRK3Igrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699951;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+9miH9ajMglEU1T9v/p5qaesHmImKy2AVWQklFfrU8M=;
	b=UlZy6PaFCnjbIVFMBGLrcadbQzJ/k14UGVrEoFIasv8J58OF4BpE1scMQXCIuNTkLR1K
	 shUiZJ+yZs4LrcG7xxa7JZjRffNC4bqzfx00l1qJJ+n4120jG2jK8AF15OYuIIomoGISX
	 dDkFtqs1zDqpJAL0X3+l4vpHk08s3AnsBoUPgWQkK/zEdIzC5wjAovL8HsYqPS5AFY+Q5
	 BWBaLF2JGIDE/L+CquPMpYN5160ZutUJw0cOrAXUiDAxH2+IOKa7UqaH2QG5TNgbyhhmz
	 fIvZLu1TJsULG8eUjs6EwsX+B9u9Sp5WQkvJIQQ9na5Lyge0F9B5sW5RiYTJtl86m9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O474cMuf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cA1zTgKv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375E2606A331
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 375E2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O474cMuf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cA1zTgKv
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBVvs6633459
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+9miH9ajMglEU1T9v/p5qaesHmImKy2AVWQklFfrU8M=; b=O474cMufGk2k5Rvg
	0oFgqz7ZcI4auS15ppYaNM7jq1lVpF5Ok5M3nBClKNX3UPt2yJ6YX5/VLaVqwBRr
	Pp3rwzqBe953cG8DD6w0lKCKi3DjXZE48rkwHKnVASb7i9p3Sr+HM6UGnj9kuxM9
	j57LbTPXlcLV+pBeKWlEoFRxikEYWkdgmfnMdcec6SGSCxG0AsKXNgR9URVz7Cny
	x0Nt6m51lVgR+IkxmBb6AUdPfdCwzimOYok1t5bhnFJf3fkhNsVQVXdkypG1aRgA
	8NQZvFSa0794u3KxPuLmO2WoeJbrzEWY22RF04hNSrbo5UA4i9zt1eQB92nR1Jyc
	yYfU7Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne17n8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 13:32:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b49dd1e77cso3729817a91.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 05:32:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795699949; cv=none;
        d=google.com; s=arc-20260327;
        b=nZVvTkDwJoz4GMtwCBsILPtYyUUiIzIOWr4Tgn2+RO12yL7dtvxoLNAeXB3MKHXOTH
         kYV9d+ACO4bBvWKyAxq2GEpk+BvyiOC/SNX+XuiKxSsw05XG52LVdwgiA2WQmuf3D26U
         yZBlxL2bqQp0rYXI1O+UtyCmhTlIzBJzN89VmXoNvs3bnhumX37DTXuTqriUzGvCtZxE
         rhAUZ0lrbSAftLkh8VFt06Mp7DWhlVh+d9fxVhnRKs7Zznsx77DCF3u3nE1wHjlDRo2Y
         uPQ5AOCPO1PxxJe/+vMa7tMmCSWcJVVQfKTPFmj4DpX4G7sfXowvqyB1YWXfwWEbByQ4
         DWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+9miH9ajMglEU1T9v/p5qaesHmImKy2AVWQklFfrU8M=;
        fh=JBX2VVZ08iSujcZ9o2dQZWoBfXw7KBx/vaHsclRq+TM=;
        b=H08wrA/b5OG4DtpccVOqNZr/2ZuuNFSDhnp2eYyWZTl7ol4ouu+MCvJlLQ2CKn5i35
         k/ZD6xAjLvRy+FBqCqUkhnA64gAPJ3wXHn39ZFyhiBTcFWfSI/kKrIQIKfBr/UlnMhO/
         leRfGTw5fOkgPctPPQpMhSkJ37L1K9LnQpE7bFvcx4QfdpGi95do6WSsEj3WHPHFm2O3
         Xu4aHOu4Ond76bjo/P5ifs/TQMVkgbiY6LBTijGaDezEdAj8tpYJUMkzChc+EdrAOBzW
         yWB6AL7Cr6Spu3WUWH27UyLgdls6pjnMIqHDeIMvAGlibVAkdyysItiqZ79VjCkO6jUw
         Agog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795699949; x=1796304749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+9miH9ajMglEU1T9v/p5qaesHmImKy2AVWQklFfrU8M=;
        b=cA1zTgKvCEoGBovNCwpez+mvNVbXXiitOsgbg4FK/DNdaEKyPuDYWbK2h7Hotpd2VD
         d3LbTIhc+dxCD/7lJOMiRqUlwO+7iNL1c8kRy/eMEQd9hR8pzwboOMxhH3X50Ft2bWRa
         90cRtKodwYNklqqZ6PgrA2cXVkoQ9crQFEkGIfmhEzbzUdm19U1krZuVUuOoqUq+t7gw
         8jRdVpVBAHh3Q+/aJvoxSqVlCBJfzdcad26qfQ+Co+J+KtisuR4bSaA4yiKbHsIytnj3
         YHKV8tYvD7ljqt3GdTTtigoUAalTC+o1mgqf1Gri4f++nQDRgFjeQEKrwFn/Cj3NbK9h
         YWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795699949; x=1796304749;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+9miH9ajMglEU1T9v/p5qaesHmImKy2AVWQklFfrU8M=;
        b=H6r/+xr41vnia8AeN7gyif089gGgcmf8m294yQMJTPActNmnnEeGZWCcEncbFBa/WH
         kK+ohpFiAZTSnyeIxFay3lH3N77YkVGuP+nhmFqK5AKqFhVcPeB5O3ETVHBX1XCd99ib
         +Sv0rVzWrYmxC5vAaPd31SzNWzX2crdNS9swnYGoXl2tIm7+cS2IFNt9osJ35YUKD1qm
         dCgpAg1yt5chbLuNeNrwqc/HcQD+K6KKcX1iFVBDjWYKmAvYfpo/hnoJBq/v65c/XL7D
         eOPDXZB0HhsmKiWD6N6CGNhYoTusnVFbxfIUMKRrRwXdOWl83c0Arv3+XKG4+ApGhPje
         rdOw==
X-Forwarded-Encrypted: i=1; AL+hErEpGrFYMCgmCaBzq/dFlyi2VklAXD9KrPAFO7iNfBM8+2Vsg2DxxzI+QlCcWnfkE9x5baBvFotz+A==@vger.kernel.org
X-Gm-Message-State: APuU4Z81DjDw7bID2J0jeBUjZYIZp/hdvAdqIM4FyBiEmMw2aIbmA9L7
	lDsk7ax8gBrGpAXPQ0wfK890HRJ2koiKewENaYNOFYwUEqlx/vxWp6SeY13pYQ06hgzy8HWWtFe
	i3yqCP0zei5xMdwVFD+1u72oPLX1pRoAnxqRHo0PJ37w53rebnWJ5CHo/afBVrIGMLMxzvqLgFR
	V8xhShYjxn0oH7vwoC8yWZDq1rlKvrDB0qC/Ha
X-Gm-Gg: AZFdTZcIF4vonUwmDnSGEuoeWyDMWrLvi1pKujflEaOMEGrUdJCY9+MvGqzfdki1n6W
	/7xY0mFxwy11v7ao+LNcHvZwA2MA/dgGTIVwgGf1F0dfjYAMWqYqPsS5olaVR2ZgiKcFFmWo65F
	ggATJ43aSZ5jTRQTqKdN/NcmM9Ls21bp8kcstDfDxT6e+rvlFCN1u5ROXQtA==
X-Received: by 2002:a17:90b:2cce:b0:3b0:9a1b:b709 with SMTP id 98e67ed59e1d1-3b41c95f64dmr21453815a91.54.1795699949017;
        Thu, 26 Nov 2026 05:32:29 -0800 (PST)
X-Received: by 2002:a17:90b:2cce:b0:3b0:9a1b:b709 with SMTP id
 98e67ed59e1d1-3b41c95f64dmr21453795a91.54.1795699948555; Thu, 26 Nov 2026
 05:32:28 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124153811.338437-2-oss.patchbox@gmail.com>
In-Reply-To: <20261124153811.338437-2-oss.patchbox@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 14:32:16 +0100
X-Gm-Features: Aa3M54pyOdadrKqsWTiJ9nCAOq633Eo8wIVAGtc33LTwbXCOnSylrRHJagsfEfc
Message-ID: <CAPx+jO_zWB+QyYC0GBOA3YFbeypf9Pb6KteagPBkksr33_ChYQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: renesas: rcar-sysc: Fix CPG/MSTP node reference leak
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulfh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b0834ee cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8 a=iPbxsK-MUA0o8_X2VUUA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1MiBTYWx0ZWRfX29A0X5HKl1aP
 2l4N0HAaiOB5flrlwFy3iSL9YdA1sFiuSxhaoc2MiudblIVREENIvIuRZAwpGmbMVHa7x6uv9ec
 z+xdKzY8vDDpbBe91Qp6A139dsdkjHuEmm2hrcf9PZIDpbcFXLybFer9ZcvwadO/1ypc/i0pkGe
 qvPsG2GxfY6B2V+ubLN2S7g1XXpBE0H7dVqnHMLoi/SZLfRfkKtVIYNeTVewkF8FLI0ikBjp0dg
 w6ud6YhvfZHxy9HMUhTBvb+mt/q8ikFpbbC8Vk9FiQccNLsxmUSLdj8glSq/9OHHy3pGOEzcoC7
 7IHb/sbMzUj1sFoJ4KovMQD7FyoKqVGfdhBPNUuHnkfxwJh/D/uAW4yTEIj/zr8CjH9eqr5Dy8y
 5TKVCIASOyzxmBJD2mHk3NnKIHNvnQUP7J8dcoQjZmdiQe1Cgwu504NEDq80drCBOswTfY3P/Z8
 qGlZ+R1oP8eIP1MY+uw==
X-Proofpoint-GUID: xlouorTgn1b6R6fvjhVbFsaQHWUl_FP3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1MiBTYWx0ZWRfXx5be9Cjbwy4f
 PfgsdDoxtLohMWHNsmXfofulH+iJ3S6LRFtZiyyYBt8oiTfiFIWLTkc6DRmgeGDglWPbeWRNFLa
 M01RIJVclbEQbCdw/fkbBNbrwr5vxQI=
X-Proofpoint-ORIG-GUID: xlouorTgn1b6R6fvjhVbFsaQHWUl_FP3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260052

On Tue, Nov 24, 2026 at 4:38=E2=80=AFPM Yuho Choi <oss.patchbox@gmail.com> =
wrote:
>
> rcar_sysc_pd_init() checks whether the device tree has a
> "renesas,cpg-mstp-clocks" node by storing the result of
> of_find_compatible_node() in the bool has_cpg_mstp. The returned node
> has its reference count raised, and the reference is lost when the
> pointer is converted to a bool. rcar_sysc_pd_init() runs once as an
> early initcall, so this leaks a single reference at boot.
>
> Keep the node in a local variable and put it after the check.
>
> Fixes: 1c8c77f52d10 ("soc: renesas: rcar-sysc: Enable Clock Domain for I/=
O devices")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Compile-tested only (ARM multi_v7_defconfig, W=3D1). I have no R-Car
> board to test it on.
>
>  drivers/pmdomain/renesas/rcar-sysc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/rene=
sas/rcar-sysc.c
> index 3c8a44c6d772..20acc9dece6b 100644
> --- a/drivers/pmdomain/renesas/rcar-sysc.c
> +++ b/drivers/pmdomain/renesas/rcar-sysc.c
> @@ -353,7 +353,7 @@ static int __init rcar_sysc_pd_init(void)
>         const struct rcar_sysc_info *info;
>         const struct of_device_id *match;
>         struct rcar_pm_domains *domains;
> -       struct device_node *np;
> +       struct device_node *np, *cpg_np;
>         void __iomem *base;
>         unsigned int i;
>         int error;
> @@ -370,8 +370,9 @@ static int __init rcar_sysc_pd_init(void)
>                         goto out_put;
>         }
>
> -       has_cpg_mstp =3D of_find_compatible_node(NULL, NULL,
> -                                              "renesas,cpg-mstp-clocks")=
;
> +       cpg_np =3D of_find_compatible_node(NULL, NULL, "renesas,cpg-mstp-=
clocks");
> +       has_cpg_mstp =3D cpg_np;
> +       of_node_put(cpg_np);
>
>         base =3D of_iomap(np, 0);
>         if (!base) {
>
> base-commit: 8dac6df92a2e66e2098bbc69061964cfe7e8375b
> --
> 2.56.1
>
