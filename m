Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58ED33064D
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262175; cv=none; b=lwI6SRJSK+xHtZhmT/spdfWw2LKfuZLmRuSh8R7VQTk2sLMkqhBm1oX/MESHQlW61dcKVAaZfbz7nG+tb6y+2P9ENJS13mnGSi/tbSjyiRdioXaVc0dkmQmUpYjO9a18+rKZDE9jM3wt0obwkL7+HjLyODOSIvpc6gLQPIE0qzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262175; c=relaxed/simple;
	bh=aPdS/oN5R7bXAi3R7oK9DzbqpnEJEHavy9UFo6/M0Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q82uwHe0eebVvwWASbgrkkKm670LkaVK5F1oqePLfDWULVhi8M7n4Um4Pd6HRQ7kabVaLiw0glRovfsr1R3VCtGAW5OPEOYyaN7ON9QHvEKkairJuwPft8MWhcriKdJZGUb31Jrc/qKShlxmjznVVlI3YXn2VhuvOIe/I6iToZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JOESnbjk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KwT9kiHc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JOESnbjk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KwT9kiHc"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N6Fqjk1679524
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6cu5CX5RqM8GBq6AyqwTPyZJr8Rph3R9Mh7YCaq+vOA=; b=JOESnbjk7oJnzSRO
	8YWHiZxk0JNLlHkgOwWbuo/CiMQD9TAb8pRuwfIFWbZYrDEqUDHTzk4cTxSfz7tD
	SVqeHCI0hiOihYY7/V4pfl5BhRQKFTi9si0VM5VWXIhlVNnpQiC2LOZfJRfYzzpG
	k/VRBuYtEkzwKZpV9cdf1LXTkM6b5hdFegOU+vVyrNYKOhwU9+v67/qEADSABFiv
	RVkqmHRzqG+mGyxOGc/wqn43g72JcFzapj2y8VDwHMhQZRZ+zPQ7B2DVJ76NYIGM
	1kntJihJu42wFfY4SCtM0Yjrmt3Tlz1hn3NXlr5BEeqxOThIttFdFPlQrMPL0hI5
	2HALTA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jb5n285-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:36:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b317c4041so27055811cf.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 03:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774262172; x=1774866972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6cu5CX5RqM8GBq6AyqwTPyZJr8Rph3R9Mh7YCaq+vOA=;
        b=KwT9kiHc0hEOY0GQ4Bhe6JSMD7L4pWixv5UYC66BuyemTWXeLX8OLlI1tZ4i7NdOh0
         YXug9ueFLamC3jqfHuJ43YXQfX8TEyeoevAzpbqWlibXQrNKL1e0cya+HhLUQLNW5ir7
         DhMCPPNsh3kxaGSt4wOpMScWsqKGDms7BnZCLZbVyft2CvpS653MvllSTCxhGQHwl6kP
         fGm5rHfZtoI0jbiG1ITW6xA4OsZDMKPl8QY07bKeFSKczFVKG9G8MWyi1ey8myr96iXZ
         MDkfs1I4gAdS9wNGLU0qq7EQP0gU4pb/lzjii6vLcX4G8wiUzXciIOPocGn+3CUT0rnr
         ZxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774262172; x=1774866972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6cu5CX5RqM8GBq6AyqwTPyZJr8Rph3R9Mh7YCaq+vOA=;
        b=TNqGPljFPk7hEBoaO/d71qn4ZOljReHqU58Fbuj9dm6yfICADZ72wYGuUtFKvduXdH
         srZ+YWZrXc5oE4r2Fwbocyt+lOcV5aOxoLEmmcVR3D41OZWFU3eyTpO4CwpXRMEJlpiM
         9v/4DS76wI1pyQ/ESIixAck1ZoLAv7JSuTA7ngYa2+f11KE4Lg9WsxUTQDExQ+T4iOrg
         qU3t4zAhTXDag/6CEhLvih2pqYxpaurun+FM4/yJBGRS+eblDZ+kbSt9M4RY/EF0Huxb
         CtcaND97n2YEbzfEwr35uPF95eqXtW42L60uIbvmDRcUVDtcFvMZRYs6GSfAHH6BXy0K
         jJUA==
X-Forwarded-Encrypted: i=1; AJvYcCVjH7T3IDrIMmuPxIE0+pqqDZQudghocPNvs6N9sT+iCgJVmWHDazux6U98MenC6r/shrd3jbZk7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIGCxUbIhHpvReye+4crEj3A7yptaT8/UeazCV5g5LxeJBupQN
	34cLHiy/OsNAGkoHve5eZAQescocKTubPt6xLnslcLIuqLkfyliHeXQ7v35nWEIORyYsfRBEkE4
	mnb6AZFE5XmpqPgutAxKXC/5pxkDen0Y/vTr1zZnAYHRz76qxoRHcJ0Rk/bib3w==
X-Gm-Gg: ATEYQzz90WxbaL8Ctj6ZknXig/jU+w4e9gQ8EUwITSS8SRYRz3A4HC3TZqT2vMJ6tgJ
	ObiFMEEP1vqk/RKvnC9xucsT+/ymqXAP/8552NOqFuGDpeZwy7wRe9dw4Y9j09tI3o5a6Fox1Ay
	0BHv7v1/2wb3H0goVZFwOjS+ZvpbdAg4fF7Q+Wagi1TsCuw8KUWnyTVskngdqeXP3tQd8ydSpMA
	9pirYvaiWS49A/PJIj7g0Vzm++/JVWYVVcHPRKaxg7zqBaKLa5iFn8Zgy3nWmjQdW59kQCfVsjZ
	GpTZgjIPQh59/a76Z5oHvkgybjJY/B/DX0CSQLSIUt1nkg/vAi2/WJxxj479Nw6kKz0wd4FLt1c
	U89EhyJH0Pic9yhPNEuoY00q10Rvsgrr5bKW7M+GSmsY8yYvb0PqVThdlD6Uwf1fABTcqVjcah7
	kxGSU=
X-Received: by 2002:a05:622a:1992:b0:509:d76:fe73 with SMTP id d75a77b69052e-50b373d748amr141113361cf.3.1774262172376;
        Mon, 23 Mar 2026 03:36:12 -0700 (PDT)
X-Received: by 2002:a05:622a:1992:b0:509:d76:fe73 with SMTP id d75a77b69052e-50b373d748amr141113061cf.3.1774262171972;
        Mon, 23 Mar 2026 03:36:11 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-668d238c8basm3555652a12.22.2026.03.23.03.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 03:36:11 -0700 (PDT)
Message-ID: <5889e10f-87eb-4943-95ca-d75daa16b3f5@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 11:36:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] interconnect: qcom: msm8974: switch to the main
 icc-rpm driver
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss
 <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
 <20260323-msm8974-icc-v1-7-7892b8d5f2ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260323-msm8974-icc-v1-7-7892b8d5f2ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aJv9aL9m c=1 sm=1 tr=0 ts=69c1179c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=vYfEZkc75eIydLf1ogMA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 2_wctvFQRQb-1fueov2EhxCmK-jyDaTZ
X-Proofpoint-ORIG-GUID: 2_wctvFQRQb-1fueov2EhxCmK-jyDaTZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MiBTYWx0ZWRfXw10thCk86pzb
 IFw8vMRD5K2q1aKCoABUGugkgFsPNENBVut6MifJonDy0Z8tLZQi+xqRJDhRuUhDiDEF7ZE0IO/
 F8THtdvcQDOBNoUAnbN/pNQCCe9ufH5u4ix3nAI+CJzcLk1vnbnn0ken1y7V/+Z64B420zVxlCE
 vphAWXhxgtowjr72crTjITUZm2ElTwlMRDravuiKRkAc15+p7Hhdutr6ilpFtEnmknZ4HOUYNPe
 eU6fHDmCzws5R/f6WPxaBmJBqv0f5jmgJZjf7pvf0VmHCUNOmnFaaGFLI4zPBHQFRCPXWPiSjAP
 KgIV/owqLHHUMp2zg/T6skTlfm0zkeiYXgcysylrLlGeahnHOwbhx3LZYmlrwdP5an5qH2UveU/
 buc/ngTWqFJdm8RRxUMgbtdaENEVOaOex/jPfmkQYZyZuB83FSUVd2t7fBe2a3Z6D3pfDbxDBh7
 XRAFnYO87x7vbvItwtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230082

On 3/23/26 2:17 AM, Dmitry Baryshkov wrote:
> In preparation to restoring the ability of MSM8974 driver to work with
> the modern kernels, switch the driver to the main icc-rpm set of helper
> code.
> 
> As platform-specific workarounds, set the get_bw callback (returning 0)
> to prevent initial setup from programming INT_MAX into the RPM (which
> otherwise might hang the platform) and tell RPM programming code to
> ignore -ENXIO errors from the firmware (until the QoS programming is
> sorted out).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
