Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379744;
	b=nApfTq1p5C5isK6BiE+JW62Hh1+F4VWiW/LtOK17xt0+bpNtX5nPEcNl6etxsl4U0RW1
	 xXLbglzj5wqCYdeV1BxjNT731rYkhrKEx4XV/OVF0qeQktmeMmyxsTEtEOon4DKearCOE
	 Oss5LSRXpSytI176h1ouQciZRHWpgdjAhtyi58Xjl+pwC5WkHJ7bXybyYnp14GCubCi9t
	 rfwKzgYpXVGC+dVgYntm1kjsZFUW3ENlCqACGkrm/j9ejc0I5XbkGRbIqj8KPXaE1KS1m
	 5zZneKFXszyVHLoOXTCKCbGdIzL17btGcUBAsUDobPdmWH6hw2RkoJhtczHIDi9y+1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379744;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5q7wfSofD9RQzhPnq6gQFCJxBwQ49cEbkPtzHGzIa94=;
	b=OML2BEnVVbPNg+wlmSTalv706M9ewAL1T51LS+M2SUZ1lEqHP0rU2XCs4V1KOcbCWf2e
	 Zk165B8Wk5hB2yrhRx94aai6BSEd+vqPOnYrwzQRRco4g8B1hFKQRK6SBOoh5pIOMd2rK
	 jlOMEHaMFJNwrxj3GOZYY04SlmabiNO+BygoPrJUAhy270yV6LHhPw6KpuPcfcWGp9Myn
	 0r+bVojJiJudNtMN+m4XWGnjWDei3W7L9zAqyp0xGHmy9f/RSVyPX1OeNZhr4dezPXHH3
	 U4CPEn2k5o7VMebC3QAeMCNaww1kjh5PgJNcmv1JxPRgX1RWIlQRKaNdrXWqQg1agDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WKUHzWUU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DG1y+no6;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BED5606A994
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 06:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BED5606A994
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WKUHzWUU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DG1y+no6
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KNDm3958987
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 06:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5q7wfSofD9RQzhPnq6gQFCJxBwQ49cEbkPtzHGzIa94=; b=WKUHzWUUPq1twCKU
	Nzw0sX+dEOZWm4zAa6fRd1MQzM0DL9jaQRfXufLVJtpoZxhdsP3SBUXYecaMS8bT
	+YtfgFuslVmtR3/mG8AdNhXuFE1fAtB+R0SXOsDIYtrLdoBfyjoTN1hlAq7yZPcq
	o6zaFpQz3Zz3unyUzD//IKMRE3rwUmrPd/OsHDYpsY9igfvWL9ExfEdelSsNcJMp
	SNCJ7IT/c68bQCvsMxVgKtn+mbDq+d1TmaQl5Yb+Y6aM21L64i8j9OSuXdZUqjQP
	6QdkB8NYF+4frN64Wjqp2K8r4/uvlQapDn62zgzdiFqlpTBzo/kyL2f3toMpYMcJ
	DMckkQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b3291j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 06:49:03 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b0f667a666so3987362a91.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 22:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794379742; x=1794984542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5q7wfSofD9RQzhPnq6gQFCJxBwQ49cEbkPtzHGzIa94=;
        b=DG1y+no62F0nFr/IxwqGnRQjxO6xk4Z98cNeUhWaxgCdIOJ+GFXViy9iUnIGhDKHt3
         3xrEVOxLbEp7Nu6djhDHNZTuR3YARPPQ4ZrJXhcg1dmPinDVWwHWHxO4PXIpQd/k8PIb
         +kOahSk07jVbqEOY5anLQ/gP7tUYsWJg1zfPMeuNEDmnmA0GibwFsbsbWugsboopVmdw
         nfzT7V4lTsXzCYhTM3XQX83tJcpvfURs58KiknUfT9VwxNFOHpVMIoP2eWbikys2SA5f
         V0ek7qSxnYoQ5z+f+h0DzKtZvW1tNsUIP+xAFcKkOsWHboSMRsuEicaznCd/TZSp/as4
         +taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794379742; x=1794984542;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5q7wfSofD9RQzhPnq6gQFCJxBwQ49cEbkPtzHGzIa94=;
        b=IcC3fHEy6vTRz3SHOjpaAXEvRtr4cvPbqDVE+dmGHDg1VeEMoZu6CI/dTHtrbuPcHR
         4QQ5Xtk8FXaABcYAH57/34uiH4HkU8tOXA/NEv71BRVTHnlUVj8jDHWFNcD0uj7icuIf
         ha/KHBmCz0IaKzGr2XAtVxvwOYA/tEbDo3NAGdjjjyAbrobT1eW1GJa11Qu/mkphSPOV
         Yay4L6om7VCK1ZNbCxaTcAu6Mq5iGUuQU3Xwc150snFI3WZI4VX2w8iXku51KHA2QTrv
         17PT/eM7+2XVjKO6SWz3PsJVUdeSKSaVbk+ySUmvx7noynB1Z2U+aKe3Ab9w57PTOC28
         vdeA==
X-Gm-Message-State: APuU4Z9DADh03J+Ynv9rqgNfwS/gvR4X9Ma8s9G97JHMoP+dmSGXCc8y
	IArir3LLO1d2ymRt8KeKP+Qq/BDTUwJ/yAWHk8AFJZ+cXVPwOy3R3rcQY278ciu7z5rHDMH6IC1
	ssguDF4P8wQS7wgasLol2PbHul1KovZ7OV+Y7KIG2LuDixDX1dAAKI5G3R5TTQQ==
X-Gm-Gg: AYBFou2Oev6mVntHJnhXSTyEToo2IdthgS+i+af7Qkm2WBWKAAo7Pxj+yN/vukwntJM
	BUtCFBlaGVXFwgczqOHxHv3LcDAQ3UfwKF0sU8FVD7/Kp5UOXklgxg9CqH7sFp8RQLsXO5Dbqpu
	8x/14u9zqFBQya9JS/glWHOYKIq5gXYZjI7Mv0Iorv8EtPXXi96gErBIYYlCpHkPzyidC2oT5Xf
	UHcoNDRbeVBTdTtfVGTrRrsmDhdpFGxhemFWHUs7w4RqQAtwQGQ16slxgRQI7E65Ymc7dJk1fx1
	vEcbERW9a1oHmaK/Z0nYKPOdm4fIPZ0Qa/ZW+j8ujWVo6E6QkOHFuXo/v/AELfOWm3iuILEXq/m
	aMNmYIbd2bSmkRa3+tqEEvhVfY38cAEZEL7UVGNYsrBkZdO3HlxurAeIRpK/eGx1P6Sagl/cKPJ
	QO3wgHk0tmBR6FAG15wC2eOaFp2tBj4C9t
X-Received: by 2002:a17:90b:2748:b0:3a7:ab31:2f4f with SMTP id 98e67ed59e1d1-3b182ebe960mr1586269a91.28.1794379742568;
        Tue, 10 Nov 2026 22:49:02 -0800 (PST)
X-Received: by 2002:a17:90b:2748:b0:3a7:ab31:2f4f with SMTP id 98e67ed59e1d1-3b182ebe960mr1586259a91.28.1794379742118;
        Tue, 10 Nov 2026 22:49:02 -0800 (PST)
Received: from [10.133.33.220] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b182e24c68sm1031771a91.3.2026.11.10.22.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 22:49:01 -0800 (PST)
Message-ID: <07e6065f-d31a-47ce-87a8-dee76d545c18@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 14:48:57 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Add Halliday to cpufreq-dt-platdev blocklist
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261109-halliday-cpufreq-v1-1-d87a397396fd@gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261109-halliday-cpufreq-v1-1-d87a397396fd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af40fdf cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=7UXeoYgq6D7Qrk7lHUAA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyNiBTYWx0ZWRfX9jpXGBcncKX4
 /SE4WAfnfmlqZjeRJuA4ZpeTkjBNmRN/NQOxCvRg1m1Qj8S3irP0bXQhbS+5pUXAp2WkBrq2L7C
 CEhoNdr7ATs97wvweBffy+VYWxnjf09r55D4Ng2ZsSo5HyA3m++liMgzQge9NuoRIBpvdWP6KYv
 lGqSkoxhvMrTnvxDXDplt+eUQScRwAFKHdY+g8Au+6uTKSOzLbtoHX1nBrkxYYtEdIelTfHAJKl
 vo2aYvMM6sBhGDkl//SMj4lewGkX8n/+9mfPwaV2R97AAUeg7fBFBFsfOa+K75ihL1dPtE4BDPF
 V78JIphxOuK+Qjtub+vsDMlDnKgHJRuN73CwVAovG9bXufjukMlvyyqKI0rEFa9Ee8aG984dryG
 ZHzgNh30sHgIPsoPI52DDoMPiaMJBcy57EZS0Dfd3aQSj8AA/5Al8GYXh2K7IS7XtfiyU5A586c
 H1XB/DtwwMgRBUi2t8g==
X-Proofpoint-GUID: aAfpQDOvcx7Z6HXKM139L6HCIc6IJC7J
X-Proofpoint-ORIG-GUID: aAfpQDOvcx7Z6HXKM139L6HCIc6IJC7J
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyNiBTYWx0ZWRfX7LbOBZIjY/jv
 SxOM9PgkUekDcILl0wSWPA4FHQUNZI44x1GbbmK8Ct+ycT9MrJ8ZK6yloYanH38IESNcxxY8Xet
 FmohuXFlF5aeKcRLsdEfOsjjU88XiQI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110026

On 11/9/2026 8:30 AM, Stanislav Aleksandrov wrote:
> The Qualcomm Halliday platform uses the qcom-cpufreq-hw driver, so add
> it to the cpufreq-dt-platdev driver's blocklist.

Nit: It is better to use the "cpufreq: dt-platdev:" prefix in the
subject.

Link to the DT series: 
https://lore.kernel.org/all/20261109-halliday-dts-v1-0-289114ab8197@gmail.com/#t

The code looks good to me:

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> 
> Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
> ---
> This is part of the bring-up of the Qualcomm Halliday SoC (SXR2250P)
> in the Samsung Galaxy XR. The DT changes follow in a separate series.
> 
> This work was made together with Claude, ChatGPT and Gemini.
> Reviewed and tested on my Galaxy XR, where cpufreq runs through
> qcom-cpufreq-hw.
> ---
>   drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index bce4c87573a1..3d5709eaa08f 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -155,6 +155,7 @@ static const struct of_device_id blocklist[] __initconst = {
>   	{ .compatible = "nvidia,tegra234", },
>   
>   	{ .compatible = "qcom,apq8096", },
> +	{ .compatible = "qcom,halliday", },
>   	{ .compatible = "qcom,milos", },
>   	{ .compatible = "qcom,msm8909", },
>   	{ .compatible = "qcom,msm8996", },
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261108-halliday-cpufreq-1e9c3581e2b4
> 
> Best regards,
> --
> Stanislav Aleksandrov <lightofmysoul@gmail.com>
> 
> 


-- 
Thx and BRs,
Zhongqiu Han
