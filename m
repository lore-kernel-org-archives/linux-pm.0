From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpupower : Fix cpupower working when cpu0 is offline
Date: Tue, 26 Sep 2017 15:42:36 +0530
Message-ID: <20170926101236.GA25906@in.ibm.com>
References: <20170922110218.120948-1-huntbag@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754309AbdIZKMp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2017 06:12:45 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8QAC27T062393
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2017 06:12:44 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2d7mpah6m6-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2017 06:12:44 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Tue, 26 Sep 2017 04:12:43 -0600
Content-Disposition: inline
In-Reply-To: <20170922110218.120948-1-huntbag@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Cc: trenn@suse.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Sep 22, 2017 at 04:32:18PM +0530, Abhishek Goel wrote:
> cpuidle_monitor used to assume that cpu0 is always online.

On what platform is this assumption not valid and what is the problem
caused due to this.

> Now the
> cpuidle_monitor function searches for the first online cpu and use
> it, instead of always using cpu0 which may not be online.

Mention that this is the fix performed by this patch.

> 
> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> ---
>  tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
> index 1b5da00..adacf99 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
> +++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
> @@ -130,15 +130,23 @@ static struct cpuidle_monitor *cpuidle_register(void)
>  {
>  	int num;
>  	char *tmp;
> +	int first_online_cpu;
> +
> +	for (num = 0; num < cpu_count; num++) {
> +		if (cpupower_is_cpu_online(num))
> +			break;
> +	};

Don't we have an API that gives the list by parsing
"/sys/devices/system/cpu/online" ?


> +	first_online_cpu = num;
>
>  	/* Assume idle state count is the same for all CPUs */
> -	cpuidle_sysfs_monitor.hw_states_num = cpuidle_state_count(0);
> +	cpuidle_sysfs_monitor.hw_states_num =
> +		cpuidle_state_count(first_online_cpu);
> 
>  	if (cpuidle_sysfs_monitor.hw_states_num <= 0)
>  		return NULL;
> 
>  	for (num = 0; num < cpuidle_sysfs_monitor.hw_states_num; num++) {
> -		tmp = cpuidle_state_name(0, num);
> +		tmp = cpuidle_state_name(first_online_cpu, num);
>  		if (tmp == NULL)
>  			continue;
> 
> @@ -146,7 +154,7 @@ static struct cpuidle_monitor *cpuidle_register(void)
>  		strncpy(cpuidle_cstates[num].name, tmp, CSTATE_NAME_LEN - 1);
>  		free(tmp);
> 
> -		tmp = cpuidle_state_desc(0, num);
> +		tmp = cpuidle_state_desc(first_online_cpu, num);
>  		if (tmp == NULL)
>  			continue;
>  		strncpy(cpuidle_cstates[num].desc, tmp,
>CSTATE_DESC_LEN - 1);


Looks ok to me otherwise.

> -- 
> 2.9.3
> 
