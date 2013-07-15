From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/8] cpufreq: Preserve policy structure across suspend/resume
Date: Mon, 15 Jul 2013 17:22:57 +0530
Message-ID: <51E3E299.6070104@linux.vnet.ibm.com>
References: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com> <20130711221704.547.64296.stgit@srivatsabhat.in.ibm.com> <CAKohpom+WcTcefCZitgZQcSjTPsgXsa6VKQF5y6GJA31-rBm0w@mail.gmail.com> <51E3C950.90503@linux.vnet.ibm.com> <CAKohponudZ+f=0k9xYhHv3FAKv3Mw6Lc-4MoV9+++VqBsvCNDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:55744 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756005Ab3GOL43 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 07:56:29 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 16 Jul 2013 08:52:01 +1000
In-Reply-To: <CAKohponudZ+f=0k9xYhHv3FAKv3Mw6Lc-4MoV9+++VqBsvCNDg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, toralf.foerster@gmx.de, robert.jarzmik@intel.com, durgadoss.r@intel.com, tianyu.lan@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/15/2013 03:51 PM, Viresh Kumar wrote:
> On 15 July 2013 15:35, Srivatsa S. Bhat
> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>> Actually even I was wondering about this while writing the patch and
>> I even tested shutdown after multiple suspend/resume cycles, to verify that
>> the refcount is messed up. But surprisingly, things worked just fine.
> 
> What kind of system have you tested it on?
> 

The system has 2 sockets with 8 cores each, and has Intel Sandybridge
CPUs. I had used a local patch to simulate CPU hotplug in the suspend-to-ram
path using the freeze state of pm_test (because I had other problems in
using the 'processors' state of pm_test). The patch is shown below:


diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index ece0422..fe07b77 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -342,8 +342,13 @@ static int enter_state(suspend_state_t state)
 	if (error)
 		goto Unlock;
 
-	if (suspend_test(TEST_FREEZER))
+	if (suspend_test(TEST_FREEZER)) {
+		pr_debug("Disabling nonboot CPUs\n");
+		disable_nonboot_cpus();
+		pr_debug("Enabling nonboot CPUs\n");
+		enable_nonboot_cpus();
 		goto Finish;
+	}
 
 	pr_debug("PM: Entering %s sleep\n", pm_states[state]);
 	pm_restrict_gfp_mask();


 
Regards,
Srivatsa S. Bhat

