From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 12/20] cpufreq: Mark policy->governor = NULL for
 inactive policies
Date: Sat, 4 Apr 2015 08:37:09 +0530
Message-ID: <CAKohpo=wyQ-_+B-rycMfoi1KpSWrBJWQx4JAanca=p+1OpJgUA@mail.gmail.com>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
	<466c5246b6ad83b960eeb63ab34a04379448980d.1424345053.git.viresh.kumar@linaro.org>
	<551CC7E2.6070806@codeaurora.org>
	<CAKohpok37PXGxmP+M-d8mpT-eGxaCjtAwgQdZO=mJ9PmvxTv3w@mail.gmail.com>
	<551F3C7B.7060004@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35528 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbbDDDHK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2015 23:07:10 -0400
Received: by obbfy7 with SMTP id fy7so105920051obb.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2015 20:07:09 -0700 (PDT)
In-Reply-To: <551F3C7B.7060004@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 4 April 2015 at 06:50, Saravana Kannan <skannan@codeaurora.org> wrote:
> I would strongly prefer that this is not done and just clear out the pointer
> if/when the governor module is removed.

Okay, I give up ..

This looks fine ?

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4604ad5d9c0c..1f285b06d473 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1094,7 +1094,6 @@ static struct cpufreq_policy
*cpufreq_policy_restore(unsigned int cpu)
        if (likely(policy)) {
                /* Policy should be inactive here */
                WARN_ON(!policy_is_inactive(policy));
-               policy->governor = NULL;
        }

        return policy;
@@ -2156,8 +2155,10 @@ void cpufreq_unregister_governor(struct
cpufreq_governor *governor)
        /* clear last_governor for all inactive policies */
        read_lock_irqsave(&cpufreq_driver_lock, flags);
        for_each_inactive_policy(policy, tpolicy) {
-               if (!strcmp(policy->last_governor, governor->name))
+               if (!strcmp(policy->last_governor, governor->name)) {
+                       policy->governor = NULL;
                        strcpy(policy->last_governor, "\0");
+               }
        }
        read_unlock_irqrestore(&cpufreq_driver_lock, flags);
