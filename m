Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DD348BD2E
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636356; cv=none; b=qz8pldpCHBeJzVheBABYlwo9OttWv+/d1CWUP5g/pJSI/lWeV677rxmYjop/JzZUKNL6gh1VkWQV/TybUpyO2+outOt3fYyLWA+aKqwhKN+g7gnuoa0NL5aHWEyqJD1DJpsVNKand8oxj2gExZSVKVbBzjXVn3oo52TkNBIYypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636356; c=relaxed/simple;
	bh=MJaXpxk8SgycetXdhs/9jAfTSWIIXfPWvoyOBjRier8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWu6FQJ3q+TGAtiyDXeBDEp3huGAHYsRmNSX0Ze/EuhZyVg8fJ9Tws1/iM+/WWz7ig98cmSZRAuGuxI68CBKrMVfg4KnchczV1JrQ2CSEbFP8rwdJFIb4PxnUH6twLZT3K/35RH8xBlp9UdgAOknXYBtuALYFECtlmOBnfCEYbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Huyn2mH8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PqUFJ62A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Huyn2mH8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PqUFJ62A"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFU1hC2374726
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 15:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1H4BUaoFl55Pgyv3qAZFTdQT
	91e144GEzYr6Flshtro=; b=Huyn2mH8ahBanKe/41geqTI5zrugqu4pDnKXHiNA
	xalHnfgcyRguPHYCZaYxUgOyFJ5mZxXZ79DAB1AMBNT7/9Stk5p65gsNcj9MYNQP
	jdYTFK/+3/Dcm0k7Aj0Wc/Q7wkj1Km2IrJ/aGuNl50m/BW5VpZ5FtRiY/vFeUGvS
	K3WlQtPVgiQsUMVwWWcsVbL4yvJeorQT0fMQHkP4xQ24ofsElwiif+D5YVR5Qrxh
	F2mpOboEGx3akFZFFqjpKwc4L3nj2TTChGfpNpGrT7JoJaLE0TS23MSyKksZGZOd
	/ydMJneEYtflKs3f+IK3viNdPBubFPRTu/WvHsucbW0E6g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g14syk8cg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 15:52:29 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ef8249f871so10459036d6.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786636349; x=1787241149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1H4BUaoFl55Pgyv3qAZFTdQT91e144GEzYr6Flshtro=;
        b=PqUFJ62AbZyxPwz+miTMXgZ9qE+FC4KacqBVN6OyGz5oUrPirsM13uNXtVtoot5TI6
         13R/u3cj1q9wM4lppQlHK2MF/wQ1B1ElGlu3wDSZpQhGx8nS0dKs1Z1f/tgDobENtl7V
         Eiz4qK26LbNIIFdOSFWLDV3T4HIz+WT5kqZgQBT0TsNNiY5Gb5vtL8WtVlpZbQp95rrK
         98wQskht3jKA1HtBiUkCRYPKZm1dGfe1rW94LYsODiLSYlXfCQEzg9DO698j1JnIrL76
         PRoDMbWisBmRERhhl1JPw48BRq6GVAyqybRllauBQITJ5wWhfbEP4Rpeujp4V4NNqjcm
         mHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786636349; x=1787241149;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1H4BUaoFl55Pgyv3qAZFTdQT91e144GEzYr6Flshtro=;
        b=YHEj6IDTwo6Dcc/PWwzQqdfcakg6mFBWeDjiisVndBgnBIuki8vB+sKzdkZv/HmvKk
         O9tSrUWJZEk5zn76Lfhw3Rd74OMSw4V1UgJwIDfzFJU84sPHlLSvuelEhF0XQrcahWQH
         FgYpoejScMjMnoSogaaXWLOznrjRYZzRjqeZlcCTHjvuMkuyLpQCpGtSE95cpgGRrTy6
         4a4xiR1MbE4MWuAkarJrnU7ydyTueRWfHWW9nPSzyGxfikUEifsis/s0l261AK0tsDa9
         LJxqr4AhjBHxrZU8prFJxV4WvIEOFKLBUgy3ua58DfNq75ul22UAeXXQDRzUr7R3zNu1
         dPBg==
X-Forwarded-Encrypted: i=1; AHgh+RqBNbYsoY4Y2hsjhKAS1da/RDwlcO5y+xuFBYkvpqtiIqVlUW9x1sOAvuouRKMpDa30cSGKbWe8vQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmN6SH5tSXHFTqbvCqMtBSPfo7UN+W0jocKu+1qmLRqwzW0GdD
	N9ZgpAuqCl1WZdZtRraSH5u9vgY47kkUbhL042X/EXOH9+1UNUQAkNl9RoIhMIhLzZjqiDZBBdI
	YdPM+qpD4UQhY/ae6Ri4C/IXqA7j1IPt1u4fwTAftG+h9SnghpX1U7hgzNbXMbw==
X-Gm-Gg: AR+sD10COLLasATFkz4jDOxM8uzikQj95PpuFfIFDZmThxzoxQzS6ECntbkIWuB/1tF
	lbyH6Zt9h/5MbEWf/1WEKsGWGoHuCi/XICUJKL9cLRRsNUmFAsxqkyle9lvlTi6Dw3mfCUx1IUC
	EVwUEOS/0Ji/ZhvwTW6SDSPyeBn3UbXAOjnd/4YJe7HE+A9qlV9xtYxwUsWKBqGrgMYw7kc1ATv
	Xfix9NyRCE1wmfJBSS0lOSNXlrnTdB6hblFmB2o1caQieFQ1Hkq8UU9tCUnJLYg9fBWvshVsjdW
	5QT7PAaO1NS2vD5TYoE9t+JX8norgI6renYbE2WjQdYx9d8ddWVsguIEbIr3WBbxVHNX12HGFiZ
	Tg8tqyowU5y8ZH6NSOnbH9y+tyV6oJPaAvfAnC1fFf++I4VxIAH/+RJnTTkW2T0qbeoXSHP3481
	5ILIaXwgPcQ63w
X-Received: by 2002:a05:622a:64f:b0:51c:b900:5136 with SMTP id d75a77b69052e-52d73aa07b1mr77451301cf.0.1786636348583;
        Thu, 13 Aug 2026 08:52:28 -0700 (PDT)
X-Received: by 2002:a05:622a:64f:b0:51c:b900:5136 with SMTP id d75a77b69052e-52d73aa07b1mr77450311cf.0.1786636348000;
        Thu, 13 Aug 2026 08:52:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b453a67ec3sm568413e87.75.2026.08.13.08.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:52:26 -0700 (PDT)
Date: Thu, 13 Aug 2026 18:52:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: robin@snyders.xyz
Cc: Casey Connolly <casey.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>
Subject: Re: [PATCH v3 2/2] power: supply: qcom_smbx: add SMB5 support
Message-ID: <hryxv7fl3alrhnekb7bqn5zgexdyv3p6ndug7kp3uqxsiiwmsv@wtvg3za3qspu>
References: <20260813-submit-qcom-smbx-send-v1-v3-0-27be0091d7c7@snyders.xyz>
 <20260813-submit-qcom-smbx-send-v1-v3-2-27be0091d7c7@snyders.xyz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-submit-qcom-smbx-send-v1-v3-2-27be0091d7c7@snyders.xyz>
X-Authority-Analysis: v=2.4 cv=ZcQt8MVA c=1 sm=1 tr=0 ts=6a7de83d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=WFa1dZBpAAAA:8 a=OsHF4jKAAAAA:8 a=OBdvcqqgoCy4BfhIt8YA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22 a=MZguhEFr_PtxzKXayD1K:22
 a=aAwnOj5LE8VeXseigifb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExNCBTYWx0ZWRfXwYiKG15XF5VO
 1DV3nzufdHcH/4w1KQrgGmmi0dRRod9Q+lWY1KHLBnYVuOmXSpQIeUJnHPspp9TzsXYpybCKSMu
 egIhRiYG3hBiN1523m4AGCd2eV1JiR1utF4oWvEudlkP4gFKVia32Y/BdJTchgnJ9NBVU3IdCE9
 40xjtr1ZYYT9qG/5rpnBTLuZHcAzcWz50G8jcnBkLfLX2/QY9BId8yO91QUh/bporr7wAQ0+8My
 rN/3OAzaMc3r0UoMgdi79SILTYiv+gbNQ6yBM1Odg0Uwt8fknuGBDVVXpzDhYGLaGuJgKf1kZ3W
 lvX1wKdyhiMLyZvRltHasjEeizsRVKFdHxTneiIRvqQt/dx/QVJ7xSwJilQBQSM5H3AE343NaOH
 a4zM8Op+awlz+/g+2qyces/4s0Fn/8mEjoEwyZyp0rQsvUeOs/S51wN4zEUNxs5cmDKmqc5vpJP
 +GK1C8X+S6NhihY8eMQ==
X-Proofpoint-ORIG-GUID: X3yramSjCO6Hj8LTeExgqbO3quJh33_H
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExNCBTYWx0ZWRfXzfjzP47DoNMy
 tAO2twfIZ7eccRrs+wPMy2SiuvrvRpcEq4jbHtAjV7a3LlTtlnAeg0RJAIT78v7fg67UdIhylVD
 m2A6kKguZ0fDUifkTems48SVF5xADZQ=
X-Proofpoint-GUID: X3yramSjCO6Hj8LTeExgqbO3quJh33_H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130114

On Thu, Aug 13, 2026 at 12:45:42PM +0200, Robin Snyders via B4 Relay wrote:
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> Introduce support for the SMB5 charger found on PM7250B, PM8150B and
> related Qualcomm PMICs.
> 
> SMB5 uses different DCDC status offsets, charger-state encodings and
> electrical ranges. Select these from per-PMIC match data, with PM7250B
> using the PM8150B compatible fallback and parameter block. Read
> overvoltage from the SMB5 status bit, use the already-prescaled IIO
> voltage reading, and convert the SMB5 current-sense voltage to microamps.
> Use battery-info property presence when selecting voltage and current
> targets.
> 
> Keep Type-C power-role and VBUS control with the dedicated TCPM and
> regulator drivers. Clear the unsupported HVDCP negotiation modes so stale
> firmware settings cannot raise VBUS. Leave the firmware recharge policy
> unchanged and match the downstream default of ADC-based AICL disabled,
> while enabling periodic hardware AICL with its twelve-second SMB5 rerun
> interval. Preserve the existing three-second SMB2 interval.
> 
> Program the battery limits and complete SMB5 input and charging setup
> from the power-supply registration init callback before device_add
> publishes the properties. This makes all public callbacks safe without
> driver-specific probe synchronization.
> 
> Suspend USB input and charging before SMB5 initialization. On a later
> failure, restore the original charging-enable state before the
> input-suspend state; leave the input suspended if charging cannot be
> restored. Cancel status work before unregistering the power supply during
> managed teardown. Update the Kconfig description to cover both charger
> generations.

I remember that in SMB2 case the TCPM and charger drivers were
programming the registers from the same block. Is there no such conflict
on the SMB5 platforms? Have you tested that this doesn't break the USB-C
dongles being connected to the device?

> 
> On a OnePlus 7T Pro, register reads from the initial implementation
> confirmed the programmed 4.40 V, 1.50 A and 500 mA limits. A 180-second
> guarded charging trace and a subsequent 600-second runtime trace
> completed without crossing the voltage guard.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Co-developed-by: Joel Selvaraj <foss@joelselvaraj.com>
> Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
> Co-developed-by: Robin Snyders <robin@snyders.xyz>
> Signed-off-by: Robin Snyders <robin@snyders.xyz>
> ---
>  drivers/power/supply/Kconfig     |   8 +-
>  drivers/power/supply/qcom_smbx.c | 744 ++++++++++++++++++++++++++++++---------
>  2 files changed, 590 insertions(+), 162 deletions(-)
> 

-- 
With best wishes
Dmitry
