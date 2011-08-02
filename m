From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 0/3] DEVFREQ,
	DVFS framework for non-CPU devices
Date: Tue, 02 Aug 2011 15:02:01 -0700
Message-ID: <87livba2w6.fsf@ti.com>
References: <1310717510-19002-1-git-send-email-myungjoo.ham@samsung.com>
	<201107290010.53788.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107290010.53788.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Fri, 29 Jul 2011 00:10:53 +0200")
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
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Friday, July 15, 2011, MyungJoo Ham wrote:
>> For a usage example, please look at
>> http://git.infradead.org/users/kmpark/linux-2.6-samsung/shortlog/refs/heads/devfreq
>> 
>> In the above git tree, DVFS (dynamic voltage and frequency scaling) mechanism
>> is applied to the memory bus of Exynos4210 for Exynos4210-NURI boards.
>> In the example, the LPDDR2 DRAM frequency changes between 133, 266, and 400MHz
>> and other related clocks simply follow the determined DDR RAM clock.
>> 
>> The DEVFREQ driver for Exynos4210 memory bus is at
>> /arch/arm/mach-exynos4/devfreq_bus.c in the git tree.
>> 
>> MyungJoo Ham (3):
>>   PM: Introduce DEVFREQ: generic DVFS framework with device-specific
>>     OPPs
>>   PM / DEVFREQ: add example governors
>>   PM / DEVFREQ: add sysfs interface (including user tickling)
>
> OK, I'm going to take the patches for 3.2.

Sorry for being late to the discussion, but personally I don't think
this should be merged for v3.2.

First, I think the governor part of this series is basically fine, and
can see some cases where it would be useful, but as Mike has pointed
out, there is still a majority of devices for which a governor like this
would be overkill.

My main problem is with the QoS aspects.  There is significant overlap
between this approach and the per-device PM QoS approach currently being
proposed by Jean Pihet, and I think any sort of per-device DVFS should
be built on top of a more generic per-device QoS layer (such as Jean's.)

This series currently provides a *very* basic QoS mechanism (e.g. fixed
duration frequency constraint) in the form of "tickle", which BTW I seem
to having a hard time understanding (more on that below...)

More importantly though, this series also introduces a sysfs layer for
doing its QoS-like stuff, so adding this and then adding a more generic
per-device QoS is asking for confusion about how userspace is to do QoS.
And adding a sysfs interface may be turn out to be difficult to remove.

Basically, without a more general constraints mechanism in place, I
don't see how this can be generally useful since there are too many
assumptions made with the current "tickle" approach, and as Mike has
pointed out, it cannot cleanly handle cases where there might be
multiple DVFS-related constraints on a given device.

OK, back to "tickle"...  I haven't yet fully understood how that
interface is intended to be used, or who the potential users might be
and it is not documented in the code or changelog.  I also didn't see
any users of that API (except the sysfs code.)

IIUC, tickle is just basically a way to set a frequency constraint on a
device for a fixed duration.  However, if tickle has been requested, any
OPP change will also force a change to the highest performance OPP
temporarily before changing to the target OPP.

Maybe I'm not understanding the usage of it fully, but that seems like
hard-coding policy into the framework that might not be appropriate.
For example, what if there are other devices with constraints such that
they cannot currently scale frequency/voltage?

Mabye MyungJoo can explain in more detail the usecases for tickle?

Thanks,

Kevin
