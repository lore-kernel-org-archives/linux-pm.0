Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED860370AD2
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209558; cv=none; b=kmO21YbQpy63Fxl4ohiSTvsT3G8IzrvFZ1ifcwGhrZ47m3GRMS+eplkNksCtTXXfcurYoXvNoPheFTeJQzeBL8k3a8UauQMvpQaPCt/+LY+ala5BmP+HDxGxauStHuvcDUGEBdw1ynveZnwjRkx6kxolSUBKLI6YQGlwUJ38QV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209558; c=relaxed/simple;
	bh=Q48johTNqyvyTS3co9XgbDSXqXhNj9ySgShOWR3xwvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pj00QdaN+dbLN41LDV/KuDZc43dp2EtIqDcIxN5SzYBN8sFx2s+Gq8agyvHiDd/R2bL5JYMolSxgcqMG5RRv5mC4H9t2wxcrZ/N8fj9ief2V2xe81BpLSe+hmpOsTwaym0lZie5J+pTyJDOjIoyW5pgNjX7qsqWaXkUA9UvpzqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OTTe1sgz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Oz1bO6CE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OTTe1sgz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Oz1bO6CE"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N7krWe3228504
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 10:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DXZEh/kSy7m60n4iWCnV+JVUfl7x1SxFuAddkvpHw6Q=; b=OTTe1sgzySdKtPsD
	wnQmnQsQw1RG9FExhgN33mTthroMrFIXOu3EhM+QTlMctFzqUbwYo5MOCSFxm+yS
	M3sFDwBg/ijjSxm5cbtcXjs3bq14bKG66AvoU90v7YxsBorF1wqY+0UnR/DaYzz+
	Sw5XkYzdK7vhj8ZQ6Oae0/TuYQ2rSqNthZpzvPzythVj1RfA0HsrqJO9v7wJeDX9
	JwDxWwfknbNB2r7JuJ7Cit3PuYBU3u2shInpeWRd4polUVQtkQ7n5PL7WFQmA8kO
	HXbTE++kNUlHuNp80jN0ocPivXZmFadRxalS+OEL5KICSdo8NSe5TKw65ED7RdlR
	w8NPbg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp29gmmw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 10:12:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9157db42dd8so1107293185a.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 03:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782209554; x=1782814354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXZEh/kSy7m60n4iWCnV+JVUfl7x1SxFuAddkvpHw6Q=;
        b=Oz1bO6CE61FYMyzyQ1RZx1WQABat0C7NP05teUxEAghg+UC8BRL1AmoUyXbkr/a3sm
         5QXkxp7fBWhjWydF/EVj0AGM5MW+qyNfXS6zxmjNm8DnJR0KyH4t2RueR2DVKZlLm5xY
         6XFH+mwDD0jcOPtyQVkp+JZFLA+fTk+eIgEtyVGVXHeD7ZxWTVmYpM3P85tdd4fxR7Cz
         3d3z/PWhEl9dYQPvhN/1EiNMBh7+ct3TRxS9ghZm7UhkMFmN/S9ivIMIE9ucmOWn2bKl
         bkKZvAUiSM8c5ca6MULza1pqzz6PMgeiSgvghXHj7amL43LXi0XxFag6ihfxgs/JT380
         uPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782209554; x=1782814354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXZEh/kSy7m60n4iWCnV+JVUfl7x1SxFuAddkvpHw6Q=;
        b=aDQK22nQvuvcg4h/0nUNat3XNz03l3IHX9FLVg7YBHnd+vx0cCQeKHW0SoFecPuFjd
         YaHZ4a87ZqieWWuWAwOptHGwIh+NV3Y+rFttX4MhmV4xSNGT0GtXrukIho5al5/oQ2Yl
         6m1wdxzK3fq2QvCghgb+rVmQsGlgYEWtFLKjR8R0saX09k+GqoN5aZJkM6wu83144Xo4
         AJcdtCpPjtJKsYhoyQECnFU5a77znYnqrP+MTOf6bqRMWjN29abSb81903+7GO+5AmbG
         B6dATMhZNO0PTOfs7fJOQ9nZ3AAmZRdvgWrrlsxMzdGrV4RIE6U4an6R0nWQ0JmogWsH
         k8Ng==
X-Forwarded-Encrypted: i=1; AFNElJ+3KoYfmyhX1zNUOz4aJhXel83B343TUjOfMQtiS9nmEw8njbTBe3aZ3iDwyWgjQ4bzQgGb3r2zOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyELmqqywfa00NOM8W5WHj9zqu3WGCThDXQ5mUdXDoFII+q0D/A
	OaxCNfQfoSPChZTClFoW8CKIYfqfNSdNED7nBum+Wm3u3uTUp6fhdDTdNxbBqT32vPPTzhPA7rx
	RGdL6xLGZ8/hzsrql5Q7MUJKWgWdjlHJ7dgo256BN94fBnlcFcnEduCIYB6hXEHc6Ee5eMA==
X-Gm-Gg: AfdE7cliGjPKj8XLvlLOCcW5r3Dgqd3xgC2NpIfP45rvC3H45FmjqgbUC/J3+Q24BjP
	wonrJSnp57yHbzn3qvEXUJgkOyyrZ7yoLUkBZtdlwEhcDVD8UUXdvliMijCUMy+/ryNpSTd5qx1
	pvD7SOtq4IkI6F9OulbIQKWbjXkGljrPqT7vwHZkaPD9WPKZCcIGnQKrkGW2ZlhgwqIVz0Jl1lq
	6shk6B2kdI1rKIJk8wCp7SsQbT8IJbgcWh5iXu9N1+TZTUofdk14QJ4TRDAZzFD+11Q2RjZ7Meq
	yA1b88TGPjzPcacqCdCQvsPH9XgnUrtUj+NiBUYC4WSpy7fYo/ZD34bu02OnAhWhjH4yn41m12J
	zJqJg8Zw0BsNjXSZXkBpfh9Wnu3Go4AJroekGHtc8O4LWIvSN4j3IyI+P/xrgKvDWE3U1aW9Lxw
	==
X-Received: by 2002:a05:620a:444c:b0:915:9efe:6de8 with SMTP id af79cd13be357-9266a033d5emr286817685a.58.1782209554237;
        Tue, 23 Jun 2026 03:12:34 -0700 (PDT)
X-Received: by 2002:a05:620a:444c:b0:915:9efe:6de8 with SMTP id af79cd13be357-9266a033d5emr286812785a.58.1782209553635;
        Tue, 23 Jun 2026 03:12:33 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:21db:9254:19d9:645e? ([2a05:6e02:1041:c10:21db:9254:19d9:645e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd15535sm399389615e9.3.2026.06.23.03.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 03:12:32 -0700 (PDT)
Message-ID: <60e8aeba-666c-453d-b2cb-3c45bb9723d2@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 12:12:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powercap: dtpm_cpu: Guard em_cpu_get() against NULL
 return in sysfs callbacks
To: Elazar Leibovich <elazarl@gmail.com>, linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        linux-kernel@vger.kernel.org, Sivan Zohar-Kotzer <sivany32@gmail.com>
References: <20260611204658.47987-1-elazarl@gmail.com>
 <20260611204658.47987-2-elazarl@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260611204658.47987-2-elazarl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LdAMLDfi c=1 sm=1 tr=0 ts=6a3a5c13 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=Xzsr67MKrT1HMcM2bGYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: Rg5U3VmI2yHnOYSoScirC7xXkWUi5EIq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4MiBTYWx0ZWRfX838LeVIiIINH
 pNaYLYiV7HQNRvaha0kljBzfPshscsgT0mFEV9XV/jNWkIFQ2xBo01bYckUeKAXtr6LHVRWzBQu
 wHK1ujYV2GZf5PzIjBtzv2mBdNbKurA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4MiBTYWx0ZWRfX3bA4wriSROK/
 f94ns7GMf18OwIs6Mf6S12SaybkiGAYIElPv4+qGEkHykVQVHrc7XLPfpieNbkcARC5cjf/9T9z
 86tgjBb7JtbtBY43i5fMzgGRX4QuXV3MMpJ4I97drr5nXWnWQTevbjGh+5tjmlJTlgsU5qhZeBY
 3SfZMsmvnA5oCQYG4RK/1WGIhtcAtASPS5npaLmphNej1LUIQfRJeOoXxhClFJP6GqDbWbnKFEw
 hOk3/WBtVq5nLBxpY2BpbcJFf1rt0BCnQsRxSUGDJPYkqEJE3bsoKaAelrwGXfAGSJU7IQrL+xy
 ONbQFwHGUb+0JrLW8qbjQ+1KH6vqxBfjdz61sviU9E4DRbs3fVnIuqDUvde0AXT57dtSYkmjsJY
 e7v7dp7EbhDhGph/ih0AnIOVTlLpkg==
X-Proofpoint-ORIG-GUID: Rg5U3VmI2yHnOYSoScirC7xXkWUi5EIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230082


Hi,

On 6/11/26 22:46, Elazar Leibovich wrote:
> From: Sivan Zohar-Kotzer <sivany32@gmail.com>
> 
> em_cpu_get() can return NULL when the CPU has no energy model registered
> (e.g. during hotplug races or initialization failures). Two call sites
> miss the NULL test:
> 
> 1. set_pd_power_limit() — reachable from sysfs via the powercap
>     constraint power_limit_uw store path. If NULL, return the current
>     power limit unchanged (no-op) instead of crashing.

If there is no energy model, then __dtpm_cpu_setup() fails and dtpm_ops 
is not set. Consequently, set_pd_power_limit() can not be called.


> 2. update_pd_power_uw() — called from CPU hotplug handlers via
>     dtpm_update_power(). Return -EINVAL if the EM is absent, since this
>     is an internal consistency failure that should not be swallowed.

If there is no energy model, then __dtpm_cpu_setup() fails and 
dtpm_per_cpu is not set and dtpm_update_power() is not called.

online/offline:

         if (dtpm_cpu)
                 dtpm_update_power(&dtpm_cpu->dtpm);


> The other sysfs-reachable path, get_pd_power_uw(), already has a NULL
> guard returning 0.
> 
> Fixes: 0e8f68d7f048 ("powercap/drivers/dtpm: Add CPU energy model based support")
> Signed-off-by: Sivan Zohar-Kotzer <sivany32@gmail.com>
> Co-developed-by: Elazar Leibovich <elazarl@gmail.com>
> Signed-off-by: Elazar Leibovich <elazarl@gmail.com>
> ---
>   drivers/powercap/dtpm_cpu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 99390ec1481f..0a460f97bf15 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -47,6 +47,9 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
>   	u64 power;
>   	int i, nr_cpus;
>   
> +	if (!pd)
> +		return dtpm->power_limit;
> +
>   	nr_cpus = cpumask_weight_and(cpu_online_mask, to_cpumask(pd->cpus));
>   
>   	rcu_read_lock();
> @@ -125,6 +128,9 @@ static int update_pd_power_uw(struct dtpm *dtpm)
>   	struct em_perf_state *table;
>   	int nr_cpus;
>   
> +	if (!em)
> +		return -EINVAL;
> +
>   	nr_cpus = cpumask_weight_and(cpu_online_mask, to_cpumask(em->cpus));
>   
>   	rcu_read_lock();


