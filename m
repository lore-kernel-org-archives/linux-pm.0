From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH 3/4][RFC v2] PM / hibernate: introduce a flag to
 indicate resuming from hibernation
Date: Sun, 26 Jun 2016 01:34:22 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6402877B804@shsmsx102.ccr.corp.intel.com>
References: <cover.1466844557.git.yu.c.chen@intel.com>
 <d4195120e18af7b097b64b0c45a55187617dc234.1466844557.git.yu.c.chen@intel.com>
 <20160625165302.GC4362@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160625165302.GC4362@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Varun Koyyalagunta <cpudebug@centtech.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz]
> Sent: Sunday, June 26, 2016 12:53 AM
> To: Chen, Yu C
> Cc: linux-pm@vger.kernel.org; x86@kernel.org; Rafael J. Wysocki; Len Brown;
> Peter Zijlstra; H. Peter Anvin; Borislav Petkov; Brian Gerst; Thomas Gleixner;
> Ingo Molnar; Varun Koyyalagunta; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 3/4][RFC v2] PM / hibernate: introduce a flag to indicate
> resuming from hibernation
> 
> On Sun 2016-06-26 00:18:52, Chen Yu wrote:
> > Sometime we need to do some operations before resuming from
> > hibernation, so introduce a flag to indicate this stage.
> >
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  include/linux/suspend.h  | 7 +++++++
> >  kernel/power/hibernate.c | 3 +++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/include/linux/suspend.h b/include/linux/suspend.h index
> > 8b6ec7e..422e87a 100644
> > --- a/include/linux/suspend.h
> > +++ b/include/linux/suspend.h
> > @@ -384,6 +384,12 @@ extern bool system_entering_hibernation(void);
> >  extern bool hibernation_available(void);  asmlinkage int
> > swsusp_save(void);  extern struct pbe *restore_pblist;
> > +extern bool in_resume_hibernate;
> 
> in_resume_hibernation? But it is pretty sad if we need another such
> state function...
At first I tried not to add any new flags, and just let all the CPUs fall into hlt if it is
triggered by disable_nonboot_cpus, but as depicted in [PATCH 4/4], 
there is a scenario that,   what about the CPUs already  offline before
the hibernation? They might be in deep cstate by mwait, and mwait is not
safe during resume.
We have to kick all the offline CPUs online again, and then
put them offline to hlt state, thus to avoid the unsafe memory access during resume.
(The memory mapping for text code is not safe during resume, so it's hard to fix it
in mwait_play_dead, and the kick mechanism seems to be a suitable choice).
In order to restrict the impact of the kick mechanism to a minimal scope, I used this
flag to make this  mechanism only work for hibernation resume phase.

thanks,
Yu
