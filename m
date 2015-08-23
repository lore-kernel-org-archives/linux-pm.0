From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] [v2] x86, suspend: Save/restore extra MSR registers for
 suspend
Date: Sun, 23 Aug 2015 08:20:33 +0200
Message-ID: <20150823062033.GB18134@gmail.com>
References: <1440158014-29610-1-git-send-email-yu.c.chen@intel.com>
 <20150822203028.GA28112@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150822203028.GA28112@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Chen Yu <yu.c.chen@intel.com>, rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rui.zhang@intel.com, lenb@kernel.org, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> On Fri 2015-08-21 19:53:34, Chen Yu wrote:
> > A bug is reported(https://bugzilla.redhat.com/show_bug.cgi?id=1227208)
> > that, after resuming from S3, CPU is working at a low speed.
> > After investigation, it is found that, BIOS has modified the value
> > of THERM_CONTROL register during S3, changes it from 0 to 0x10,
> > while the latter means CPU can only get 25% of the Duty Cycle,
> > and this caused the problem.
> > 
> > Simple scenario to reproduce:
> > 1.Boot up system
> > 2.Get MSR with address 0x19a, it should output 0
> > 3.Put system into sleep, then wake up
> > 4.Get MSR with address 0x19a, it should output 0(actual it outputs 0x10)
> > 
> > Although this is a BIOS issue, it would be more robust for linux to deal
> > with this situation. This patch fixes this issue by introducing a framework
> > for saving/restoring specify MSR registers(THERM_CONTROL in this case)
> > on suspend/resume.
> > 
> > When user finds a problematic platform that requires save/restore MSRs,
> > he can simply add quirk in msr_save_dmi_table, and customizes MSR
> > registers in quirk callback, for example:
> > 
> > unsigned int msr_id_need_to_save[] = {MSR_ID0, MSR_ID1, MSR_ID2...};
> > 
> > and system ensures that, once resumed from suspend, these MSR indicated
> > by IDs will be restored to their original values before suspend.
> > 
> > Since both 64/32-bit kernels are affected, this patch covers 64/32-bit
> > common code path. And because the MSR ids specified by user might not be
> > available or readable in any situation, we use rdmsrl_safe to safely
> > save these MSR registers.
> > 
> > Tested-by: Marcin Kaszewski <marcin.kaszewski@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

So I like the general structure of the patch and I like the MSR saving mechanism 
it introduces, but it is full of typos and small stylistic uncleanlinesses which 
need to be fixed before this patch can be applied. Please don't ack incomplete 
patches.

Thanks,

	Ingo
