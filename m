Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795620280;
	b=py4z+qwKwZlFJhpiYHBEzJP6d2Pgh5eqJDmQ7wKMMJoQti+NGVVlXlxroTp6bOyoqxsj
	 2KcRmwiLeEmng0UkqpLFCZGHILkkXnKULF6z9tTBp/COwXgzPrASCTU0zkV215rDCS1PU
	 UfvlnsSJ3xnYOzbpdyvc4KG4i0SSvPYwnTT0fIlehFB40vhloF8XZffEkkKItjgpEMa2X
	 huvGJfIcDtbtf21A5H3A6CG6y3PgXXVTzeRajaug5i+JyTT5IM74lw+Pw1VpUIRERQZIi
	 091xHOlBtEKtc945cuudY5KuAXis+IFpzH04/ufxSIOmdf5PsqFlePa3vm+LW8Qy3Bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620280;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Y78ML+3fbUAaF8Rj9Glw+6B9XuZYkePan1Q5MsJuoto=;
	b=4HBvUWporVBayalShW4Fa4dvOcoA3Tv20YWwcGqIMyM2tfzM6+jpOboDCrqoAi4eZKyS
	 StJWcNxXyNTeZh5/n1thDzpv/fcEicmwiXl0kknwjeRMIeiyluMieFtiUxn48ZP0ZlQDn
	 UtyRUZNXtzaeDoMBSjsAIKEPD/RkuULRaKQuCq5r8hsath5yhHct2Nd2SVfrOmu7lIA29
	 mKyCzD3ZP/gq/64nhyc951pojB6LSbhFp0gDSGjAtPZ9FJxpqF8wKIcPZdmOHjhbUrJ2x
	 XJx17ARZox0MVA338cYYFGzmvmoa4J9WnRWU8/uUPAZJKhWhd9ZtY5RM3meZ+jfqrYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yuo1goiJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TRgandMK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B778E606A31E
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B778E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yuo1goiJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TRgandMK
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEM4wP539748
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y78ML+3fbUAaF8Rj9Glw+6B9XuZYkePan1Q5MsJuoto=; b=Yuo1goiJ5qmPqUx/
	ZyTezbGG4xC5I59wiMc7Iz9T9+7q7RIcmrIKDNOJsBeSndc6msBmsChfMPPTo05Q
	GMdzgqrGWl3VFhQM1t3yQtSq1UJGeC/ks9BWUf1YbvsMMwp9l5za9uQ3JPLF3hB4
	lKYhuTKLl6jhKOIpkf+wdt9x78mxk3rt/0UJevle0lMv2b222TCemjPLr9DhRDc+
	3+D4JfF1uZcdDzHIdpCcQlbClrQCza7wwsAelxuYA8mmSlvTgO7yM33bxfUNvmbg
	xsl43Qdsj6vbS+cbITAODU4lIO6QVE7raCl0rOFhvdTg9TKE8kkTN/Vh7M75WvPl
	HsCpcQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vuhshn5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:24:38 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd66551e02cso5478810a12.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 07:24:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795620278; cv=none;
        d=google.com; s=arc-20260327;
        b=Sg1YemaMB3LjdSdju4a9vR8WyFJ8zSUarmy9tXXmHKX73k23Z728jGKr0RMshcSQYp
         YcS6zN3GuowG4rDFyyDEzIisc6UYybK0B79l2K4Ri/8VXDuBi8LHvr9XAI5WzhtPp/yN
         Hhcc45cXOng4afjIGrxgTz65MO3MiChGMWUsKRX1jYaRvpHHVHKh3D7fP525gmGIGAxA
         9NCPCR914fomoYqakmu3zxchHG/c3Qnlme5XdyLXa/wqa2e0umtiAUHae93L4rxBnOZF
         K/mYAXStB3vTRcSiY5jXjZz2VGhq7c4Q2oUgeYvnAEY2ciixgbzR+PC8lLbJn4W6VVuu
         TUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y78ML+3fbUAaF8Rj9Glw+6B9XuZYkePan1Q5MsJuoto=;
        fh=ygm2o1DVjGF8pKTpZgJdX2NmPR5eb2wnJokJR973Rl4=;
        b=rpTTQY9q9pdauemIZ8VKIBYQ7f8gnlDjAQCtlrtJWUiS7fmYKDycZy5b4nxW9574c2
         oeH3yzKkDKW+02HlyF0DWoD4eN59yO2hek6onny8SUqY1pGDERVWJY0yCEofuiLv8lUN
         2G5PqOUCC1Q1JB2O0wCrRSgwbPEpL7yze6Hhvhm2e0TuYd8Q9Z2x1DuqjWilhGZmXFwK
         17luf6L7LBIVjkA3tvsQExITZFCrZbtX23qaptWpMuY6qpCPNfQdgf9PoweKw+7olLce
         pk+8s51rxHxtm+F1vIm5OiiKyFioHq56gtXswcIphlph2+AeprWv41inbgeijincHFoC
         ONwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795620278; x=1796225078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y78ML+3fbUAaF8Rj9Glw+6B9XuZYkePan1Q5MsJuoto=;
        b=TRgandMKNF5AzonRq1UFnYRWtOxA7V5PSdr3sLaV10+vdzd62d5oDCXe93RttHGfoh
         XXhLqeiO6rPDHK8wY5jP/mI48Z5kze+E/4sKlQUradUhPAZji1ImJDEkBw/NQ3LE4Uwo
         MCzvdmFNDivVYJa6GT3BXQ0SecvSAPt+zQQrV3Nxusfa0lk5Vth6wGUk/JJrkVEfMD/c
         sC4lbhnMgwAHdMCod1S6VRHxRWcOIVOqqODF99q7RYVVymkBNRi80mt6ttnVdIfwikOK
         EF/mZYUUUq3dNc3e4zXII/v/s3IFkHbd8z2dGDphwxXPnwoohKAJHc999QE45NnhRAaX
         iE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620278; x=1796225078;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y78ML+3fbUAaF8Rj9Glw+6B9XuZYkePan1Q5MsJuoto=;
        b=k9c9Sg8WL8zUiDOehVSk6Tq+ByNHqXVpMLYvuqYOmmCq58N4g/U85a4DwGSW5V46Un
         JuE1Pkemb09dE6kGjat5Iv8569RE4SqeKAekGRaSjVGHp/oWZSqCZnOmD7zHr9qaIw3K
         ewEWujtO/EwzAQvUuCuxgl6kdUf1HiiYb3aV1+YEhwBC7e6nkUlT8HYSPrx9WlucG9vi
         8le70DpPz4uadc0+GHt/iGgdJvy+VKdxEN0+0wq3Ap2FfQI5bNRSZdvFbxtvON/0gSMf
         dsDoW1Vm4FkK4qpBSpU9m5d5nSoGLJbNaJ97Ld1vQhaqWzeQMtKpjCmKcA8hhKJugFjZ
         PH0g==
X-Forwarded-Encrypted: i=1; AL+hErFwbBjFOXiOGvs1sdBhZ/SjLErP61hGJba4LcHEdCLUOBESOA/mS1b0sP5FRe8/Ea+kychdTKwxlQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/8Ub1XMCW1IGSp1DPQUyC6EV4txJX3nBJZneQU0CNDFKnceFIv
	gbB2F4C4+GIYt62FdC4wLpQAS8rlem8c6k8cGdMRV1beOWVzT9GFXtwRPIKEAOi6b663PLAWU0L
	rLJSnbG0PhAkzQIXuGNENu36ajXmm6p/4lH0axMPaKAqPqlOvPwr+RQP2xPaIUVrnjIJbX1jUqP
	1xY+su2SgoMpo03OBSNbxh2wCc235pA9dd1MSb
X-Gm-Gg: AZFdTZcBu29IXFmKnacFPOCzF1Lh2Whm19h27i3X0PpJZupIQVWZkpBC28XrUrgYVkA
	QykxRhp2QsYN3+CbxWIPyKErdrU5yKsVUfsorGJjHCHui0s4s3QN1R6m9pYR2VuxfbzGoH/ByG0
	I9ojKV48UMXkTVhCzdSjs25qnKR/zZllmOqTp0MdV0Ng7ePni6UlEbEghdog==
X-Received: by 2002:a17:90b:39a3:b0:3a0:9c9d:eb18 with SMTP id 98e67ed59e1d1-3b41cb20e66mr19332081a91.54.1795620277326;
        Wed, 25 Nov 2026 07:24:37 -0800 (PST)
X-Received: by 2002:a17:90b:39a3:b0:3a0:9c9d:eb18 with SMTP id
 98e67ed59e1d1-3b41cb20e66mr19332017a91.54.1795620276536; Wed, 25 Nov 2026
 07:24:36 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118-fix-rockchip-pmdomain-power-on-rollback-v2-1-3e4e93a19996@qq.com>
In-Reply-To: <20261118-fix-rockchip-pmdomain-power-on-rollback-v2-1-3e4e93a19996@qq.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 16:24:25 +0100
X-Gm-Features: Aa3M54o8dqLPD5uB-WeLwhOdO6CQFYha7MYFNep3S3olWqjH0jSGnIbrJ4DpKTk
Message-ID: <CAPx+jO8hTrAAoZgJKK91yF9z3CaiB3w4DRvvgDz=Zm_zxU6g6Q@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: rockchip: Roll back power-on when leaving
 idle fails
To: 1579567540@qq.com
Cc: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6b06fdb6 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=c92rfblmAAAA:8 a=dZbOZ2KzAAAA:8 a=bC-a23v3AAAA:8
 a=VwQbUJbxAAAA:8 a=mFHk9SUb-_LhEKcCAXMA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: 57EAUJ3TvXZVV54FKAaXsww5tB2UDQmb
X-Proofpoint-ORIG-GUID: 57EAUJ3TvXZVV54FKAaXsww5tB2UDQmb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MSBTYWx0ZWRfXw5w3cJ8y4EbC
 5o+yKLdXRLm1munmAC24aeMo97yw/nRdPHPT2HDa23wC4x8dynfRFY4Vbf8PBFgZAqu5gl6yewH
 Znv4Q+cJYnjoTZNJi6XeGwq/m0zg73k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MSBTYWx0ZWRfX+px2O/hrPsGM
 +OMCkMd1WQkFN42v5upHZ0/HCIBf0/6hDvkwxHLnNuB3s3oc5Jbalg5bbQcTE7JC5f65cmFJ02o
 DT19g63fbm9PlDHvCx1GqV5pqXEOygumtcYFy9ZYhW8ZLSLz2RmRlkzsIWp9/FtBUC6fc1m0TYS
 CFZaLtYtXP01P56gk6G3/F5+jIo3hOi8+mzAKKOEz5roOhTztcSSpF3QtGRuWbK5FdQomu9dUWk
 RsqYkTn6ED47qdm6IL5JIGnb8AU7QR/HT5jZyQHCiKBC+hE2isvIFV/G5xuoS8OVgSskVWFWyvn
 mvaj8AIK6/m+czjVhIeHrjn9R5EOBTPM1YsG9h/2DRwDIx468eQxHjD5Fji5fyKIP7ZA7o3ifW4
 OFKGTAEgwd0SJaBTRj9raKvQ0A/ADtkowBS5+mB+DwzHma5XNhOciGOagX19SQgzHcn09PH37gb
 4yZw5cYnHtuEhN5jWZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250061

On Wed, Nov 18, 2026 at 10:03=E2=80=AFAM Cunhao Lu via B4 Relay
<devnull+1579567540.qq.com@kernel.org> wrote:
>
> From: Cunhao Lu <1579567540@qq.com>
>
> When NIU idle exit fails after PMU power-on, clocks and the regulator
> reference are released while the domain remains powered. genpd treats
> it as off and may power off its parents.
>
> Request idle again and, if successful, use the low-level power-off path
> before releasing resources. This preserves saved QoS and notifies
> firmware while retaining the original error.
>
> If rollback fails, resources are still released and genpd may power off
> the parents.
>
> Fixes: 6b2690df3f03 ("pmdomain: rockchip: fix rockchip_pd_power error han=
dling")
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> This pre-existing idle-exit failure case was reported by Sashiko AI
> during the RK3572 mainlining work:
> https://sashiko.dev/#/patchset/20261022-add-board-ok3572-c-v1-0-0b0fd85a3=
1ee@qq.com?part=3D10
>
> If leaving NIU idle fails after PMU power-on, the domain remains powered
> while genpd treats it as off. The error path releases the clocks and
> regulator reference, and genpd may power off the parent domains.
>
> This patch requests idle again and, if successful, powers the domain
> off before releasing those resources. It preserves the saved QoS state
> and original error, and uses the low-level path to notify firmware.
>
> Validation:
>
> - All 48 host simulations passed, covering power cycles, idle-exit and
>   rollback failures, QoS preservation and error propagation. No sanitizer
>   findings.
>
> - Hardware testing on OK3572-C: 20 patched and 50 unpatched NVM1 power
>   cycles passed. Request-write injection caused native idle-exit polling
>   timeouts. The fix powered the domain off in 3/3 cases; the original
>   driver left it ON. QoS and the original error were preserved, and
>   retries succeeded after removing the injection.
>
> Persistent rollback idle and power-off timeouts were also tested:
> resources were still released with the domain ON and genpd OFF. These
> failure paths remain unresolved, and genpd may still power off the parent=
s.
>
> AI assistance:
>
> - Codex / DeepSeek V4.1 Flash were used for:
>   - Reviewing and adjusting code style to follow community conventions
>   - Automating tests
>   - Collecting data
> ---
> Changes in v2:
> - Rebase onto the next branch of Ulf Hansson's linux-pm.git tree.
> - Link to v1:
>   https://patch.msgid.link/20261101-fix-rockchip-pmdomain-power-on-rollba=
ck-v1-1-59a45783e33e@qq.com
> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 6abef60a5b4c..2c021784316a 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -648,6 +648,29 @@ static int rockchip_do_pmu_set_power_domain(struct r=
ockchip_pm_domain *pd,
>         return 0;
>  }
>
> +/*
> + * The caller holds the PMU lock and transition resources. Use the low-l=
evel
> + * power-off path to avoid overwriting the saved QoS state.
> + */
> +static void rockchip_pd_power_on_rollback(struct rockchip_pm_domain *pd)
> +{
> +       int ret;
> +
> +       ret =3D rockchip_pmu_set_idle_request(pd, true);
> +       if (ret < 0) {
> +               dev_err(pd->pmu->dev,
> +                       "failed to idle domain '%s' on rollback: %d\n",
> +                       pd->genpd.name, ret);
> +               return;
> +       }
> +
> +       ret =3D rockchip_do_pmu_set_power_domain(pd, false);
> +       if (ret < 0)
> +               dev_err(pd->pmu->dev,
> +                       "failed to power off domain '%s' on rollback: %d\=
n",
> +                       pd->genpd.name, ret);
> +}
> +
>  static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_o=
n)
>  {
>         struct rockchip_pmu *pmu =3D pd->pmu;
> @@ -682,8 +705,10 @@ static int rockchip_pd_power(struct rockchip_pm_doma=
in *pd, bool power_on)
>         if (power_on) {
>                 /* if powering up, leave idle mode */
>                 ret =3D rockchip_pmu_set_idle_request(pd, false);
> -               if (ret < 0)
> +               if (ret < 0) {
> +                       rockchip_pd_power_on_rollback(pd);
>                         goto out;
> +               }
>
>                 rockchip_pmu_restore_qos(pd);
>         }
>
> ---
> base-commit: 6f5c8ec9302c5ad8904dbdfe8cf2a538ff835572
> change-id: 20261101-fix-rockchip-pmdomain-power-on-rollback-c11e1014ef11
>
> Best regards,
> --
> Cunhao Lu <1579567540@qq.com>
>
>
