From: Abhishek <huntbag@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] cpupowerutils: bench - Fix cpu online check
Date: Tue, 7 Nov 2017 15:20:29 +0530
Message-ID: <3a6fd547-b367-6e35-7fb5-5ab8d1139b5b@linux.vnet.ibm.com>
References: <20171107094755.49440-1-huntbag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933731AbdKGJuf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Nov 2017 04:50:35 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA79mIhf113515
        for <linux-pm@vger.kernel.org>; Tue, 7 Nov 2017 04:50:35 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2e39qdtgup-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 07 Nov 2017 04:50:34 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Tue, 7 Nov 2017 09:50:31 -0000
In-Reply-To: <20171107094755.49440-1-huntbag@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shuah Khan <shuahkh@osg.samsung.com>, Shuah Khan <shuah@kernel.org>, Thomas Renninger <trenn@suse.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

Can you please have a look at this also?

Thanks and Regards,
Abhishek Goel
System Engineer
IBM India Pvt. Ltd.

On 11/07/2017 03:17 PM, Abhishek Goel wrote:
> cpupower_is_cpu_online was incorrectly checking for 0. This patch fixes
> this by checking for 1 when the cpu is online.
>
> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> ---
> v2: Commit message rephrased.
> ---
>   tools/power/cpupower/bench/system.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/power/cpupower/bench/system.c b/tools/power/cpupower/bench/system.c
> index c25a74a..2bb3eef 100644
> --- a/tools/power/cpupower/bench/system.c
> +++ b/tools/power/cpupower/bench/system.c
> @@ -61,7 +61,7 @@ int set_cpufreq_governor(char *governor, unsigned int cpu)
>
>   	dprintf("set %s as cpufreq governor\n", governor);
>
> -	if (cpupower_is_cpu_online(cpu) != 0) {
> +	if (cpupower_is_cpu_online(cpu) != 1) {
>   		perror("cpufreq_cpu_exists");
>   		fprintf(stderr, "error: cpu %u does not exist\n", cpu);
>   		return -1;
