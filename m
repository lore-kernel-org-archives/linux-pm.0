From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH 3/3] PM / hibernate: Remove the restriction when
 checking memory size before/after hibernation
Date: Tue, 1 Sep 2015 09:54:31 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6401CB03732@SHSMSX101.ccr.corp.intel.com>
References: <cover.1440640658.git.yu.c.chen@intel.com>
 <1392db911417124cd85cd8c169c5bc2de4ea5de1.1440640658.git.yu.c.chen@intel.com>
 <20150828053751.GD26741@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150828053751.GD26741@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "pavel@ucw.cz" <pavel@ucw.cz>, "hpa@zytor.com" <hpa@zytor.com>, "Brown, Len" <len.brown@intel.com>, "yinghai@kernel.org" <yinghai@kernel.org>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Ingo, thanks for your review/suggestion,

> -----Original Message-----
> From: Ingo Molnar [mailto:mingo.kernel.org@gmail.com] On Behalf Of Ingo
> Molnar
> Sent: Friday, August 28, 2015 1:38 PM
> To: Chen, Yu C
> Cc: tglx@linutronix.de; mingo@redhat.com; rjw@rjwysocki.net;
> pavel@ucw.cz; hpa@zytor.com; Brown, Len; yinghai@kernel.org;
> joeyli.kernel@gmail.com; Zhang, Rui; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 3/3] PM / hibernate: Remove the restriction when
> checking memory size before/after hibernation
> 
> 
> * Chen Yu <yu.c.chen@intel.com> wrote:
> > +	/*
> > +	 * No need to check num_physpages with get_num_physpages
> > +	 * as we did before(please refer to git log), because
> > +	 * is_nosave_page will ensure that each page is safe
> > +	 * to be restored.
> > +	 */
> >  	if (reason) {
> >  		printk(KERN_ERR "PM: Image mismatch: %s\n", reason);
> >  		return -EPERM;
> 
> No, this removes a useful sanity check that protects against data corruption.
> 
> If you want to relax it then you should add code that checks whether the
> before/after memory image is truly a superset of each other, and warn and
> deny the hibernation in any other case. (For example when RAM got
> removed or moved.)
> 
OK, I've sent out another patch based on pfn_mapped checking.thanks

Best Regards,
Yu
> Thanks,
> 
> 	Ingo
