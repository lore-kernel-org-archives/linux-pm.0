From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [RESEND][PATCHv2] cpupower: Correct return type of
 cpu_power_is_cpu_online in cpufreq
Date: Thu, 20 Oct 2016 13:42:49 +0530
Message-ID: <331512cb-ccfb-a9eb-fea8-501fa333920c@linux.vnet.ibm.com>
References: <1476917632-7831-1-git-send-email-labbott@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753785AbcJTIM6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2016 04:12:58 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9K8AXoo060704
        for <linux-pm@vger.kernel.org>; Thu, 20 Oct 2016 04:12:57 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
        by mx0a-001b2d01.pphosted.com with ESMTP id 266t6d83hy-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 20 Oct 2016 04:12:56 -0400
Received: from localhost
        by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
        Thu, 20 Oct 2016 18:12:54 +1000
In-Reply-To: <1476917632-7831-1-git-send-email-labbott@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laura Abbott <labbott@redhat.com>, Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>



On 10/20/2016 04:23 AM, Laura Abbott wrote:
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
> v2: Drop another redundant cpupower_is_cpu_online

Reviewed-by:Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

