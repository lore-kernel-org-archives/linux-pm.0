From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH][RFC] x86, hotplug: Use zero page for monitor when
 resuming from hibernation
Date: Mon, 6 Jun 2016 15:59:06 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6402876CB97@shsmsx102.ccr.corp.intel.com>
References: <1465222749-8388-1-git-send-email-yu.c.chen@intel.com>
 <20160606142506.GE30909@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160606142506.GE30909@twins.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Borislav Petkov <bp@suse.de>, Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, Juergen Gross <jgross@suse.com>
List-Id: linux-pm@vger.kernel.org

Hi Peter,

> -----Original Message-----
> From: Peter Zijlstra [mailto:peterz@infradead.org]
> Sent: Monday, June 06, 2016 10:25 PM
> To: Chen, Yu C
> Cc: x86@kernel.org; linux-kernel@vger.kernel.org; Thomas Gleixner; Ingo
> Molnar; H . Peter Anvin; linux-pm@vger.kernel.org; Rafael J . Wysocki; Pavel
> Machek; Brown, Len; Borislav Petkov; Zhu Guihua; Juergen Gross
> Subject: Re: [PATCH][RFC] x86, hotplug: Use zero page for monitor when
> resuming from hibernation
> 
> On Mon, Jun 06, 2016 at 10:19:09PM +0800, Chen Yu wrote:
> > @@ -1595,8 +1596,21 @@ static inline void mwait_play_dead(void)
> >  	 * This should be a memory location in a cache line which is
> >  	 * unlikely to be touched by other processors.  The actual
> >  	 * content is immaterial as it is not actually modified in any way.
> > +	 *
> > +	 * However in hibernation resume process, this address could be
> > +	 * touched by BSP when restoring page frames, if the page table
> > +	 * for this address is not coherent across hibernation(due to
> > +	 * inconsistence of e820 memory map), access from APs might
> > +	 * cause exception. So change the mwait address to zero page,
> > +	 * which is located in .bss, in this way we can avoid illegal
> > +	 * access from APs because page table for kernel mapping
> > +	 * of text/data/bss should keeps unchanged according to
> > +	 * hibernation semantic.
> >  	 */
> > -	mwait_ptr = &current_thread_info()->flags;
> > +	if (hibernation_in_resume())
> > +		mwait_ptr = empty_zero_page;
> > +	else
> > +		mwait_ptr = &current_thread_info()->flags;
> 
> Why is this conditional? Is there any case in which the zero page is not also
> correct?
I'm thinking of avoid unnecessary wakeup for normal CPU offline,  for example, 
if one  driver uses  the zero page and access it.
