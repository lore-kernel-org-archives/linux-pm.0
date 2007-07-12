From: david@lang.hm
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Thu, 12 Jul 2007 11:49:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707121145400.25614__29445.9682926119$1184266725$gmane$org@asgard.lang.hm>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<4695C096.5080400@goop.org>
	<Pine.LNX.4.64.0707112319550.28090@asgard.lang.hm>
	<200707121446.14170.rjw@sisk.pl> <469631FA.2070405@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <469631FA.2070405@rtr.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Lord <lkml@rtr.ca>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Jul 2007, Mark Lord wrote:

> Rafael J. Wysocki wrote:
>>  On Thursday, 12 July 2007 08:43, david@lang.hm wrote:
>> >  On Wed, 11 Jul 2007, Jeremy Fitzhardinge wrote:
>> > 
>> > >  Andrew Morton wrote:
> ..
>> >  8. hibernate kernel does syspend-to-ram to put the devices into a known 
>> >  safe state.
>>  Again, the devices should be quiesced rather then suspended in this step.
>
> That's just not possible.  The Hibernate kernel will not have all
> of the same device drivers as the mainline kernel.  Or at least that's
> what people have previously stated here.

devices that have not been touches don't need to be quiesced or put into a 
low-power state, they are still waiting to be initialized. so as long as 
the device initialization can be done from the low-power or quiesced state 
things will work just fine.

> ..
>> > > >   This sounds awesome.  Am I correct in expecting that ultimately the
>> > > >   existing hibernation implementation just goes away and we reuse 
>> > > >   (and hence
>> > > >   strengthen) the existing kexec (and kdump?) infrastructure?
>
> No, not so simple.  We still need much of the code to santize devices
> upon wakeup from hibernation.   And adding this extra reboot-kernel step
> in the midst of hibernate will double the time it takes (ugh).
>
> Currently, TuxOnIce(suspend2) takes about 10 seconds to suspend my notebook.
> Switching to this new scheme would double that to 10 seconds to boot/probe,
> plus the original 10 seconds to hibernate.  Assuming the new implementation
> even comes close to suspend2 speed.

why do you assume that it will take 10 seconds to boot the new kernel? 
linuxbiosdoes it in <2 seconds, someone else posted on this thread <5 
seconds

> And the complexity and difficulty of setup really scares me.
> Right now, we've got a pretty good/fast in-kernel (well, external patch)
> that allows my machines to hibernate very quickly, wake up even faster,
> and not swap like mad afterwards.  Without any external programs,
> initramfs, or extra kernels required.
>
> And we want to replace this with an ultra-complex setup because.. ????

the complexity of the freezer freezing some things, but not other things 
keeps getting t wrong and many people can't think of any algorithm that 
will always get it right. This approach bypasses the entire problem 
makeing it much simpler conceptually, even though there are a few more 
parts involved.

David Lang
