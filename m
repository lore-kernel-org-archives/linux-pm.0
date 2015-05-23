From: Abel Vesa <abelvesa@gmail.com>
Subject: Re: [PATCH] sched: Fix compiler errors for NO_SMP machines
Date: Sat, 23 May 2015 22:22:25 +0300
Message-ID: <20150523192225.GA9002@gmail.com>
References: <1431459549-18343-26-git-send-email-morten.rasmussen@arm.com>
 <1432324094-29573-1-git-send-email-abelvesa@gmail.com>
 <20150523145223.GA16405@gmail.com>
Reply-To: 20150523145223.GA16405@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38465 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932291AbbEWTVq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 May 2015 15:21:46 -0400
Content-Disposition: inline
In-Reply-To: <20150523145223.GA16405@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mingo@kernel.org, morten.rasmussen@arm.com, peterz@infradead.org
Cc: vincent.guittot@linaro.org, Dietmar.Eggemann@arm.com, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri.Lelli@arm.com, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Sat, May 23, 2015 at 04:52:23PM +0200, Ingo Molnar wrote:
> 
> What tree is this against? Neither the upstream kernel nor 
> tip:sched/core (the scheduler development tree) has this function.
>

Sorry, I forgot to mention.

This patch applies to:

git://linux-arm.org/linux-power.git energy_model_rfc_v4

Best regards,
Abel 
