From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH v2 1/3] PM / Core: suspend_again callback
 for device PM.
Date: Wed, 27 Apr 2011 00:10:54 +0200
Message-ID: <20110426221054.GB29092__25738.9823360883$1303861572$gmane$org@elf.ucw.cz>
References: <1303288106-2965-1-git-send-email-myungjoo.ham@samsung.com>
	<201104262247.44113.rjw@sisk.pl>
	<20110426210627.GA28033@elf.ucw.cz>
	<201104262346.58046.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201104262346.58046.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: zaurus-devel@www.linuxtogo.org, arminlitzel@web.de, thommycheck@gmail.com, Marek Vasut <marek.vasut@gmail.com>, dbaryshkov@gmail.com, lenz@cs.wisc.edu, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@lists.linux-foundation.org, omegamoon@gmail.com, Len Brown <len.brown@intel.com>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, eric.y.miao@gmail.com, Cyril Hrubis <metan@ucw.cz>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, utx@penguin.cz, kyungmin.park@samsung.com, "Jean Delvare (PC drivers core)" <khali@linux-fr.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > And that's exactly what should be done.  Have a user space process controlling
> > > that, because avoiding to thaw user space doesn't buy us almost
> > > anything.
> > 
> > That makes Zaurus implement different user-kernel interface than PC
> > class machine, because of hardware quirk.
> 
> Let me say that again: If Zaurus needs to resume everything except for
> user space periodically to monitor the battery charger, I'm not sure if our
> suspend interface is the right one for it in the first place.

Well, Zaurus does not need to resume everything. SPI+charger code is
enough, and that would be preffered. No need to touch disk etc.

> It seriously looks like a workaround for the lack of appropriately implemented
> runtime PM, just like the Android's opportunistic suspend.

No, not really. I'm running standard Debian; I do not want/need
anything like opportunistic suspend.

> > > Now, I know that it's probably easier to modify the kernel than to write
> > > a user space tool for that, test it and so on, but "easier" is not necessarily
> > > "better".
> > 
> > It is easier, allows us to keep same user-kernel interface on PC and
> > Zaurus, and is compatible with 2.6.38.
> > 
> > Heck, I'm used to typing "echo mem > /sys/power/state". I should not
> > have to learn different interface just because Zaurus does not have
> > proper hardware charger.
> 
> No, this interface should not be used on Zaurus at all.  It's not mean for
> that and while you can hack it to kind of work, it still is hacking rather
> than designing things.

Why not? I want the Zaurus to sleep. Why should I have to know how its
charging unit works? Why should I use different interface than on PC?
I want it to suspend, put it into backpack and move...

> > Bootloader takes care of battery in that case.
> 
> So the difference is that we let someone else worry.  Cool. :-)

Yes.

> > Ok, see the spitz_should_wakeup() function in arch/arm/mach-pxa/* and
> > should_wakeup() usage.
> 
> OK, I will.

Thanks.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
