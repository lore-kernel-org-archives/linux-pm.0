From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RESEND][PATCHv2] cpupower: Correct return type of cpu_power_is_cpu_online in cpufreq
Date: Mon, 24 Oct 2016 17:11:25 +0200
Message-ID: <3917157.z59pS4HJyr@skinner>
References: <1476917632-7831-1-git-send-email-labbott@redhat.com> <331512cb-ccfb-a9eb-fea8-501fa333920c@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33935 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938455AbcJXPLe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Oct 2016 11:11:34 -0400
In-Reply-To: <331512cb-ccfb-a9eb-fea8-501fa333920c@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: Laura Abbott <labbott@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Thursday, October 20, 2016 01:42:49 PM Shilpasri G Bhat wrote:
> On 10/20/2016 04:23 AM, Laura Abbott wrote:
> > When converting to a shared library in ac5a181d065d ("cpupower: Add
> > cpuidle parts into library"), cpu_freq_cpu_exists was converted to
> > cpupower_is_cpu_online. cpu_req_cpu_exists returned 0 on success and
> > -ENOSYS on failure whereas cpupower_is_cpu_online returns 1 on success.
> > Check for the correct return value in cpufreq-set.
> > 
> > See https://bugzilla.redhat.com/show_bug.cgi?id=1374212
> > 
> > Fixes: ac5a181d065d ("cpupower: Add cpuidle parts into library")
> > Reported-by: Julian Seward <jseward@acm.org>
> > Signed-off-by: Laura Abbott <labbott@redhat.com>
> > ---
> > v2: Drop another redundant cpupower_is_cpu_online
> 
> Reviewed-by:Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Acked-by: Thomas Renninger <trenn@suse.com>

I wanted to go through all recently sent patches and adjust rebase them to
my lates changes.
But I guess the fact that I push this from day to day because of other
stuff should not hold off such important fixes.

I collect and review all others as well the next day(s)..

      Thomas
