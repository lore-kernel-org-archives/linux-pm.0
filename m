Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6743F4DEF
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371576; cv=pass; b=dX8pm02InsHGBy6oj1Pkc2akhvP3edLk9Tt8CegHycAf/h2FhuhzQcjZTO8oIvaOYe8+mrpCHsvcXv3Opp7W8Z9P2gn7y01a4MxoeT58/lwzflKno6yA/P80g8OiK6IgSNSKSrlE2VH9a/XiHco1feVfa0dVzO+S0r02F42aQJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371576; c=relaxed/simple;
	bh=n+Ksvu/zVWPobgx5KX7GBu9XwArpcsGtQQ3SBCwrIrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpbuqa43vXO50znxOEp1YLOJ0kYI2YY6c9fKnuiC+Xnksk0GcNv7WACovZPAQU1RMUwnXzKRjIiIWgZylTppPttCMTn4mOQzNAw1Z0NefGN4/RKfNVk5HOhctVJuWu6pHF0Ru0IT1aIzQS+ppiu5MEW/9L79SIsi009N8J3Cp6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ev1TpKH3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UCSWrhxp; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ev1TpKH3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UCSWrhxp"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACj5fj1367817
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 14:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TV2EQ2xg94/gFwpPmqRGt0+RWBXJJXwWFz3sZUe92ds=; b=Ev1TpKH3ebEU1fy8
	g+4xebhPHPUNEgczi4RSZlAAra5Cj91TiMJid3WIyK5/K42u1qxUcjk7uUCBQHoM
	D8o21YcfVK1/Y97choME6/qa7CdDIhuHrlaVEOIr7xgiuVzpWUQGLsJRHjecc0X8
	5OmdKvdY1UX2SdEE6NQg2yuWzpmvtnJjOYPGFJ+VOPekQ4vxFoORjT1aoxhP7vvV
	YYapTAPpjm+7JFbvSNZqrR5jaeN6QyO+1y8HV8IIM1yy0lsfCMSKDFY5nXQLSOGp
	AE5sKxscyBtkwJygu9QY3Z06kIxGDzYvIbVbErm3jiF7vYdIQvt+b22j8wAU+yxK
	2sR7gA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v49x2q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 14:19:31 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9077b4c35c5so36337776d6.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 07:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786371571; cv=none;
        d=google.com; s=arc-20260327;
        b=hCx0EzmsbSc4Bz3uT7QDThgj8qh0ddDhrcKUWZ+gLvCPTq/6Vx288YEDrOjhOmiUKL
         N3B9DfWWnSHK/PBBQN9DIRDBhAX0Ld+gfL2oC+qVhDn7IGW++QLzaCyyrgMZwFuREA7m
         VR7SN4XNh8VMG1Az/t44YV8S8SEDHX5cihl3ERAIApPBLNhqzszfZAajBtKt2VETLNS9
         y8Qpny7UykLx+QGm5cuy1AtwAxCcazJ7x2NstDdSXpNUKMYTjlg/hgdqkFvNCYpcaFnY
         vQvCB5Gh5DEf+948XDu6YURdhSFH5iAkUtOoto6kFPj1Rp++4VDSkCqigEdoy11xxij7
         Y2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TV2EQ2xg94/gFwpPmqRGt0+RWBXJJXwWFz3sZUe92ds=;
        fh=dgNIw/eRJ8z0DGM4aC7l6riafhMPMRQDDJfH4VC+mE4=;
        b=qhDA6XSUQCgSFv9AfvtSaQV3E32Bgjo+FlkT51SBO2IDO+tv0xySaeGVrSVkRRjX+C
         85hvaP5ZUGLzUTCc0b3XK8F5l606nf+exyW9qWDF81UGNWjHA/cjvDpRZVtrpyeOqCCm
         WQUQyIe7xa+eoWFNcCmqBLMLXBAsDnIK6lWeaxP+8G2qpeHKtqD7/Mj5Hw0QJ0A3XeJE
         SAat/bBU1IhFe1lNZ0/k4jB/E9P6H8OlbwGhxJGwPdNVJZQulHEdQ8dnL/2uu4+6yL+R
         wjb3sJQk+tozJDfUmuswdX6BFTCZpvJ+2ll31LmKjNLluka2GOCNctGW+xv3SmTAneXd
         lykw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786371571; x=1786976371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TV2EQ2xg94/gFwpPmqRGt0+RWBXJJXwWFz3sZUe92ds=;
        b=UCSWrhxp/54c1zxxL6Rv0OqpS43JyRPPHsFf/oQkkHaUQOuChZcrIFqUkWKg3p9f5s
         3n4EjZXaclrirDAZiiexpY/RjB8zKPSQYceo8AasR3z1PQpPvEgeb0fxo/isuIARZGnm
         JhV0uTjMlissRcg6nvjGHn721k/7qrEus1jbl/ZKMYBsYZcn3YkpDdAHKnek8QKgqNDG
         2HlvGa0bplBCE8/Lbm9A8Vhn1apQQQeEqh2E39dnClzQrj/Q/mIPMfcWawvUE4/FK8FV
         wbhn/Gfw8Ko3WABUL6XQI7uUaMwyxTUDlYcCAcvIbaVT3mJuzdGNj2EvffndKF/R+km7
         4bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371571; x=1786976371;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TV2EQ2xg94/gFwpPmqRGt0+RWBXJJXwWFz3sZUe92ds=;
        b=LODMp9cI+ZgmPYsmav3KMlI8y7rF2BJp5dUk6JSn1tftNa2BHmFJwCvOA4+HcCK/W7
         itRhuNGxdTgERCmO+tZRUrlonfBQf1UBlA7Yv2TmHFjmPJ6I9CKITYRdOilljvLdQyKY
         HtFdoovc7qAWfUa0HpemzDmoAOyHTmB7++D70usgpnFmKW/+9+vClQ3kImXH2CC3tIqg
         GI5/lb6/sgr0ibm2+bJbf2u20qTHTsxoQnxoEx73K9Tf+KYSC1qZw0a7uhe6MbpBGapv
         2dX8GYL5/S0b3gLxvCEKokipDulMHU4A30d4hZZ9yraFvsCnyWzKuzHVBed6udUfHsej
         HXrg==
X-Forwarded-Encrypted: i=1; AHgh+Rpn9S04lXBhcLSSFTUoJzYf6kCGOiqwX87j+CZU80xcytdVOTxnPSGltMxx4H73E+V2FgkK86pLsw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx50vg+/LDBl1gNGzfguLsOHcoiN2CLD/s+WDZMFf1a3klYY+Cc
	T3bkGHgin/meWL6R9Wqy/GnAe/RIySp5bxw5HzOXXXRlDOTtWHnJzDWBvty6DfjQiL6jSAlwzl7
	KtPq/LM6mj37f78/uTcMkWvT/AVVAdN3lT6oHOzE/XTWG58Y7tHaJLoxOmmVncDfywAcTBfq82V
	Xnz/Z8wtvLG2Fhmd0y9D63qACiFi56c7EpoCR4
X-Gm-Gg: AR+sD10c3KgeQ+FDATXwa7PDKvwufqA1YBTkprIWQ5MM8YvDAm8VssS5hhbesUsH0eX
	t9L38WCm1/h+K/lQFRZ2rBho0E5UQyMkQ6N3gInLuO5dhEq6HXYkfvjGheYE3Vu//jwTSt3AkMa
	ehC+AAw46WfmH7hqu9XEWKWhHsc9AZDcabWX4zZ+mTKjSl9n2dIIEm6VnEhg==
X-Received: by 2002:a05:622a:4c8d:b0:521:8ef0:b4e0 with SMTP id d75a77b69052e-52d4bba4201mr24352861cf.17.1786371571051;
        Mon, 10 Aug 2026 07:19:31 -0700 (PDT)
X-Received: by 2002:a05:622a:4c8d:b0:521:8ef0:b4e0 with SMTP id
 d75a77b69052e-52d4bba4201mr24351481cf.17.1786371570441; Mon, 10 Aug 2026
 07:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 16:19:19 +0200
X-Gm-Features: AUfX_mx3R25JFulSxbPIMFamz2pIVHYPn9K-rVq3DlUVa-mxAozC_itBBx8G2xk
Message-ID: <CAPx+jO9MZTsDpofZ0fR7FxJbrfuAV+soqN3x7ttK-F7o6MkYmg@mail.gmail.com>
Subject: Re: [PATCH 1/7] pmdomain: arm: Fix -EINVAL from scmi_pd_set_perf_state()
 on state 0
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, mukesh.savaliya@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: VDsAc8cwtDHP_d6A_qmSO_tShwF9v6Ov
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX7cySziC/28Tx
 FSCwEOkEIqD1WmgsQGPxhCdbTFMBYJtL/2tGLBEsvpZy4F6Xe4jgklCJyg6qFYf/C+krTay5jA3
 brkIVts6cHhZZvaxk2nX0jdN9d3v8a0=
X-Authority-Analysis: v=2.4 cv=W5EIkxWk c=1 sm=1 tr=0 ts=6a79ddf3 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=IN2mYG8luz48gvOoqwMA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX+NkzNFT+dtCJ
 snoq2L+9PyZBiO3YpxPcjfTey25Ba7oDE6LZ1h8Y+PKXZvDccG3ikpeL37ZQOECpuUKohMF23yC
 w5VajL+fYHqyfQ0eV6Ba/4xnJJQRc0k7MmPEjQZ/D4+sI9mCe/Pe+kX2XAevUKonhLuCeqktSpj
 au3g0Wws/I8GHLk46FdQCWqZ9Gl932RXaeXOXg0m1QRLdpfLigmbmoiJ7SWmCq8IIF8HXsCrveD
 v00rVL0kSdCgRI1EhEN2aZbnsz0GbIVkV9cO2l/HLWZwx3B1hM05kT68cR6qPMAvtp8/nxbu15Z
 WtJ7aVR/hYtalRGOMhxJ2PP417VQ4Qra1s9XVWOc2chKO1L1pUNa8BXx3bPs/pSgNNue/HgCWbx
 bsnAnXhEmhNuFcWIF8rfZK6cE7NZee1NN8hdJ4/O6q1NFpD1m8veGk/x0pF6KtnP+oTzFhme7hX
 Ec86XK+LYZwiIK3Axgw==
X-Proofpoint-GUID: VDsAc8cwtDHP_d6A_qmSO_tShwF9v6Ov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100123

On Tue, Aug 4, 2026 at 9:58=E2=80=AFPM Praveen Talari
<praveen.talari@oss.qualcomm.com> wrote:
>
> Currently, scmi_pd_set_perf_state() treats a performance state of 0 as
> invalid and returns -EINVAL. As a result, devices attached to SCMI
> performance domains can report failures when relinquishing their
> performance vote.

Yes, this is indeed a problem. I recall that I hesitated when deciding
what was best here, returning an error code or 0.

The reasoning I had for returning -EINVAL, was that I didn't want
genpd to believe that it actually succeeded in setting the performance
state to 0, when in fact it didn't.

However, except for the problem below with the OPP library, it
actually also screws up the internal performance state aggregation in
genpd, potentially leading us to running at higher state than
necessary.

>
> The OPP framework use performance state 0 to indicate that no performance
> vote is required. For example, dev_pm_opp_set_rate(dev, 0) is commonly
> used (by firmware or linux)  when a device is runtime suspended.
>
> A zero performance state does not require any SCMI performance request
> to be sent. Treat it as a no-op and return success instead of reporting
> an error.
>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

I added a fixes+stable tag and applied this for fixes, thanks!

Kind regards
Uffe



> ---
>  drivers/pmdomain/arm/scmi_perf_domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/a=
rm/scmi_perf_domain.c
> index 3693423459c9..e390f902a444 100644
> --- a/drivers/pmdomain/arm/scmi_perf_domain.c
> +++ b/drivers/pmdomain/arm/scmi_perf_domain.c
> @@ -33,7 +33,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genpd,=
 unsigned int state)
>                 return 0;
>
>         if (!state)
> -               return -EINVAL;
> +               return 0;
>
>         ret =3D pd->perf_ops->level_set(pd->ph, pd->domain_id, state, fal=
se);
>         if (ret)
>
> --
> 2.34.1
>
