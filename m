From: Abhishek <huntbag@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] cpupower : Fix cpupower working when cpu0 is offline
Date: Tue, 7 Nov 2017 14:28:22 +0530
Message-ID: <b1ae1a14-b354-6bc5-6118-87c7b65ce8a1@linux.vnet.ibm.com>
References: <20171107072005.48034-1-huntbag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752400AbdKGI6b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Nov 2017 03:58:31 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA78uPSL109553
        for <linux-pm@vger.kernel.org>; Tue, 7 Nov 2017 03:58:30 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e393qhvbm-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 07 Nov 2017 03:58:30 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Tue, 7 Nov 2017 08:58:27 -0000
In-Reply-To: <20171107072005.48034-1-huntbag@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Shuah Khan <shuah@kernel.org>, Thomas Renninger <trenn@suse.com>

Hi,

Can you have a look at it?

Thanks and Regards,

Abhishek Goel

System Engineer

IBM India Pvt. Ltd.


On 11/07/2017 12:50 PM, Abhishek Goel wrote:
> cpuidle_monitor used to assume that cpu0 is always online which is not
> a valid assumption on POWER machines. This patch fixes this by searching
> for the first online cpu and uses it, instead of always using cpu0 for
> monitoring which may not be online.
>
> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> ---
> v2: Commit message updated.
> ---
>   tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
> index 1b5da00..adacf99 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
> +++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
> @@ -130,15 +130,23 @@ static struct cpuidle_monitor *cpuidle_register(void)
>   {
>   	int num;
>   	char *tmp;
> +	int first_online_cpu;
> +
> +	for (num = 0; num < cpu_count; num++) {
> +		if (cpupower_is_cpu_online(num))
> +			break;
> +	};
> +	first_online_cpu = num;
>
>   	/* Assume idle state count is the same for all CPUs */
> -	cpuidle_sysfs_monitor.hw_states_num = cpuidle_state_count(0);
> +	cpuidle_sysfs_monitor.hw_states_num =
> +		cpuidle_state_count(first_online_cpu);
>
>   	if (cpuidle_sysfs_monitor.hw_states_num <= 0)
>   		return NULL;
>
>   	for (num = 0; num < cpuidle_sysfs_monitor.hw_states_num; num++) {
> -		tmp = cpuidle_state_name(0, num);
> +		tmp = cpuidle_state_name(first_online_cpu, num);
>   		if (tmp == NULL)
>   			continue;
>
> @@ -146,7 +154,7 @@ static struct cpuidle_monitor *cpuidle_register(void)
>   		strncpy(cpuidle_cstates[num].name, tmp, CSTATE_NAME_LEN - 1);
>   		free(tmp);
>
> -		tmp = cpuidle_state_desc(0, num);
> +		tmp = cpuidle_state_desc(first_online_cpu, num);
>   		if (tmp == NULL)
>   			continue;
>   		strncpy(cpuidle_cstates[num].desc, tmp,	CSTATE_DESC_LEN - 1);
