From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] [v2] x86, suspend: Save/restore extra MSR registers for
 suspend
Date: Sat, 22 Aug 2015 22:30:28 +0200
Message-ID: <20150822203028.GA28112@amd>
References: <1440158014-29610-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36170 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbbHVUae (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 22 Aug 2015 16:30:34 -0400
Content-Disposition: inline
In-Reply-To: <1440158014-29610-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rui.zhang@intel.com, lenb@kernel.org, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri 2015-08-21 19:53:34, Chen Yu wrote:
> A bug is reported(https://bugzilla.redhat.com/show_bug.cgi?id=1227208)
> that, after resuming from S3, CPU is working at a low speed.
> After investigation, it is found that, BIOS has modified the value
> of THERM_CONTROL register during S3, changes it from 0 to 0x10,
> while the latter means CPU can only get 25% of the Duty Cycle,
> and this caused the problem.
> 
> Simple scenario to reproduce:
> 1.Boot up system
> 2.Get MSR with address 0x19a, it should output 0
> 3.Put system into sleep, then wake up
> 4.Get MSR with address 0x19a, it should output 0(actual it outputs 0x10)
> 
> Although this is a BIOS issue, it would be more robust for linux to deal
> with this situation. This patch fixes this issue by introducing a framework
> for saving/restoring specify MSR registers(THERM_CONTROL in this case)
> on suspend/resume.
> 
> When user finds a problematic platform that requires save/restore MSRs,
> he can simply add quirk in msr_save_dmi_table, and customizes MSR
> registers in quirk callback, for example:
> 
> unsigned int msr_id_need_to_save[] = {MSR_ID0, MSR_ID1, MSR_ID2...};
> 
> and system ensures that, once resumed from suspend, these MSR indicated
> by IDs will be restored to their original values before suspend.
> 
> Since both 64/32-bit kernels are affected, this patch covers 64/32-bit
> common code path. And because the MSR ids specified by user might not be
> available or readable in any situation, we use rdmsrl_safe to safely
> save these MSR registers.
> 
> Tested-by: Marcin Kaszewski <marcin.kaszewski@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
