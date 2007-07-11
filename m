From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: Hibernate after alarm wakes from STR
Date: Wed, 11 Jul 2007 12:09:04 +0200
Message-ID: <200707111209.05163.rjw__40661.6627741188$1184148173$gmane$org@sisk.pl>
References: <20070330235759.GC4252@cosmic.amd.com>
	<20070711015948.GA30659@srcf.ucam.org>
	<200707111314.04221.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707111314.04221.nigel@nigel.suspend2.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: nigel@suspend2.net
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, rtc-linux@googlegroups.com, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday, 11 July 2007 05:14, Nigel Cunningham wrote:
> Hi.
> 
> On Wednesday 11 July 2007 11:59:48 Matthew Garrett wrote:
> > On Wed, Jul 11, 2007 at 11:39:37AM +1000, Nigel Cunningham wrote:
> > 
> > > Yeah, that is a bit confusing. At the moment, I'm doing the suspend to ram 
> > > platform dependent preparation and cleanup in this scenario. That's 
> > > definitely the right thing to do in the case where we write an image, then 
> > > suspend to ram, wake and continue working without running running out of 
> > > battery (writing the image is redundant in that case). Where we end up 
> > > properly powering down after suspending to ram, I believe we don't run the 
> > > pm_ops->finish after doing the atomic restore when resuming the image.
> > 
> > I'm not convinced this can work terribly well. It's not unlikely that 
> > hardware will need different state stored over different types of 
> > suspend. Can you separate out the saving of kernel memory and userspace 
> > memory, then resume/suspend/save the new kernel state without touching 
> > the userspace state?
> 
> Yeah, we could redo and resave the atomic copy, but it doesn't seem to be 
> necessary at the moment; it has been working reliably, regardless of which 
> combination of events occurs. If/when I come across a case where we have 
> problems, I'll give resaving the atomic copy a go.
> 
> (Thinks some more). Ah, I think we're already doing the right thing, if I'm 
> recalling the order of actions right. If I'm remembering correctly, prior to 
> the atomic copy, we do hibernation prep, then after the atomic copy, 
> hibernation cleanup. Then, if suspending to ram, we do the prep/enter/cleanup 
> after the image has finished writing. If we lose power from suspend to ram, 
> it doesn't matter because we're just doing a normal resume then, with the 
> hibernation cleanup post atomic restore machine the prep that was done prior 
> to the atomic copy.
> 
> To summarise:
> 
> Hibernate + STR + full wake.
>  Hibernation prep
>  (Atomic copy)
>  Hibernation cleanup
>  STR prep
>  STR enter
>  STR cleanup		
>  Remove hibernation image
> 
> Hibernate + STR + poweroff + hibernate resume:
> 
>  Hibernation prep
>  (Atomic copy)
>  Hibernation cleanup
>  STR prep
>  STR enter
>  <power out> or <STR wake + power off> (STR prep/enter no longer matters)
>  (Fresh boot)
>  Atomic restore
>  Hibernation cleanup (matching prep at start)
>  Remove hibernation image

Yes, I think that this is the right ordering, but for some graphics adapters
we need to do some tricks from the user space before 'STR prep' and after
'STR cleanup', which is theoretically possible with uswsusp.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
