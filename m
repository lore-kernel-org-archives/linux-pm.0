From: Prarit Bhargava <prarit@redhat.com>
Subject: [Question] Why is there a restriction on the policy->rwsem & CPUFREQ_GOV_POLICY_EXIT ?
Date: Wed, 23 Jul 2014 16:45:39 -0400
Message-ID: <1406148339-29065-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54344 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932847AbaGWUpv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 23 Jul 2014 16:45:51 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, Prarit Bhargava <prarit@redhat.com>

I'm debugging a race/locking issue in the store_scaling_governor path and
came across the following restriction on using a semaphore in the
cpufreq_policy struct defined in include/linux/cpufreq.h :

         * Additional rules:
         * - Lock should not be held across
         *     __cpufreq_governor(data, CPUFREQ_GOV_POLICY_EXIT);

	struct rw_semaphore	rwsem;

I'm not completely familiar with this code and am wondering why the
restriction is in place?  Is there a worry about the module_put() in
__cpufreq_governor()?

Thanks,

P.
