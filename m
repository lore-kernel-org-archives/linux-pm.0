From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH v2 1/3] PM / Core: suspend_again callback
	for device PM.
Date: Wed, 27 Apr 2011 00:32:41 +0200
Message-ID: <201104270032.42046.rjw__6285.54948275468$1303862272$gmane$org@sisk.pl>
References: <1303288106-2965-1-git-send-email-myungjoo.ham@samsung.com>
	<20110426210627.GA28033@elf.ucw.cz>
	<201104262346.58046.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: Pavel Machek <pavel@ucw.cz>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Len Brown <len.brown@intel.com>, thommycheck@gmail.com, eric.y.miao@gmail.com, zaurus-devel@www.linuxtogo.org, dbaryshkov@gmail.com, Cyril Hrubis <metan@ucw.cz>, arminlitzel@web.de, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, utx@penguin.cz, lenz@cs.wisc.edu, kyungmin.park@samsung.com, omegamoon@gmail.com, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, "Jean Delvare (PC drivers core)" <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org, Marek Vasut <marek.vasut@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, April 26, 2011, Rafael J. Wysocki wrote:
> On Tuesday, April 26, 2011, Pavel Machek wrote:
...
> > Ok, see the spitz_should_wakeup() function in arch/arm/mach-pxa/* and
> > should_wakeup() usage.
> 
> OK, I will.

Well, as far as I can tell, on Zaurus this is all done within the platform
->enter() callback, so it doesn't carry out the device resume, while the
proposed $subject patch does.  For this reason, I'm not even sure if the
proposed approach is really suitable for Zaurus (the resuming and suspending
of all devices every once a while will cost quite some enery I guess).

Still, in the unlikely case it is suitable, here's my opinion.

I don't think syscore_ops is the right place to put the new "suspend
again" callback for reasons stated previously.

I also don't think dev_pm_ops is the right place to put such a callback,
because it will only be necessary on very few platforms and there's no
reason why every driver, subsystem or power domain in the kernel should care.

Moreover, the usage cases appear to be suspend-specific.

For the above reasons, the only place the "suspend again" callback may be
put into is struct platform_suspend_ops.  Then, suspend_devices_and_enter()
may be modified so that it loops between dpm_suspend_start() and
dpm_suspend_end() until that callback returns "false" and there are no
wakeup events (as indicated by pm_wakeup_pending(); but please note that
this would require suspend_enter() to indicate that pm_wakeup_pending()
returned "true" and events_check_enabled should not be reset until
we're sure that we _really_ want to resume).

Alternatively, if that's sufficient, suspend_enter() may be called in a
loop until the "suspend again" callback returns "false" and there are no
wakeup events (in the above sense).

The callback can be called "repeat" and return bool as far as I'm concerned,
but I'm not insisting on that.

MyungJoo, would that be suitable to you?

Rafael
