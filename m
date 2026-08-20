Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B63A63E4
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787212072; cv=none; b=sKPganp1pir5X7YLMmFM79GoMjZKNTQWtiqsOjBREXiJE/vLAMuIdY1cMMb4HQlrfEMbl1nTKxtLdJL6G4oWYxmipN/YWXpdJgn2pue/uL0FEQdW3iX9Jtb2bpI9plWFe1C0PnxltrpUHviZZY8WDMnjQg+TkVC70ELqOp9rqYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787212072; c=relaxed/simple;
	bh=dyoha8dpk++8RF2C9T4lFV6Pmg1VpR1S32nduflGSsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PC4PPdBSdhT+ZL+78s62x6+0gmsuf43ms7QHcUYL9rbaU8ziinHVNgFZCphu8kSUzPzxNYTsH9vCzyfHKvO8wmI9/3zb2NJ8vZVVJMcuLdks3XqKhQVHtGTuqM7ZHlCDJ5DEfqiFhLKWaMNY3rYIIzlis/XSzVKyNpeehkHRuqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nRW1Xv8j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TzhfC6R1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nRW1Xv8j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TzhfC6R1"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K6em882161518
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 07:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	//kT4S659YrxCLxrC89SElD2a6l456qXua0Jo1L5E2M=; b=nRW1Xv8jqppNtn/z
	0p+mTcDyP103xwzfRZtPJdozyRYtWQr4z8dUfJDVJRxWBuKv3D2uSV+ElmX1FEOG
	39xua+7a+Fz/gIjVaEg7eJooDo+vPQkJnDSv4K4PfK/gjjMdryoRYRDBWkX5QwGb
	Ph84XEVYMn23hdhIzLmKz3qNGkTPSRPJW6p37/UFmwdZQQ29x8x0dL+VSSHAu9Yc
	z3t9v+DZackWu+TONl3NAsFYQ8kfRRA78TvtQWw2OEzw2HJOlrjzRJKROWtjMA+R
	niwNVaBgNgH52l8wF1Wi1cMNhgx5feR3yI7OihPzsDn5V9OQDZnIXWcbSl2vLoHW
	pcZ89Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7r7t3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 07:47:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934979ee9f1so243185185a.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 00:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787212069; x=1787816869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=//kT4S659YrxCLxrC89SElD2a6l456qXua0Jo1L5E2M=;
        b=TzhfC6R1XPtlajIqHLHrSpY8hAlhtG2akUOG75R/JuICv5QBN3Hs3VwGOlCRdufxEL
         MPo9BTQTBMEZWDBMV2VHuLo8MPeigJzz5d55xB/snUS730KlOMz1bFa6z7d+cx2HGNw5
         7iI6LKn87GWuJc7J2qSftzfLUmODTB7sDVTG7OpizBwNgSxrZhtyX3fLmHe6sEB/g9pY
         ynUj1xJloXUNq1BR+GcHThDw48jP/6py6XNDZ9CfZ99jHxdQ4YbdXHuHyc5kQ6sS0CZ+
         cpaDzsIUHf6Ief8PY65nOi3i/F2ZK7URpYsYyh63/sgWC+LJrgWgspv0P2arFeBTznI9
         itQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787212069; x=1787816869;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=//kT4S659YrxCLxrC89SElD2a6l456qXua0Jo1L5E2M=;
        b=mcIay71UGWS8anrGLH7BV2d9ULQpETEUuZyOOJ1miZI2PkYNP3LHRYCH06T/HPLA+F
         5UtmsOcTshGKgTenR61WwSG7L9GYyuWzfiVdT1igqmu3rnqILP18Dzn8YTjclrtkiCQ2
         gWe4fm4FXv+Ae1Bd8hSUn+sVT8z4PrlJUc3Z48HJkzJCKS1W3hlwWlrOuZMkvbEX9QvZ
         kzQdV1w/LFdyX3/qpNe7MhXiiIM0rXloidnEi8fbBGvZdIrXyKJci2lFEvF0hjCdXs7c
         2fJkzb+sfppiKfvYawjDQ2dIBQ5PV1AwcdlDFN56aoTAjTBAO6Phzl8/t/dHbtibt+v4
         Z2Vw==
X-Forwarded-Encrypted: i=1; AHgh+RreT6STdEYVJjRiUpXftKtiPY7JEHSHgj9uxpRRrY/I1B0QNe1Cp9Mbw1IfFMrU2rUg/iVOg8nGNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwL1AEEwP19GsmaYAjV/kR/ClkRgTqcz7A3x81EEp7F13MfMfzc
	ldMNo7kYYP6w7ErodLwZWnL3K4ht2cCazE/mQIiXYr5/u793y8ta3+ouEhf4Nh2tXxOmVh1oEQe
	P96ribVBSOrucDXilIFoQK9EanejytzzCRCPPy1H988X18EuGWU5/5P/rkrYuOw==
X-Gm-Gg: AR+sD10sOkzf1qtvKUZBjITMPYkjuP4NLIL1wJBdB/2vdV0fBUM+SyWIRwF/FW1OFho
	X4HOcdOWfHXdtOiI5DJRS2fQj1tL6DbHO6auIG+DKmzwcV+npPIbkm0FwKgevms5q1v4lvyEEGb
	n3ei6e9RX39Bup5Wnis73tOGFYloToOC2hywVwlh1ROiaEkEbzgwzjZUDTnd5seNsc6ci28ui/Q
	oJ98UOCHbVlGxfSyaBt3DzsaxxHlg78LcNmdLYyuRD5f3Fz+WFS8Lg1BYCTIWSwzYRG+5Cava5O
	ZEw9tSe7ZHYn2nuE5roX4mYIZfFHDvPRSJLzyo2ELhQrwyVnwcKtnq2itT8rAJ2mUx+avScWUDq
	Mv9vYx/eJ28jaJEzDlWcEDs8G8T+9
X-Received: by 2002:a05:620a:4415:b0:915:5cbd:1d96 with SMTP id af79cd13be357-9371e6ee08bmr938307285a.33.1787212069384;
        Thu, 20 Aug 2026 00:47:49 -0700 (PDT)
X-Received: by 2002:a05:620a:4415:b0:915:5cbd:1d96 with SMTP id af79cd13be357-9371e6ee08bmr938304285a.33.1787212068889;
        Thu, 20 Aug 2026 00:47:48 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b212fc11sm20514795e9.1.2026.08.20.00.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 00:47:48 -0700 (PDT)
Message-ID: <edb61715-a676-402e-a269-613bede12639@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 09:47:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/9] Add support for Qualcomm remoteproc subsystem
 cooling
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Casey Connolly
 <casey.connolly@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
 <9eb142ae-9f79-4f7f-91ae-6a49a7103dfd@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9eb142ae-9f79-4f7f-91ae-6a49a7103dfd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA1NSBTYWx0ZWRfX3qw+zVXvQaQ9
 J4hzDkmaHXDtcwKZggOlUMzmNlbVvfRCQwO5kDzJQP9bexA/deR86CIEy4+VMlHkm4UmSgCl/Bs
 CNQJZXFEWEkDQ2foxiip/jAVi5wps9RJXTKnvQatbt0zrijAgtgBfQWYqMHlBrw5hkkMFZNRscp
 DjxKs+zqYpCp8AhYy5UyGV30S9k4D2QF1nByPF8sYe7IkoFPQ7kP+K57dK30oFef52yBthVBENv
 b+uDwA5oYibzipFZuL4SyAhCAMUJzOjFUPz8tE/FsYdnE52i5xSmH9yPubJ3AVQBo3g7ARLMbK4
 nhAdO5AWyoaLpHUonkxrLjIWUnA9Ek96+HSacf0mEPs+2tp4FxKIhlQJTLdq62Ub1pH9oKN9m9G
 49dH94pimvkYYElvHN3FBOczBOcZuLAjf/ElCKnO2mXCE/ZBYfstHPz61+I7Vjy/v+FKHR34KZ/
 FQ0PduqZqOaztTH9EQA==
X-Proofpoint-ORIG-GUID: zgk4FkJFGGufTVDO6hgkdaRMMx_V7jZS
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a86b126 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=dTLPQwhzsRM4EjPZVQoA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA1NSBTYWx0ZWRfX79AmGQ7XQpx9
 7NWSnB0/7UNnf5WLksnN4OCgBWA9hcbzJWmDfOXOadKKUvgCMvSwFl/2OqtdeHuimh7R5zeihd3
 Czebp/5GA/KgmNT9/LvVpahSK1DP82Y=
X-Proofpoint-GUID: zgk4FkJFGGufTVDO6hgkdaRMMx_V7jZS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200055

On 20/08/2026 08:32, Gaurav Kohli wrote:
> Hi Bjorn, Mathieu,
> 
> Just wanted to kindly check if this series can be picked up.
> 
> Patch 1 has Krzysztof's Reviewed-by and Daniel's Acked-by, and the later
> patches carry the review tags received in previous versions.
> 
> Please let me know if you would prefer any changes or a resend.

What not to do during the merge window? Ping.


Best regards,
Krzysztof
