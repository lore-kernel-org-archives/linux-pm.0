Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE899386434
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941065; cv=none; b=ZYkYssMI34ZM7+3mqAsaZQGePF/yvHT8HajgrV0awABvpTUARaz3f/ky5Fm//PTRayWkQZ+IIZ21oZ3byLEdVIOh5EnITUia5Sm4I9wq5NZU0ZUBa2p4g+WxI6tusWklzZfpJVlu6hywqx2yKqtRtziQs6UHtZO+ZQFGHY0E8lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941065; c=relaxed/simple;
	bh=6R4gXuB/h+BJWvQ+CyjpXaet8ZV90sqEMx6l3shGFgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQRh0xDSc2Hcr/qaoe/dqu9/8eGoQmR81JaI8giOYCCBFTwPVxwexWSAvCHKZEHHRgYzMcvluMh6q0JdIdmSnFgVtR8TCNiBQqYgJdDWIfUhEW7EWXe/wYahXxwwTb8LtFRWP13pJFnghPrffkvQX+EAIm/jpNnfr3yBXsotDCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UomUmIDB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eIvIZ+mO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UomUmIDB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eIvIZ+mO"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V5SHas2408168
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 07:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kDYIGHGFRibBsxSj/d6PGjsRu/pA4unCsga4OGe4mtY=; b=UomUmIDBAzA2628x
	5ofCNxClgq3C3hXQdeWbeoKtrdKqzw+ioQ7qUIQX7AkQ6Q/PahtQw8AoE4sz5ixA
	R0Q942wTzktlnfwhj8HISfZlOEbR0nh2DwqnBRDcLwEpY7JMcNMzfkWdrBNyZU4J
	P5+Ltnwb+zz8E/RLZ9QO3EDT7WNbUYBkhg7zr4t2Plo5bWrznwtb4aC0SAY+gJjy
	9lOfalfWbxY61yqfF/rzu30elsjMNieJTvZ9LnLjLa7ZiBzg19N8oyTQaONAJUmK
	MX8h1X2fjKm14Su5LDDItHr08cDNBd0K9yz00pg223tgMq9S9oClchhZYVOSuUnq
	VMMiJw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d80hest2p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 07:11:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c739120475fso3441545a12.3
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 00:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774941061; x=1775545861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kDYIGHGFRibBsxSj/d6PGjsRu/pA4unCsga4OGe4mtY=;
        b=eIvIZ+mOur6KnspIY6XgrQZP8Aw/VIaCa7une9aFRGQgi0ezBv5R3Sj6iGdXJy5bE0
         ilDFfKLZvYF4pOj82MFxruk8uuL7xTHSEZd/TnsP7Hgn3JOSj2z0cfDCGLyAEl4bDczE
         vLfDJC0jH9DAyCWBCu3XwhNLWEOVhUoP3mEeuhX6QgxCNHy60S2aKJBwIleS+h4DyOus
         KRQUhNFGKdO/JqyDozt6TXKgYM7agR8OIQF51/etw74KLunwaoaJ0//iuatqIa+prENx
         5r26qOXjdazVlsn+Xw+xOmzjDpDjuIhkxV4R5eCbIt6FEa9YS2kpF36LsilB3f1vI1wq
         XFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774941061; x=1775545861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDYIGHGFRibBsxSj/d6PGjsRu/pA4unCsga4OGe4mtY=;
        b=FdUSQ5+cGkhq4favQibyLeqTovm8agpxxtKndFgl/qCEHGDdmliLVd+av09EJ+ULP+
         a3ZAeKJ7ahDIAFZGse5scRfx04wsgOxkhVCh/bgLdUVPFFSp3WeYBsLZc763zinOtiMC
         Bk/2YPiWCPLASiNt407yqkbRtnBjz/SVGOfnuBukV0zvF2SswX8yXZ/2L8Sj3qmNXmc2
         wKlQPDQYD3H+7kfiEqwlUNttjN5vjmRQ3zUzti6Yp3BNtN3gwCXvJaNfesz4WNaCPJ9x
         krEQM7z5Ld/0wJeSDhHo4DkgRDuLdxb0FCFd9lR5gBRUgxEo7QUFxAaXBb7Nbcqoj5/7
         k2OA==
X-Gm-Message-State: AOJu0YwKSVxCRRTp6sXMKeTx/suwSQWsJITNC0hTMhQUiXhyzMZ/cVmj
	1nqatn/zhJSgz4297yXijJJWLURxdzxwtKRCda5UNQhYJjn6UT+gPV0SXMNS2p6TEHoA1rO6bZR
	AwIL0Oj0KH86beD+bkiq93oXBuDGV01a7ZgUDxlzXd9WIzm6ter+pgZQ58y7diA==
X-Gm-Gg: ATEYQzy2UWP416RapoJan81ckQX0BNxtbPQdDI7QHGMIVxfjWfOZod5Ytnha3v8C9tr
	DuKZUOtuw3yXcdhx5G5RHw51cUd31iuPoK/3HKqiNdKW1ixVp05jNaSNOIPy96NfXqb15+TdQ3G
	wPwbL5rdDb8Mj0KkwkkB2L8bN3K7F9XDS4JPDmBriyD11v0luH/qq9nh2fC0uWpvLzHFkJqjhk0
	lHw3q1UFVd51Of5Nb1kjt72z67E12knEups4AN9wYex1/tbIb7U9XBgzvaZdRL3QDNnF98Gt3Am
	4vCcrfVkoKHjw6zGn2p/5ThESUo+xh3RELO6+NF1tgNphyH3AoEYigvbMMw7PQEbdqk66i3P6mX
	wTLX83j/waszZTlqOjAWAndzZvexis6A+nZ6e5aCCtVcHGl5DB/OdkyN89/vSoJ7yNzNEQqg2Gy
	yizrDHvvelheFxEM8o
X-Received: by 2002:a05:6a00:4147:b0:827:2ee4:c90f with SMTP id d2e1a72fcca58-82c9605dbb2mr13455050b3a.53.1774941060514;
        Tue, 31 Mar 2026 00:11:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:4147:b0:827:2ee4:c90f with SMTP id d2e1a72fcca58-82c9605dbb2mr13455011b3a.53.1774941059890;
        Tue, 31 Mar 2026 00:10:59 -0700 (PDT)
Received: from [10.133.33.66] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca846d8a9sm9732615b3a.19.2026.03.31.00.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 00:10:59 -0700 (PDT)
Message-ID: <cc388a7c-7c2b-4fc0-9869-853c5316697b@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 15:10:54 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Allocate QoS freq_req objects with policy
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <a293f29d841b86c51f34699c6e717e01858d8ada.1774933424.git.viresh.kumar@linaro.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <a293f29d841b86c51f34699c6e717e01858d8ada.1774933424.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Gb0aXAXL c=1 sm=1 tr=0 ts=69cb7385 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=kjUqTUbl9X0R13TV6OoA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: nKI1AZUp_Uusq4esHZbyKdZKLpxJxrRX
X-Proofpoint-ORIG-GUID: nKI1AZUp_Uusq4esHZbyKdZKLpxJxrRX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA2NyBTYWx0ZWRfX84s/EAFXaYLX
 TIMBqgCm0cCIxZUnhOpcYCNBnQHli85ebcmHFKCjDw38Ij7B/ijwUWgA/rogbp6mWYYc4YQrckZ
 uAYz/SjIocZ2pkFGCVJ8U5BE08yF6em/ybDCqYPzucD2nVzcgBKhNJu2iSo0KYFKzO0xK4onbCR
 Okk0Ubp3N/lfmzjz4heQJSPPdlddQtir+/WpfvmLeG7hWEuB7t2XMsxU6AptAvVaL60yfU618LV
 SxN1VamB9NzsMOAIA8xXC66Y/t7nkgnaQBNV8p10rqn98V3dGqRKA03r5Pr0xgj7Hwnt+rKmAYf
 /r1nngDfZ6Wh8/9i2P9zlIIUI4QE9Ky2k0NKb9gkkh4I7BSM0Nf1XGVhnZiwZXnGQUnB+vZ78tc
 Gzuze7B4n3dry+ugIrJPYOPiVzZM3lKabsglY4VzzdS9II9jJZBOdi5zmdbfEk87tcmHOv3UuOr
 /4Vn8M9743Op27fqAtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310067

On 3/31/2026 1:03 PM, Viresh Kumar wrote:
> A recent change exposed a bug in the error path: if
> freq_qos_add_request(boost_freq_req) fails, min_freq_req may remain a
> valid pointer even though it was never successfully added. During policy
> teardown, this leads to an unconditional call to
> freq_qos_remove_request(), triggering a WARN.
> 
> The current design allocates all three freq_req objects together, making
> the lifetime rules unclear and error handling fragile.
> 
> Simplify this by allocating the QoS freq_req objects at policy
> allocation time. The policy itself is dynamically allocated, and two of
> the three requests are always needed anyway. This ensures consistent
> lifetime management and eliminates the inconsistent state in failure
> paths.
> 
> Reported-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Fixes: 6e39ba4e5a82 ("cpufreq: Add boost_freq_req QoS request")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks for the elegant solution. It looks good to me.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   drivers/cpufreq/cpufreq.c | 53 +++++++++++----------------------------
>   include/linux/cpufreq.h   |  6 ++---
>   2 files changed, 17 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index c0aa970c7a67..f4a949f1e48f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -614,7 +614,7 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
>   		return ret;
>   	}
>   
> -	ret = freq_qos_update_request(policy->boost_freq_req, policy->cpuinfo.max_freq);
> +	ret = freq_qos_update_request(&policy->boost_freq_req, policy->cpuinfo.max_freq);
>   	if (ret < 0) {
>   		policy->boost_enabled = !policy->boost_enabled;
>   		cpufreq_driver->set_boost(policy, policy->boost_enabled);
> @@ -769,7 +769,7 @@ static ssize_t store_##file_name					\
>   	if (ret)							\
>   		return ret;						\
>   									\
> -	ret = freq_qos_update_request(policy->object##_freq_req, val);\
> +	ret = freq_qos_update_request(&policy->object##_freq_req, val);	\
>   	return ret >= 0 ? count : ret;					\
>   }
>   
> @@ -1374,7 +1374,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>   	/* Cancel any pending policy->update work before freeing the policy. */
>   	cancel_work_sync(&policy->update);
>   
> -	if (policy->max_freq_req) {
> +	if (freq_qos_request_active(&policy->max_freq_req)) {
>   		/*
>   		 * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
>   		 * notification, since CPUFREQ_CREATE_POLICY notification was
> @@ -1382,12 +1382,13 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>   		 */
>   		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>   					     CPUFREQ_REMOVE_POLICY, policy);
> -		freq_qos_remove_request(policy->max_freq_req);
> +		freq_qos_remove_request(&policy->max_freq_req);
>   	}
>   
> -	freq_qos_remove_request(policy->min_freq_req);
> -	freq_qos_remove_request(policy->boost_freq_req);
> -	kfree(policy->min_freq_req);
> +	if (freq_qos_request_active(&policy->min_freq_req))
> +		freq_qos_remove_request(&policy->min_freq_req);
> +	if (freq_qos_request_active(&policy->boost_freq_req))
> +		freq_qos_remove_request(&policy->boost_freq_req);
>   
>   	cpufreq_policy_put_kobj(policy);
>   	free_cpumask_var(policy->real_cpus);
> @@ -1452,57 +1453,31 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>   	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>   
>   	if (new_policy) {
> -		unsigned int count;
> -
>   		for_each_cpu(j, policy->related_cpus) {
>   			per_cpu(cpufreq_cpu_data, j) = policy;
>   			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>   		}
>   
> -		count = policy->boost_supported ? 3 : 2;
> -		policy->min_freq_req = kzalloc(count * sizeof(*policy->min_freq_req),
> -					       GFP_KERNEL);
> -		if (!policy->min_freq_req) {
> -			ret = -ENOMEM;
> -			goto out_destroy_policy;
> -		}
> -
>   		if (policy->boost_supported) {
> -			policy->boost_freq_req = policy->min_freq_req + 2;
> -
>   			ret = freq_qos_add_request(&policy->constraints,
> -						   policy->boost_freq_req,
> +						   &policy->boost_freq_req,
>   						   FREQ_QOS_MAX,
>   						   policy->cpuinfo.max_freq);
> -			if (ret < 0) {
> -				policy->boost_freq_req = NULL;
> +			if (ret < 0)
>   				goto out_destroy_policy;
> -			}
>   		}
>   
>   		ret = freq_qos_add_request(&policy->constraints,
> -					   policy->min_freq_req, FREQ_QOS_MIN,
> +					   &policy->min_freq_req, FREQ_QOS_MIN,
>   					   FREQ_QOS_MIN_DEFAULT_VALUE);
> -		if (ret < 0) {
> -			kfree(policy->min_freq_req);
> -			policy->min_freq_req = NULL;
> +		if (ret < 0)
>   			goto out_destroy_policy;
> -		}
> -
> -		/*
> -		 * This must be initialized right here to avoid calling
> -		 * freq_qos_remove_request() on uninitialized request in case
> -		 * of errors.
> -		 */
> -		policy->max_freq_req = policy->min_freq_req + 1;
>   
>   		ret = freq_qos_add_request(&policy->constraints,
> -					   policy->max_freq_req, FREQ_QOS_MAX,
> +					   &policy->max_freq_req, FREQ_QOS_MAX,
>   					   FREQ_QOS_MAX_DEFAULT_VALUE);
> -		if (ret < 0) {
> -			policy->max_freq_req = NULL;
> +		if (ret < 0)
>   			goto out_destroy_policy;
> -		}
>   
>   		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>   				CPUFREQ_CREATE_POLICY, policy);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index b6f6c7d06912..9b10eb486ece 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -79,9 +79,9 @@ struct cpufreq_policy {
>   					 * called, but you're in IRQ context */
>   
>   	struct freq_constraints	constraints;
> -	struct freq_qos_request	*min_freq_req;
> -	struct freq_qos_request	*max_freq_req;
> -	struct freq_qos_request *boost_freq_req;
> +	struct freq_qos_request	min_freq_req;
> +	struct freq_qos_request	max_freq_req;
> +	struct freq_qos_request boost_freq_req;
>   
>   	struct cpufreq_frequency_table	*freq_table;
>   	enum cpufreq_table_sorting freq_table_sorted;


-- 
Thx and BRs,
Zhongqiu Han
