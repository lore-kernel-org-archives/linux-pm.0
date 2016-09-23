From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpupower: Correct return type of cpu_power_is_cpu_online
 in cpufreq
Date: Fri, 23 Sep 2016 21:47:53 +0530
Message-ID: <a4b38f85-f8d3-a3fd-91a9-219462641ee6@linux.vnet.ibm.com>
References: <1473441919-7809-1-git-send-email-labbott@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55215 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965898AbcIWQSD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Sep 2016 12:18:03 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8NGFoTN096781
        for <linux-pm@vger.kernel.org>; Fri, 23 Sep 2016 12:18:02 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
        by mx0a-001b2d01.pphosted.com with ESMTP id 25mqb7s857-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Fri, 23 Sep 2016 12:18:02 -0400
Received: from localhost
        by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
        Sat, 24 Sep 2016 02:17:59 +1000
In-Reply-To: <1473441919-7809-1-git-send-email-labbott@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laura Abbott <labbott@redhat.com>, Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 09/09/2016 10:55 PM, Laura Abbott wrote:
> When converting to a shared library in ac5a181d065d ("cpupower: Add
> cpuidle parts into library"), cpu_freq_cpu_exists was converted to
> cpupower_is_cpu_online. cpu_req_cpu_exists returned 0 on success and
> -ENOSYS on failure whereas cpupower_is_cpu_online returns 1 on success.
> Check for the correct return value in cpufreq-set.
> 
> See https://bugzilla.redhat.com/show_bug.cgi?id=1374212
> 
> Fixes: ac5a181d065d ("cpupower: Add cpuidle parts into library")
> Reported-by: Julian Seward <jseward@acm.org>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  tools/power/cpupower/utils/cpufreq-set.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
> index b4bf769..8971d71 100644
> --- a/tools/power/cpupower/utils/cpufreq-set.c
> +++ b/tools/power/cpupower/utils/cpufreq-set.c
> @@ -296,7 +296,7 @@ int cmd_freq_set(int argc, char **argv)
>  			struct cpufreq_affected_cpus *cpus;
> 
>  			if (!bitmask_isbitset(cpus_chosen, cpu) ||
> -			    cpupower_is_cpu_online(cpu))
> +			    cpupower_is_cpu_online(cpu) != 1)
>  				continue;
> 
>  			cpus = cpufreq_get_related_cpus(cpu);
> @@ -316,7 +316,7 @@ int cmd_freq_set(int argc, char **argv)
>  	     cpu <= bitmask_last(cpus_chosen); cpu++) {
> 
>  		if (!bitmask_isbitset(cpus_chosen, cpu) ||
> -		    cpupower_is_cpu_online(cpu))
> +		    cpupower_is_cpu_online(cpu) != 1)
>  			continue;
> 
>  		if (cpupower_is_cpu_online(cpu) != 1)
		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Can you also remove the above check where the same condition
'cpupower_is_cpu_online(cpu) != 1' is tested twice ?

Thanks and Regards,
Shilpa

