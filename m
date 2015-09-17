From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] [v4] x86, suspend: Save/restore extra MSR registers for
 suspend
Date: Thu, 17 Sep 2015 07:30:04 +0200
Message-ID: <20150917053004.GB6665@amd>
References: <1440645507-17768-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54508 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbbIQFaK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2015 01:30:10 -0400
Content-Disposition: inline
In-Reply-To: <1440645507-17768-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, rui.zhang@intel.com, linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Thu 2015-08-27 11:18:27, Chen Yu wrote:
> A bug is reported(https://bugzilla.redhat.com/show_bug.cgi?id=1227208)
> that, after resumed from S3, CPU is running at a low speed.
> After investigation, it is found that, BIOS has modified the value
> of THERM_CONTROL register during S3, and changes it from 0 to 0x10,
> since value of 0x10 means CPU can only get 25% of the Duty Cycle,
> this triggers the problem.
> 
> Here is a simple scenario to reproduce the issue:
> 1.Boot up the system
> 2.Get MSR with address 0x19a, it should be 0
> 3.Put the system into sleep, then wake it up
> 4.Get MSR with address 0x19a, it should be 0(actually it shows 0x10)
> 
> Although this is a BIOS issue, it would be more robust for linux to deal
> with this situation. This patch fixes this issue by introducing a framework
> to save/restore specified MSR registers(THERM_CONTROL in this case)
> for suspend/resume.
> 
> When user encounters a problematic platform and needs to protect the
> MSRs during suspending, he can simply add a quirk entry in
> msr_save_dmi_table, and customizes MSR registers inside the quirk
> callback, for example:
> 
> u32 msr_id_need_to_save[] = {MSR_ID0, MSR_ID1, MSR_ID2...};
> 
> and the quirk mechanism ensures that, once resumed from suspended,
> the MSRs indicated by these IDs will be restored to their original values
> before suspended.
> 
> Since both 64/32-bit kernels are affected, this patch covers 64/32-bit
> common code path. And because the MSRs specified by the user might not
> be available or readable in any situation, we use rdmsrl_safe to safely
> save these MSRs.
> 
> Tested-by: Marcin Kaszewski <marcin.kaszewski@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
