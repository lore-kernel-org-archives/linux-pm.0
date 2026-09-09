Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395005505EF
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955943; cv=none; b=IEf3TMKKjMEIxfNhx6FZiLcwjKZjEyRL7dixl9rekwAs1mFXv+MKTjTnczSKaGfb7e8QuuFq8RRdDwMJ4yB4EKEZr+tru3255HzufHZhsjuacvm5TNPybyXH6WaGC9CdlqZi5FLiN0WqgRkSnjz6lx8HZ5x4EtjEMIieqFFC+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955943; c=relaxed/simple;
	bh=31CCzmJ9mUdDNRl82f6pdz6H2VXsBhLBUJvmcItofrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar7xQcSdsj1NGiU7gE7F3T/gWyBklMbpnECx92ASSSzgOr8+9fiqeTShO4XnRrpXobJ982tHMKllE16kMOCocyy+l0ALikeeCf6rub+DGDH1FUrAauzK8ZhVl0pA+BIc5xzdtzHMveB/+bnMd2uWQ/K3I2WiLsd1GkgKrMvs9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JRIeJlJl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OJdKI+p8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JRIeJlJl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OJdKI+p8"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BUKwU1843189
	for <linux-pm@vger.kernel.org>; Wed, 9 Sep 2026 12:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1BTQYNCRWWifNWNawrPpsyR4
	zn15wpTVJTQ9AFXK2Mw=; b=JRIeJlJl8X6YtscUPWlEZoXb8vqsBhqoyCyD1I6m
	Wj+dD6VyxADamLU74QTGu9HSfnT1V1kZxb+ah3kPfV/T9NcmB8bzEFgzjuEE7/4R
	jAbWaZkHxXUbn1qFUFEx9k3vaE9prYApK2To0IolK5RgLj9VtH0yQoyd0wiKopYm
	udC2EDIuT8wsUrr7FcyV1jzD8qpa2qNf75tJlXwJGfmSolLtEmltFxtTOtetwrl6
	zxAOXylgiD7AaCnfd2TcAXpSniHeyTSGTIaZ7g7Gbu6KYfWn93knDlg/9lUzicUc
	2bN1TBGMuzPzr51geupqZVCM+8cwogNfNzcHsO99NCTplQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjxqja5dn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 12:12:20 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6751db2792dso780220137.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 05:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788955939; x=1789560739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1BTQYNCRWWifNWNawrPpsyR4zn15wpTVJTQ9AFXK2Mw=;
        b=OJdKI+p8um+KDYErEnBlW+HIUmnG2vSXkyFgsVpYVKtAfQFbfTW87GYnN+xn8+NbBq
         zYIc9JobNkog75UlP3Dv7A3okIFSgX91J78obmPA/HXbc2xLu30EcJBKYTHO6FhjrkZM
         d83S1uVJ4dFr3qq+V98K2TsFcurWE16FEtAtVvB16IkUd8EGKB4AvXcWxugJlfy/FPQE
         zGXSXPFwpzOYXB2VbvGwHAx7pIF54iZfPZSdfc2oEbn303ZYpZvjpavsU7bqiKh1t2m8
         k+dTlVlMfii0/v9v1f2LxajAdQjIOKGXkIpS42eT9b2i7XD5rlbE4K58K4VSZCRek0Ot
         y05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788955939; x=1789560739;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1BTQYNCRWWifNWNawrPpsyR4zn15wpTVJTQ9AFXK2Mw=;
        b=LIxKA4HpmQSmWFrEDrwxp8vsaNZGTHMZqNlzdudfbe0QKBqP23bcRH753TqsiPwBEG
         bFZEkyurMZqOA0dESaeLn2BLLGoZ1QYS09J72jMXlFQ7N1CXZGLJNizw8zx8hgGLCWz6
         gRajm9LXVOEu4t0PEwJ/UKWI1S1k9wNrNfgNcnyqFRV+DJiLDxs0k8NITUbaaRTiDBO9
         v1DgQgNeT4jhOohe9u2gbSva1SaatAYc8i6u/efzWWVONZi8NptTRkeu/vxXSnPz+rY/
         ErYKbxBToz79Sf+xn6KjtFDnzjHpknjgvq6c7D8BwjG0TSDLoa4oT6OlJpl9THpi27OO
         x1bA==
X-Forwarded-Encrypted: i=1; AKwUvBzuQ4OpGgZUhK9Of93O2HrSy41Zqcv6eCcdGxEewbpY/4ju+9l0RBkqlf8mWfO6rTRxgB2n+Rr4WA==@vger.kernel.org
X-Gm-Message-State: AFuF++lFFxuO1DzypcrYHX2RTkOspexAaa2eSwxrEbrxBWPfUPu4AIyF
	eT0DWSmpo2D3HCl58laVQmMuUKtCvfHcu9MM2G/KV6YAKUOhn37KxyQ/ww1ub6gRhuQfck/YtRo
	Jh8zxst8Er6uMbkYPCD8XMLuPKCXsHIGN0K/1gM3kX7fTv446lLJ+58DM8gjAgA==
X-Gm-Gg: AYBFou10UGBUFTvLK8EX0AI68Jgcw2BfdzDkl2eoYrwq94TWPYtw6X2+ZBO8cekfm4M
	xYHEZ+ZlhsWr3Rf3BIrPDX6++ehzCkpmqhldLifhwNt4r9STJcXfXKRt0m0hNteJAO5FcFFJS35
	Ggjl0JtP2Q4FOrUHSDwAzC47S1B5lMmVGy4xffVoyTsQP3AjVpdCt0EQ05s9L68nkWRDJfuM4Pk
	GRyipk3tGesyhO45yVQZKKHT4dXl+IW1ujNaz/D00+qKz4ZVmoMXXX4fKIvcAOG67eKC7FftgtE
	KrRrUrAnJxdrXozfxPHsWBsJ0T2EuNeKstvtx1wqTJY48AJBw7ZsYAU4Nbmg+vRTLHQYpoZMAR/
	l8z2SHeXj8vzZsUo6xQsN/BZ73Fg9IhigO6BfibbmhOtVGEMCacDRWhm+6N2Fm11yYoxP4XKXki
	qo4OqBWK5uTl3d
X-Received: by 2002:a05:6102:54a6:b0:785:e069:6c5 with SMTP id ada2fe7eead31-790776ffba8mr289214137.8.1788955939219;
        Wed, 09 Sep 2026 05:12:19 -0700 (PDT)
X-Received: by 2002:a05:6102:54a6:b0:785:e069:6c5 with SMTP id ada2fe7eead31-790776ffba8mr289186137.8.1788955938751;
        Wed, 09 Sep 2026 05:12:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b74cbfdfd7sm3249322e87.75.2026.09.09.05.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:12:17 -0700 (PDT)
Date: Wed, 9 Sep 2026 15:12:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] power: reset: qcom-pon: Drop reason shift for PMK8350
Message-ID: <4tghecpbblnbyqbdj2y2ma553sswccycw3hflspqoxrvr3d2kq@q5jzvzwq3jah>
References: <20260907-pon-pbs-v1-1-cff2f5810769@pm.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-pon-pbs-v1-1-cff2f5810769@pm.me>
X-Proofpoint-ORIG-GUID: VCBaAPBogIh2B1IAaidcsHoXU-iRQGeW
X-Proofpoint-GUID: VCBaAPBogIh2B1IAaidcsHoXU-iRQGeW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEzNiBTYWx0ZWRfX1eeEUNwGBT8e
 hMC6daajAJgmjQRXnMnb6fvzQ3pAm2NBkRejRNFWk0jRdPPYlUYEUEaeP44K6Y6fiz77OdnvWve
 EOFt9E1ZqvWgESYHWUdD+qlKTjyJyJ3CLOVPR0tX/iVlI1IGI3bEHdeuBTX/I8gCBsYGT+8Wwyb
 XEPoq1IKqXIvyLsxx0FkQwcO3pZeaDsGehswbXQ/mjqp9d1/NQ1gU0dJpmaQQKvCOAWZeHxHv+M
 o2rwPrk7jDwbOYEUTz1/cpnD2QPnN+R3YMG5DfS7PzMXCS8MYtiNqNzX9czMwh6CDCJksaII7P1
 em9diYiKJB7Cq7oM105ATnOokzbNLPeFLwhSrK96VeU2LHffeNJJiZ/F/ohT5U79PaZd/mLjEcj
 KflU+uzYPupD7p0fIuz563Pjdb0AxyD7Mq2D1FdRKtwfTPezaJR7b+gfVHafhN57Eqyz9NdMXJ+
 lCps99UmFM3jZi6eyqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEzNiBTYWx0ZWRfX8HdzQvvRX1j8
 QDsf8KS0+0XA8oZ81SFRUu4YHzA1MecvbhHD8028UEQEQABbdwtSUFcz+uAJAEx0ZMlUeDZfkV8
 ft8VhSoB/DpJXBs9anW43z1j7/i1y5c=
X-Authority-Analysis: v=2.4 cv=f/p4wuyM c=1 sm=1 tr=0 ts=6aa14d24 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=XjHw8PULWccToXi1muEA:9
 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090136

On Mon, Sep 07, 2026 at 04:44:29PM +0000, Alexander Koskovich wrote:
> On the PMK8350 the SOFT_RB_SPARE register does not exist, the reset
> reason is instead kept in SDAM and written through the reboot-reason
> nvmem cell.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
> Would like some feedback on this as I'm seeing conflicting results,
> SOFT_RB_SPARE does not exist on HLOS but it looks like the downstream
> qpnp-power-on driver writes to XVDD_RB_SPARE2 for GEN3, which is on PBS.
> 
> Though, targets like waipio don't seem to have access to write to PBS
> from HLOS? Get SPMI errors when I try. Didn't have an issue doing so on
> milos though.

It well might be that the PMIC has the spare register but whether it
gets used or not depends on the platform (and the firmware) rather than
the PMIC.

> 
> Besides, the bindings doesn't allow reboot modes on PMK8350 so maybe
> setting no reason shift is correct regardless so it gets skipped?
> ---
>  drivers/power/reset/qcom-pon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
> index 7e108982a582..9cd55f5536b4 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -90,7 +90,7 @@ static const struct of_device_id qcom_pon_id_table[] = {
>  	{ .compatible = "qcom,pm8941-pon", .data = (void *)NO_REASON_SHIFT },
>  	{ .compatible = "qcom,pms405-pon", .data = (void *)GEN1_REASON_SHIFT },
>  	{ .compatible = "qcom,pm8998-pon", .data = (void *)GEN2_REASON_SHIFT },
> -	{ .compatible = "qcom,pmk8350-pon", .data = (void *)GEN2_REASON_SHIFT },
> +	{ .compatible = "qcom,pmk8350-pon", .data = (void *)NO_REASON_SHIFT },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, qcom_pon_id_table);
> 
> ---
> base-commit: 944a035ecca915ae947905dcfb03f2b9dc6d032c
> change-id: 20260907-pon-pbs-76b7ecaafe33
> 
> Best regards,
> -- 
> Alexander Koskovich <akoskovich@pm.me>
> 
> 

-- 
With best wishes
Dmitry
