Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF7130C359
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 06:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948270; cv=none; b=eluTTwZsOuBRzQXsDWqV/oRnsBWrabvnY+rHlA2kAcPA89j8K6BvgSl47/Sx2I8jkC85lMTsU0iMkudCMWPxWCk/hulfMwXniq4PZeXDsq7nAptxs4NxFSvnNSxxPLRxtH/ZkluDfBAW9TnzkLye9iwLDB1IwazN3NfrsBg5TsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948270; c=relaxed/simple;
	bh=qyL34sxEoMuBXeSfDHG+RvyR+Jjoy5L8ACobH5tEfaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOnZ6PZgj/xjYL7CnqE7qMfB/Iu+re/AuYD2jRwAg/SteM/SVP1h+5as+hdePFG6n3WP3VS07FRLWrQ4nFlho1Pu0NcNUwrE7aMcBDEmbxIXohIiUVoXHO/PVMWqnkj5aTpI0hjibbcIcSBd2rGJFHafz1Cw90V5ejVmBtUiGRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bCuXretJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P/2BR/OB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bCuXretJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P/2BR/OB"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKlXUp2463985
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 06:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Q38iL/Kl5bsfH6U6c4BfPkvl
	nIA5GnSzXnuKo9Th4mA=; b=bCuXretJEbIsNR9VHFuRbflh+3V4Enl1z8jdX4ZN
	GpvInthwhIbtfc/0200eCrRGdEd/1DxP01G6a45JHL7yvwYMuubfC23JVGMrFryS
	2yzh8YsVFOBrClJHZEWWjXvT+LXT/gyKtK9qh0nftoElDC9a5PnsRRcXCH/Yo4m9
	KlKxfgs8JtMB6VIawLrYUaA6IVQr8udAIyPJwZaizauSFx/Edv7pwa35u0bR1uUb
	zNiLChVbPQhOHw6gdoBXn31i54cwWnbG+Br1u/6nQEbep5MLp27mDixyTj2bKJaq
	sOAGg7UvjZO46d9guC0EctuASXGido321IdQSlVTaZOYzg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y4sh0s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 06:04:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-516d09e77e6so138293601cf.3
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 23:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779948267; x=1780553067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q38iL/Kl5bsfH6U6c4BfPkvlnIA5GnSzXnuKo9Th4mA=;
        b=P/2BR/OBPdP9nRV2lFI8ChYt1welVm3zyp68WD4un7P/dPd1qCm0aRIG+uOD7QvwiI
         TIuTmLo3ftOTzRFN0cAcGwrXzMpX8xhf+Bg1tLdu7GvRnFFlN2j3UHpodX7Yt16Hgdg+
         IpH3LodXRMmbPdl5Eb5pT7JPqxRSikGbvAqpmLSKN/LAPLV9E3VS0nyZoMU90KWqlRpV
         GlvSHV3IkvyrSzGH7mio3FpEeXctOpbbBgRZsPpUUY4/3scVa9VdvBV1YHz1oMPhJoW5
         F5l1BqyG2bWlcu4/xrSrK6C91+hdm59sZ1wGTIAtPH7X/ZG0YxLR+fnMrYXl/qx8M3tR
         36GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779948267; x=1780553067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q38iL/Kl5bsfH6U6c4BfPkvlnIA5GnSzXnuKo9Th4mA=;
        b=h83pCV5PehRsZWnvyFHQPAkMPLT8x8/jjPdJLUqFUCi868oTs7FaZPxiBEu+EqL48I
         HWYwF4DmVdCDv/zEoXZllk+d+n7lKnsmfutC0HFy2FuHLTP7Tf3fjD5PaA1CKxPxd2mu
         1cMUfxpgFV+C5sNQZWZc8Q6hnG68p6lqvyxNRiWr/APnCKJ/rt9W1x6HFOuihcUEDGg/
         L73sX83SERXBzwtiGcwjLzZITY2TyWDzD1iMDN3m0uWulFpaXlaZ7YWNku//6H8ZISWG
         Hza9f+P4u/giCs3d5s312Q7amLND4FCcRbxv4GWpPnvawDdx61/qb3gpBOB57YLyqkc+
         km3A==
X-Forwarded-Encrypted: i=1; AFNElJ/1g/jOpB0Z6jC4PbdDnVjT9umUWQppkwpTFqylNxTxGRcd4xissJOOondtEVPbEm+TIrARGV+www==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJHut6NOccQGD191/ac5T8UMRntCLSOSVh6g1ZmJk/TvPy/xqu
	GBA1pWTLos9AUQZ/O3UXEkTcyMeSGYaoOkAJ/TBYs1p85IQhs7r0qb7C7XLSAJ5JA2vk7AGmjjR
	7/hlxT7o9qEg1xFAQkoJYyKKn1EkpwNtM1WlmbFYG2w6wFruf+GdqcFkySSxcCQ==
X-Gm-Gg: Acq92OG65l79+gAiHzjmOeXYCH01SASYfojWIR+w1b9EslxWV4sIv+aBG6RNaVCESSK
	nzR17iDm6xkogCZRbdMiXXaFIy9yXdbn7pnt/3wT3oH+8A+mvIctb8qMt3Si2pSJ99C2xnHOQsb
	yFyRsXqNQgKpuw02uOrbg7eDpXzVvPWurJsL0+GPk8DxDmh9TJEtNZSDKr8oIQTgikauY3zABv7
	/JUmUg6hny/BrjrV720aVL3MH0cXDp6S6J/KAFehH+05c1akuzpmI6WIZhDH3Wup/BuxN2I3p0E
	3gZEV5at4bQmNMcW+FXNX8OXyxJUCn2+TDe0HtLXxK1q2S5+ddHlkuBi2DmTymfMeI2rqABYC/F
	O0Qszy4vAVGAIMuK0mtzPlBP8bfhpjVXcMpz4xAsWI6y07P10bsqWbnCd3JAqi8FbSu7+tfrOxq
	ucX+Sw5wKIOO0XGIcPf9z8SO7iq+Y0YIrPryO8apG0LhCP/w==
X-Received: by 2002:a05:622a:494:b0:516:eaf9:f6f1 with SMTP id d75a77b69052e-516eaf9fb0cmr258205761cf.13.1779948267077;
        Wed, 27 May 2026 23:04:27 -0700 (PDT)
X-Received: by 2002:a05:622a:494:b0:516:eaf9:f6f1 with SMTP id d75a77b69052e-516eaf9fb0cmr258205281cf.13.1779948266455;
        Wed, 27 May 2026 23:04:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa4632282dsm1710822e87.41.2026.05.27.23.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 23:04:25 -0700 (PDT)
Date: Thu, 28 May 2026 09:04:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: guptarud@gmail.com
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] soc: qcom: spm: Add MSM8960 SAW2 CPU support
Message-ID: <iqydzm64gmzqei6sya6p7ntonrswpjcphubfnqyvabaaaiufif@ts7iuvol6o43>
References: <20260527-expressatt_cpufreq-v2-0-b9b7726ccb6d@gmail.com>
 <20260527-expressatt_cpufreq-v2-2-b9b7726ccb6d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-expressatt_cpufreq-v2-2-b9b7726ccb6d@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA1NyBTYWx0ZWRfXxv+eJXa44Z5C
 /jgFKTtT4wbamZB4CMi1bxRj1kBP689xGekAY3l77dfO0L6CPBdhkYAxXNREk5seDL4S1K2++VT
 LRIsDM3ypwmWEBb96X0ANV+uc2mNaZj3n2H204ey8igSF7PvdzVuWKa9KmsqiizzTf/1BtJNml4
 NJJEzHAgg0vXw1QG8pJYfqv7Z8bcIJsVcHkgHveSgBtrUjyarJoiYEAlM5Z4j2PsdUdxccnPMAm
 w4sFLeVsrs5M5eNavI2IeL1DLeafy9FfxcuKWt4+OX6JQ44o9YZ+LodcWac/C/MlUGDB4Ea/uCi
 aDblR2DFmbUiqducFSb3FC/R8ZqjM7aFBxELXBBEHXVxUNkuFvwi/8DBf3d8ON3G+tSPorQvZ9z
 SOj2Yxt4X6Qdhr1mBG3yR/gH4Z5F/YJICwss7UnkiNv4XJDGkAOQy7oxxZ6Z9S3usofDs1JSgDt
 Wd1sZ78FkKzcWXB0UVA==
X-Authority-Analysis: v=2.4 cv=feidDUQF c=1 sm=1 tr=0 ts=6a17daeb cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=oA5LrNwOAAAA:20
 a=pGLkceISAAAA:8 a=uAGLYOZ0FLdk90Ey5qUA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: xv_iPFe-3ykmGn09lUlbvw4eFY7MOagt
X-Proofpoint-ORIG-GUID: xv_iPFe-3ykmGn09lUlbvw4eFY7MOagt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280057

On Wed, May 27, 2026 at 08:39:29PM -0700, Rudraksha Gupta via B4 Relay wrote:
> From: Rudraksha Gupta <guptarud@gmail.com>
> 
> The MSM8960 uses SAW2 v1.1, the same hardware version as the APQ8064.
> Add SPM register data so that the SAW2 driver can program the correct
> SPM sequences and PMIC parameters for MSM8960 CPUs.
> 
> Link: https://github.com/CyanogenMod/android_kernel_samsung_d2/blob/0dbe2b56847b304d30b809dfd08ba3b4a61d9af8/arch/arm/mach-msm/board-express.c#L3265-L3285
> Link: https://github.com/CyanogenMod/android_kernel_samsung_d2/blob/0dbe2b56847b304d30b809dfd08ba3b4a61d9af8/arch/arm/mach-msm/board-express.c#L3353-L3381
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
>  drivers/soc/qcom/spm.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
> index f75659fff287..fb3ec8aa42b0 100644
> --- a/drivers/soc/qcom/spm.c
> +++ b/drivers/soc/qcom/spm.c
> @@ -233,7 +233,7 @@ static const u16 spm_reg_offset_v1_1[SPM_REG_NR] = {
>  
>  static void smp_set_vdd_v1_1(void *data);
>  
> -/* SPM register data for 8064 */
> +/* SPM register data for 8064, 8960 */
>  static struct linear_range spm_v1_1_regulator_range =
>  	REGULATOR_LINEAR_RANGE(700000, 0, 56, 12500);
>  
> @@ -253,6 +253,22 @@ static const struct spm_reg_data spm_reg_8064_cpu = {
>  	.ramp_delay = 1250,
>  };
>  
> +static const struct spm_reg_data spm_reg_8960_cpu = {
> +	.reg_offset = spm_reg_offset_v1_1,
> +	.spm_cfg = 0x1f,
> +	.pmic_dly = 0x03020004,

Except for this value, the programming is the same as the existing
APQ8064. But, APQ8064 seems to have an error there, it also should be
using this pmic_dly.

But#2, both APQ8064 and MSM8960 should only be using this table for the
SAW2 of the first CPU core. The rest should be using a slightly
different config (at least according to msm-3.4 tree I'm looking at).
Would you please fix that?

Please make existing APQ8064 entry use pmic_dly of 0x03020004, use it
for 8960 too. Then add new compat (something like
qcom,apq8064-saw2-v1.1-secondary) and use it for the CPU 1-3 on APQ8064
and similarly qcom,msm8960-saw2-secondary for CPU1 on MSM8960. Feel free
to propose a better name.

> +	.pmic_data[0] = 0x0084009c,
> +	.pmic_data[1] = 0x00a4001c,
> +	.seq = { 0x03, 0x0f, 0x00, 0x24, 0x54, 0x10, 0x09, 0x03, 0x01,
> +		0x10, 0x54, 0x30, 0x0c, 0x24, 0x30, 0x0f },
> +	.start_index[PM_SLEEP_MODE_STBY] = 0,
> +	.start_index[PM_SLEEP_MODE_SPC] = 2,
> +	.set_vdd = smp_set_vdd_v1_1,
> +	.range = &spm_v1_1_regulator_range,
> +	.init_uV = 1300000,
> +	.ramp_delay = 1250,
> +};
> +
>  static inline void spm_register_write(struct spm_driver_data *drv,
>  					enum spm_reg reg, u32 val)
>  {
> @@ -501,6 +517,8 @@ static const struct of_device_id spm_match_table[] = {
>  	  .data = &spm_reg_8974_8084_cpu },
>  	{ .compatible = "qcom,apq8064-saw2-v1.1-cpu",
>  	  .data = &spm_reg_8064_cpu },
> +	{ .compatible = "qcom,msm8960-saw2-cpu",
> +	  .data = &spm_reg_8960_cpu },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, spm_match_table);
> 
> -- 
> 2.54.0
> 
> 

-- 
With best wishes
Dmitry
