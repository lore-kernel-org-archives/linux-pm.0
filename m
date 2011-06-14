From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 0/3] CPU PM notifiers
Date: Tue, 14 Jun 2011 14:40:16 -0700
Message-ID: <BANLkTino9JopSw-vxHOsV3SqS+0UT1q_3w__25488.0827772014$1308087693$gmane$org@mail.gmail.com>
References: <1307925825-28566-1-git-send-email-ccross@android.com>
	<201106142300.42487.rjw@sisk.pl>
	<BANLkTi=jGKE3d0XHB1EeQ08oOqAn3hpc-w@mail.gmail.com>
	<201106142334.09362.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106142334.09362.rjw@sisk.pl>
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
Cc: Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 14, 2011 at 2:34 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, June 14, 2011, Colin Cross wrote:
>> On Tue, Jun 14, 2011 at 2:00 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Monday, June 13, 2011, Colin Cross wrote:
>> >> On Mon, Jun 13, 2011 at 11:37 AM, Rafael J. Wysocki <rjw@sisk.pl> wro=
te:
>> >> > On Monday, June 13, 2011, Colin Cross wrote:
>> >> >> This patch set tries to address Russell's concerns with platform
>> >> >> pm code calling into the driver for every block in the Cortex A9s
>> >> >> during idle, hotplug, and suspend. =A0The first patch adds cpu pm
>> >> >> notifiers that can be called by platform code, the second uses
>> >> >> the notifier to save and restore the GIC state, and the third
>> >> >> saves the VFP state.
>> >> >>
>> >> >> The notifiers are used for two types of events, CPU PM events and
>> >> >> CPU complex PM events. =A0CPU PM events are used to save and resto=
re
>> >> >> per-cpu context when a single CPU is preparing to enter or has
>> >> >> just exited a low power state. =A0For example, the VFP saves the
>> >> >> last thread context, and the GIC saves banked CPU registers.
>> >> >>
>> >> >> CPU complex events are used after all the CPUs in a power domain
>> >> >> have been prepared for the low power state. =A0The GIC uses these
>> >> >> events to save global register state.
>> >> >>
>> >> >> Platforms that call the cpu_pm APIs must select
>> >> >> CONFIG_ARCH_USES_CPU_PM
>> >> >>
>> >> >> L2 cache is not covered by this patch set, as the determination
>> >> >> of when the L2 is reset and when it is retained is
>> >> >> platform-specific, and most of the APIs necessary are already
>> >> >> present.
>> >> >>
>> >> >> =A0arch/arm/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07 ++
>> >> >> =A0arch/arm/common/gic.c =A0 =A0 =A0 =A0 | =A0212 ++++++++++++++++=
+++++++++++++++++++++++++
>> >> >> =A0arch/arm/include/asm/cpu_pm.h | =A0 54 +++++++++++
>> >> >> =A0arch/arm/kernel/Makefile =A0 =A0 =A0| =A0 =A01 +
>> >> >> =A0arch/arm/kernel/cpu_pm.c =A0 =A0 =A0| =A0181 ++++++++++++++++++=
+++++++++++++++++
>> >> >
>> >> > Is there any reason why this has to be ARM-specific? =A0There are o=
ther
>> >> > architectures where this kind of feature might make sense (SH and
>> >> > powerpc at least).
>> >>
>> >> Nothing other than there are currently no adaptations for any drivers
>> >> besides ARM, but I can move it somewhere outside ARM. =A0Any suggesti=
ons
>> >> where?
>> >
>> > Well, there is kernel/cpu.c. =A0It contains mostly CPU hotplug and PM
>> > code at the moment, so it looks like a good place.
>>
>> OK, I'll look at moving it there.
>>
>> >> > Besides, is there any overlap between this feature and the CPU hotp=
lug
>> >> > notifiers?
>> >>
>> >> I don't think so - the hotplug notifiers are used when a CPU is being
>> >> removed from the system, so no saving and restoring is necessary - the
>> >> CPU will be rebooted from scratch. =A0They are used by systems outside
>> >> the CPU that need to know that a CPU no longer exists.
>> >>
>> >> CPU PM notifiers are used when a CPU is going through reset in a way
>> >> that should be transparent to most of the system.
>> >
>> > Do I guess correctly that you mean cpuidle?
>>
>> cpuidle is the major user, but primary CPUs in suspend have to save
>> and restore the same blocks, and tend to use the same platform sleep
>> code as idle, so it's logical to use the notifiers for both. =A0On the
>> other hand, some drivers that would use cpu_pm notifiers already use
>> syscore ops to handle suspend and resume (like vfp) - maybe these
>> notifiers should only be used in cpuidle, and syscore ops added to the
>> gic driver? =A0I could also convert the notifiers to new syscore_ops -
>> cpu_idle, cpu_unidle, cpu_cluster_idle, cpu_cluster_unidle, but I
>> don't know how well that fits in to the intention for syscore.
>
> Basically, syscore_ops deal with the situation during system suspend
> when all CPUs but one have been switched off (through CPU hotplug)
> and interrupts are off on the only active CPU. =A0If there's anything
> you need to do at this point, syscore_ops is the right thing to use.
> And analogously for system resume.
>
> Moreover, for system suspend switching off the "boot" CPU (i.e. the only =
one
> that remains active through the whole sequence) should really be the last
> thing done, everything else should have been handled through syscore_ops
> before.

Yes, but what to do with idle, which generally needs to do the exact
same things as handled in some syscore ops?  Extend syscore ops, or
add the new notifier, and each driver can implement both syscore and
cpu_pm listeners (and probably call the same helper function to handle
both)?
