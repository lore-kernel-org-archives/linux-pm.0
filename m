From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH v2 1/3] PM / Core: suspend_again callback
	for device PM.
Date: Tue, 26 Apr 2011 23:46:57 +0200
Message-ID: <201104262346.58046.rjw__15855.7892930277$1303860947$gmane$org@sisk.pl>
References: <1303288106-2965-1-git-send-email-myungjoo.ham@samsung.com>
	<201104262247.44113.rjw@sisk.pl>
	<20110426210627.GA28033@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110426210627.GA28033@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: zaurus-devel@www.linuxtogo.org, arminlitzel@web.de, thommycheck@gmail.com, Marek Vasut <marek.vasut@gmail.com>, dbaryshkov@gmail.com, lenz@cs.wisc.edu, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@lists.linux-foundation.org, omegamoon@gmail.com, Len Brown <len.brown@intel.com>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, eric.y.miao@gmail.com, Cyril Hrubis <metan@ucw.cz>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, utx@penguin.cz, kyungmin.park@samsung.com, "Jean Delvare (PC drivers core)" <khali@linux-fr.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, April 26, 2011, Pavel Machek wrote:
> Hi!
> 
> > > > "too heavy" (in fact it's much lighter weight than resuming all devices
> > > > that your approach doesn't prevent from happening, so for example on my
> > > > desktop/notebook machines I woulnd't mind at all if user space were
> > > > thawed after all of the devices had been resumed).
> > > 
> > > Well, it would be behavior change for the user. I told the zaurus to
> > > go s2ram, I do not expect it to wake up after 5 minutes because it
> > > needed to check battery status.
> > > 
> > > I'd have to modify my userland to retry suspend again and again and
> > > again...
> > 
> > And that's exactly what should be done.  Have a user space process controlling
> > that, because avoiding to thaw user space doesn't buy us almost
> > anything.
> 
> That makes Zaurus implement different user-kernel interface than PC
> class machine, because of hardware quirk.

Let me say that again: If Zaurus needs to resume everything except for
user space periodically to monitor the battery charger, I'm not sure if our
suspend interface is the right one for it in the first place.

It seriously looks like a workaround for the lack of appropriately implemented
runtime PM, just like the Android's opportunistic suspend.

> > Now, I know that it's probably easier to modify the kernel than to write
> > a user space tool for that, test it and so on, but "easier" is not necessarily
> > "better".
> 
> It is easier, allows us to keep same user-kernel interface on PC and
> Zaurus, and is compatible with 2.6.38.
> 
> Heck, I'm used to typing "echo mem > /sys/power/state". I should not
> have to learn different interface just because Zaurus does not have
> proper hardware charger.

No, this interface should not be used on Zaurus at all.  It's not mean for
that and while you can hack it to kind of work, it still is hacking rather
than designing things.

> > > I'm not sure if we need to cover hibernation. Do you know any machine
> > > that needs this for hibernation case?
> > 
> > Yes, any machine that "needs" it while suspended.  What's the difference,
> > after all?  The only difference is that there's an image on permanent storage
> > in the hibernation case.  You still can overheat a battery when charging it
> > while hibernated, right?
> 
> No, you can not; not on Zaurus.
> 
> It can not really power down; it is always sleeping. s2ram is sleep in
> operating system,

Which is not the meaning of S2RAM I use.

> hibernation or poweroff is sleep in bootloader.
> 
> Bootloader takes care of battery in that case.

So the difference is that we let someone else worry.  Cool. :-)

> > > > To conclude, I'm not sure about the approach.  In particular, I'm not sure
> > > > if the benefit is worth the effort and the resulting complications (ie. the
> > > > possibility of having to deal with wakeup signals not requested by user
> > > > space) seem to be a bit too far reaching.
> > > 
> > > We already have platform-specific hacks to do exactly this at least on
> > > Zaurus. Moving it to common code means that hacks are not duplicated..
> > 
> > Well, good to know they are there, but I'm still not sure what to do about
> > that.  At the moment I feel like having too little information to really
> > decide, so perhaps please point me to the code you're talking about for
> > starters.
> 
> Ok, see the spitz_should_wakeup() function in arch/arm/mach-pxa/* and
> should_wakeup() usage.

OK, I will.

Thanks,
Rafael
