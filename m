Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03591414438
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165712; cv=pass; b=HJB7dOOZCIbCqS+Hi+cOojkqimxjc3ED3ifb4OaYgG1Mxq4GWOTef1eKZcAuxS0dw1a2D/MPf/I1grAN2bPat64+FwpVgDolKjg1W8QF66RgC/QVLnz4Vh0JYnxVQMIxvJPx6cxjRvRFx6dF2xPTs5n4mXcwhRQ1051VynZnrNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165712; c=relaxed/simple;
	bh=jERV6hkQLGrt5ORnF8n+PYed3l0YVNQatPqcbbxs3bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1MlH19oo/phN9/nuCqjSKYhokjdDcnoPql4GvFafSCHzIcGnbXoYcBwfsJVdheyPb3ifHJLUpwjC32eEEWABtHae5ennm5M8HE47Je10h9Bi0DVc3sgnyl37C4Hc5ocrDlab7VWgnwX9ymai70LvzOz/9WLyMZ/Sp9U82yHbOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I3u/C6Ka; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cuLcbLjm; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I3u/C6Ka";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cuLcbLjm"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbV7F3027964
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 12:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fktn/LhG8dTvstUPUwN7AN5xYcPEg9UCV2BzUJUfCOM=; b=I3u/C6KaUblZKqAR
	F3O2Vg+wFPJbGyQWEilq04IXNQnOmF9aTZdjWIsNXr4/ZQc2/YsVmT3sQTn4k4ZF
	tiz3peVkcm/yU4hlixEV+qip7Yk5L3AKW1sERvl0ATc05g1HKcAarfymTZW9N6PV
	756n0XbUkiS1ZR4Dyb4d14BYpl4byE1NHePbTzPS/Njz+IfuhvVvyKZzYO/GOoYu
	HGj3N9oMQ0xv5Ag/YGCPnmsIm6hjmQRl0SGMCXugsTO0WrOmOcUR9hE+DwhxgwYj
	Iaf+yGPztP9iwBJ7BUxbUJbuRG8vklr3I0CGej0kCsLenFaDIOVYb1mnQoTsSK/W
	HjqjLA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwarqva-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 12:15:08 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39e3c10ac70so1428316a91.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 05:15:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790165707; cv=none;
        d=google.com; s=arc-20260327;
        b=Zs03Mx7uFFvwqzuMwTKl3u6FNptzeRSazAprjRqtCf5AkxR6EWCC/B9FZRfpGEqE+R
         SnfQedSLde7dxyWXtJ1theVz75Q+wOMcl+IvPY9l97c47lgEe5WIpgB4XpT/pQqlsQJ3
         KqCc1e1wQMKmo47axi6jY2oA0Pmb+YqpMnjHH4MmehZGX5nrwSaej87fxPq6zgand+mG
         BozHDMpovr2ZC0UMArRbtpuR+ekkBoyj5WVVT95uGrZS6nDIh4O0sNGTrJhis0oQZ2ue
         n54knGj6ONkNTRkTYcpKVIeIqsj7GvenxNrePOrSs6QjJQJA8cCSUWux53Uux79QRR0L
         LpdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fktn/LhG8dTvstUPUwN7AN5xYcPEg9UCV2BzUJUfCOM=;
        fh=t08nPXadg7hreL1sDpLmX5/4Smq9OGRos1HMG4E2E1M=;
        b=n8a1p6DY3DTERl06Ifpl+IvfSjpCKVFE/ZCzZY0PHeBipg1by40TaxB2Jb9jwRIR59
         iS2CqIgIuxF1h0G/s3MMbLLXIGv2asl7A45kKan+ZDmPuuYGx6xDgE4osVlHlNjhcl+I
         gEYy0CyOwzKChWNdWCPxlV/KS97hCuDYTJyANHYQhFvHhcDL3cbdUrr9krxe66mFz1Wo
         hXbxLGqcfEVecSazv5OE5TB7Ug2a1WNvxo6dvQBlien/98LMXMaij5+g4NgWF+kt2xYZ
         los5qvpfRStfT64GEAcUgI2LQ3ii1oSLYvZyHmzgLZzmfvJYjkCFf89K9Ef1dWzbep1h
         pTGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790165707; x=1790770507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fktn/LhG8dTvstUPUwN7AN5xYcPEg9UCV2BzUJUfCOM=;
        b=cuLcbLjmmJqPjF1XQx6XELF6QYW15CxqTFNB3JAYomfsv5T8ilSP46HONZXarEVSFL
         x+aWnaG7V67EeRRCvsZ7WDmucYDP9juB/wzg7rsxMwz3eUPExn23uBvf36oIxYsG+86R
         MApcB+2PHuampbsvFfxEH9yzt7C2WxDox0Yar+XEY4+a2Xs1sU1RpthUvvblvq0z74qA
         uHQ5SSvgBuCMuzn1ePdyc/o0WnPpm9fAFaG4qQ3+L90UVJfD4mvriR1HKpmyTLZ6hcBU
         sC3uUmXHSFXCAyYv7vvTefeW5Q7Vm61EqTuyLatC6LJaRm5SL1QqzzCVhioCAfq/5gAu
         T+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790165707; x=1790770507;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fktn/LhG8dTvstUPUwN7AN5xYcPEg9UCV2BzUJUfCOM=;
        b=Y2CIsalRdUEsj07DZLJXihzjZvkgr+Z1ki4j7LrlFUiN7we8JkTkiDN1DQTpT2HYCM
         6aH8CJCerGT74nJgmG9KYrPqJHyQhN60hr+0DZHnwyWgcV0ID+yfde6c93N5j+5tBrtd
         iyy50jW9W0gv5yBiTGxKmB7hKC/JM8XKvhrLy1Nd2JHL4FZCD+pJfJZKf+/3Nw3a6ah+
         8ahFNwQBr0B4bORTlT/Ay6ugo76ZIUbmzMEOk92FtFgkraQKn5abAJbk44QLIyXWHCHy
         9pg0g9EMdiGC3QJ/++GNBUrSQFo6cxOA5XQcuM/4tjMwUF5nAF0ZYX6aIYcH9NE2yt6O
         iKaw==
X-Forwarded-Encrypted: i=1; AKwUvBy0JMTWQpMkD3WHTJcQpjzZIh/9bkJIh/2URHGPfyLrS5Pd6daRgOhZbZy4q7hbmvrB0gdYB3Dbug==@vger.kernel.org
X-Gm-Message-State: AFuF++mkPBmdr1nlnFJsq+enewP9xNCVhN4vLDlIlA7W731aml+EdcI9
	6y8/2RwzMYuWU1F97NQqAe9RZ5F+4VMfowpNoA/pvwxl3nBa1jrY5jefQWwr6oXfUyFGkGYB6o7
	Wcq6BEKrHJzRsfhsWpSJVwXlNhi+m5GI3IfS9hwCzrwLZwtymlU8PkCJrp5m6QR6037kMb3Xzuy
	rZD0rc6SKTWzkrS3DqMa4h1qSDhqTVb8U5lldy0jJkbbBS
X-Gm-Gg: AYBFou3tl/RJypQfUy3mu8VxsBAXXn8j0Vf6rIUJzn08ppBte9SVtxhbmzotTUGvvtF
	r9cytyLp1UpmHWLokEMJvMDva5WPSr3jdmmX2LtOKhEMEw42CAiwFl9yvz0veYPgV2QEBi4bgqt
	ZqcqaJGbCVdj8wWEgqtnVOe/KDnl9ogEcwspzqs2+62i8EJKNpdwZxzbp9Ow==
X-Received: by 2002:a17:90b:5150:b0:39e:4c81:6c99 with SMTP id 98e67ed59e1d1-3a07e6427d3mr2204050a91.31.1790165707441;
        Wed, 23 Sep 2026 05:15:07 -0700 (PDT)
X-Received: by 2002:a17:90b:5150:b0:39e:4c81:6c99 with SMTP id
 98e67ed59e1d1-3a07e6427d3mr2204025a91.31.1790165706997; Wed, 23 Sep 2026
 05:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920175928.42566-1-s.shtylyov@auroraos.dev>
In-Reply-To: <20260920175928.42566-1-s.shtylyov@auroraos.dev>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 14:14:55 +0200
X-Gm-Features: AcwNN1XX2TwqwRb1ZoRjaB9CUImpJjiTV5b_h3ECFgJFj0KO-kS0Qy6oSUUekgQ
Message-ID: <CAPx+jO-Ph038WJQ4gMH93XzoMC09+meht=yT9JQBAnTD6HzGEg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: rockchip: fix domain check in rockchip_pm_add_one_domain()
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Caesar Wang <wxt@rock-chips.com>, Kevin Hilman <khilman@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0OCBTYWx0ZWRfXxWMKE2y84Do6
 6UjV2HKa5LtveBGl0iB17CoBn0rkQFdMecVBlDHizO8TMZ5Gwls+byATONJPNV+KpJORCqrledi
 Ho02oaEQTizAQeD5joBmV7nSYTWWbv3x/8IXrT+6TSZri+B773BGobqkJfqxTfBmOMK2IoeFNld
 Bkc+buMxwz9aVxiiqGj5TCDbh/YA1GUfRXw3kvLBzBApLJoentZ5lmn+1pk2YZ1o5deFdtns1fM
 n907H246HrbL00yo2ppVhxOvqOq/iAAGbPjMO+pN2xXL6YHYrgTNw51nG6uU3HNBqe9A1nTMGuN
 iEsiuBm4oPd+5lhDoVl62J+ZwMpF9BSTSkmXvOv1p4Ev3f/XVTpQOfGtmNrQ71SXxlq6mUAInc/
 2md0iv5dw03UPLpqpB68ICyZFlAVLt8gTEjsTHd8tyksVSYfOAhQPVYgRSFRpeWSkFoqM+OCm4k
 s5rNs/9tyXyjfXVbPVw==
X-Authority-Analysis: v=2.4 cv=HfuB3SE8 c=1 sm=1 tr=0 ts=6ab3c2cc cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=HH5vDtPzAAAA:8 a=9fon7Y1cHxUUJadseLkA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-GUID: LyigJL4yu3zFztmC9Y7pTHkZjXBofhBB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0OCBTYWx0ZWRfX0KU4MoonbOe0
 y7OvaycAv9OrCjkoF10OeEYUT9V7gQMArOcnTzrio4m0jdGgK6eKrRgD4tPreog+iQKG1PTrzwl
 xc4GWeHPibolC0pyUexrhuj/GcoyREY=
X-Proofpoint-ORIG-GUID: LyigJL4yu3zFztmC9Y7pTHkZjXBofhBB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230048

On Sun, Sep 20, 2026 at 8:00=E2=80=AFPM Sergey Shtylyov <s.shtylyov@aurorao=
s.dev> wrote:
>
> In rockchip_pm_add_one_domain(), there's the check (most probably for
> the case where the "reg" prop has an unexpected value?) which doesn't
> make much sense as the variable pd_info will be NULL iff pmu->info->
> domain_info is NULL and the variable id is 0.  What does make sense
> there is checking pd_info->pwr_mask and pd_info->req_mask which (as
> seems to follow from the code) can't both be 0 for a valid domain...
>
> Found by Linux Verification Center (linuxtesting.org) with the Svace
> static analysis tool.
>
> Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain drive=
r")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

Applied for next, but without the fixes tag, thanks!

Note, that I am dropping the fixes tag because if there was a real
problem, we would require yet another fix on top to get the
corresponding domain declaration to be correct. Yet, the patch is
useful as is!

Kind regards
Uffe


>
> ---
> This patch is against the fixes branch of Ulf Hansson's linux-pm.git repo=
.
>
>  drivers/pmdomain/rockchip/pm-domains.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index ba66ae719428..69792e2b215b 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -809,7 +809,7 @@ static int rockchip_pm_add_one_domain(struct rockchip=
_pmu *pmu,
>                 return 0;
>
>         pd_info =3D &pmu->info->domain_info[id];
> -       if (!pd_info) {
> +       if (!pd_info->pwr_mask && !pd_info->req_mask) {
>                 dev_err(pmu->dev, "%pOFn: undefined domain id %d\n",
>                         node, id);
>                 return -EINVAL;
> --
> 2.55.0
