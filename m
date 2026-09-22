Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A32395273
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 03:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048916; cv=none; b=tqVgRy3J1c2KDwJiNBqM5aiYgt9afvwhQr2ARjuw5QMwMR27nyttg8UqUth5lV4Fj/3h124p34otWE9XOrq+vF40F6T1aCVc5vdUOf1akenw1B9+uGrZ5pqm/oUT2HEmtjnevwCHSXnqgmJ8ViYjpz5pOFbPRoyONv+taL3sKfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048916; c=relaxed/simple;
	bh=4hoygNQoHLisXaQr1qmPxvhAeUeG/ON878NKWttBA00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJdJDyJyFHC07Uldb1jP+Kd7FcUh8scxBcJuKSZ15JnClhUyN8aAl7D5zWscTZNOZzpQTtFYyeuRxivKrLRGLpoa+AQzHkQWtQMJVfT7H7IGSaP0B4V80JwcgbK+EE+Lsvt2z7fb8CxCvygBJMY8gNBrec7PmRjNgOjqafa3yjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FavHGOcd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZsbS9uDG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FavHGOcd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZsbS9uDG"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M00DKe3840523
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 03:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B+P4tUPyhPU3NezjUV2dp1RRkcsCE5jw+9E9ZGwbzTs=; b=FavHGOcdsCIBriaB
	MWpiaVpt/K8VPP+ZCahQRIgvuSojAJ22bYQkEQlH/cmCc0Hfnt2yuXYBSCbqmokx
	hZrulTNAVp/XSg5JHSO3xLQZxqba2SvArKFJQIsD6oF0mhzQukB7DoMeGLSOgfB6
	LMxp2xyxRp0ZEGmIEboCYkyF/ImxgWlO4bDUFwMARsg2nZf7BcqepnQHNuR7fQmP
	20WwksFpRwb5oA3F6YLRwBUDyvVul8u6G/pMNOzGW8etvHz/+huNC+I+4u8yCYYq
	3rJXUHFpsYuUCNNTW8YMe1IEU4k7ETNRLkjmLIBYeqU2RWRF/4I4vxsPjpL4PXlG
	1gQMKA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu8v521v3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 03:48:34 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca8aee88725so5430730a12.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 20:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790048913; x=1790653713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B+P4tUPyhPU3NezjUV2dp1RRkcsCE5jw+9E9ZGwbzTs=;
        b=ZsbS9uDGj+MHcj3ZaTKnydbNwyo5MmeW9YWzyr5f8OvZ4Gpjf6kZOyYV3wjYKG7p/g
         Xe1Zhq8T/2vbi9XCcINW76i7RhkID6qUcLwKV7PpUW3ZJ7cLX/X5LxC99qkTpIzXYwQO
         ysv9DBQ82VFzzFHjUL5q0DMMrSllOfywIHSyUsZCUjN+BdZx5YrSVxgDcRI37UkC78kv
         KUHRflPmVBcTPTIcIMhm94G3+rJfMmipfgKwls0aqBs+lCZpRkP4X2W7Z+mvYgqKtFII
         q0NiFjHaoTsjXRREs9x50LmYz1KHgWNGSICoj0XyFGYV5hA3f6k8d8iDp4++/jY7z4Qc
         J2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790048913; x=1790653713;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B+P4tUPyhPU3NezjUV2dp1RRkcsCE5jw+9E9ZGwbzTs=;
        b=F/hz1x8+sFxwPnpqrbb3zSWSuRuRnCyZSYdWJXSuLNKR1RSgt7khNVs0jRrieikhbb
         HP1w7Hzk+eR9HBPP8U09x10rz+ikPrxBskfGc40nm8bb6xmb4TTlInTa/T1O0jJ36H/D
         oxGfb1TaJJgyt29ZbKaDqGG21BXWCLsXl19DfB0WEUQg3Xw9AH+zOH55ISVYfwlRT8EO
         0az8MmYLEs4pp5TdNR7hBBBi3CAgV2fv0aeuWot/6QHciSO3mu7IEV/NGXNK4MJ74xz8
         4EIZYDZBOOOnWs1mFWVfdwWAFW4lyqTCw6WROdIqQXGhovW3Jk07y2VtHXVrbYFYU3q0
         gkbQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9TSDYySk843QfB/pRfabO1Vuqe1QKL5rhX8aTYvKcAaWFf8F52CFbzX3p1x4sUK2gY/8ryOe8cg==@vger.kernel.org
X-Gm-Message-State: AFuF++mAfZjEewxsw06bYCI3eoEnp1YXRDIIIrau7xoEE71Z6DIRvpwX
	+sDb3zGdXofwKwsY0jXKD4fo/IPsIvUCPhqQTlb8ucdlcEmkaSIEBuyX3S05kpBOqfWErF4HRJK
	J26EKhBBeVMaT8iLeJwunR5oVD6ABGBkgvO3nrC1bwcKMIVF3BjqiLgcGpyKWQA==
X-Gm-Gg: AYBFou1Yk7mMZnXF9apX040RJbb9NNYq/UNDE59ZF6BT/U3hTqiA9d+bsn8Zf8HeejX
	C+yn31FzoU79oD8uxOL5IrsBpB5RLD3LU8qXnsjMa+uwbPaF9EYlwF+dJshEh7AM0xGnIK3CkqW
	WoR9hUg/GroRBsI/5CubouvvrGwqqsajCiAJ0+9ZS3jjub0H2RFvNXwhbXQWimPfcZifEMBww+g
	ka3+7PDfD9OWkBItpEl4PRimWlYHCDtF+0+4SUrVIIAUs4H5kjurvCDjkXc1NbRnRYmRxa9y3Vb
	0to6Ng2plOnpCwi1WqXynZG12sscyp3uxopw17DQyqOehEbDTZc+NFB1hFZHLkMTTaQnuuAbFB/
	+R6UCDqc7GclOGgajLqFjxZ9QwjAODFsgImhiW6lL0g6uLU87hmitK+urBIGJd8tMpHU6J9nt
X-Received: by 2002:a05:6300:68c1:10b0:3dd:ddbd:c5a1 with SMTP id adf61e73a8af0-3ddddbdd505mr1962280637.0.1790048913598;
        Mon, 21 Sep 2026 20:48:33 -0700 (PDT)
X-Received: by 2002:a05:6300:68c1:10b0:3dd:ddbd:c5a1 with SMTP id adf61e73a8af0-3ddddbdd505mr1962260637.0.1790048913060;
        Mon, 21 Sep 2026 20:48:33 -0700 (PDT)
Received: from [10.133.33.126] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc756a317d7sm157989a12.16.2026.09.21.20.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 20:48:32 -0700 (PDT)
Message-ID: <495a47a3-ac6d-4002-abe3-23b85b2f2034@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 11:48:28 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: qcom-hw: order driver state before registration
To: jaidevshastri@vt.edu, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20260921-mb-qcom-cpufreq-v1-1-b5943c3fce18@vt.edu>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260921-mb-qcom-cpufreq-v1-1-b5943c3fce18@vt.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: f0z61Ev2Z8o_WebwC_HiZN2wgIRZDv8N
X-Authority-Analysis: v=2.4 cv=B+0sQ+tM c=1 sm=1 tr=0 ts=6ab1fa92 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=z3JUTzfoe6kKmln8kWwA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA1MCBTYWx0ZWRfX6ATt54AY2PXl
 vg03JK1jG6rnCnQmiwhSaSt9WTRQwAHOmeGhSDXrNcBOlHTzTo+UFZZ6EtWVhksEOyzBLuvX1FB
 CqWNc6ipGrT7T05lZpqWzuMreH7iRo4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA1MCBTYWx0ZWRfXyb07uCDFQ1Tk
 ur6/p2ZS8C6GcvgZYFp4MgN2NyLpw8Z+XmL+3l34mpk8poVqWJBKOqTyxDJm/F7j4ZHG6OQgysu
 /K4gySOPwzBn5kEp6NgzY3I+bAdtQczqFFVgzc8yOOs8pQXiZ00vH4+JnMhK7BQMIHIOvyVM0pA
 Hl+Kw/COVuJ2iApZCLepWy/+F4FsSZykEhx7Woso8HZe+W0qHafUsWztRS1u88pm030tQpnSeSQ
 nQtJJ28jI62ocY+eo+fn9xw+73dNCddmTwl8b2suIv5qsjlbAwY8x9Ge0qbWx6UFwQYB4YLiNuB
 PQsT8xsmtUk76yPbAlbhKNwzmwQ9bTIMOPME6aiBPsJgSRnD+OsnigK8WCn7Ufy71+ZTPvPGpPr
 0LSh9wf38uJGNwMcZT8/dDg+5XloghKLBpvVF3AD1fMS2DlqiyREg3RtvjFEUj1kYGa1jl/HSD+
 LcFv034R6ZPl4I/kXpw==
X-Proofpoint-ORIG-GUID: f0z61Ev2Z8o_WebwC_HiZN2wgIRZDv8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220050

Hi Jaidev,

On 9/22/2026 9:11 AM, Jaidev Shastri via B4 Relay wrote:
> From: Jaidev Shastri <jaidevshastri@vt.edu>
> 
> qcom_cpufreq_hw_driver_probe() stores xo_rate, cpu_hw_rate,
> qcom_cpufreq.soc_data and the per-domain qcom_cpufreq.data[] array with
> plain stores and then calls cpufreq_register_driver(). The cpufreq core
> invokes qcom_cpufreq_hw_cpu_init() for every policy, on other CPUs, and
> that function reads all of them with plain loads.

It should be not. This all runs in the context of the same thread(no
other workqueue, kthread, or IPI), so I don't see a need for cross-CPU
memory barriers here. Even in the CPU hotplug case, the relevant path is
already serialized by locks(cpu_hotplug_lock).

> 
> Order the stores before the registration with smp_wmb() and add the
> matching smp_rmb() in qcom_cpufreq_hw_cpu_init().
> 
> Found with MBCheck, a static herd7-based memory consistency checker.
> 
> Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
> ---
>   drivers/cpufreq/qcom-cpufreq-hw.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 874ff3fb9..62cc1f403 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -554,6 +554,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   		return ret;
>   
>   	index = args.args[0];
> +	/* Pairs with the smp_wmb() before cpufreq_register_driver() in probe. */
> +	smp_rmb();
>   	data = &qcom_cpufreq.data[index];
>   
>   	/* HW should be in enabled state to proceed */
> @@ -738,6 +740,13 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> +	/*
> +	 * qcom_cpufreq_hw_cpu_init() runs on other CPUs through the cpufreq
> +	 * core once the driver is registered and reads xo_rate, cpu_hw_rate,
> +	 * qcom_cpufreq.soc_data and qcom_cpufreq.data[]. Order those stores
> +	 * before the registration. Pairs with the smp_rmb() in cpu_init.
> +	 */
> +	smp_wmb();
>   	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
>   	if (ret)
>   		dev_err(dev, "CPUFreq HW driver failed to register\n");
> 
> ---
> base-commit: 93f51579e7df248780214094418f205253383cc5
> change-id: 20260921-mb-qcom-cpufreq-42f15afbfa4f
> 
> Best regards,
> --
> Jaidev Shastri <jaidevshastri@vt.edu>
> 
> 
> 


-- 
Thx and BRs,
Zhongqiu Han
