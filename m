From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 0/3] CPU PM notifiers
Date: Mon, 13 Jun 2011 11:55:40 -0700
Message-ID: <BANLkTi=zTVPkgDO1xXPhypn5Fz6c0PTp79Wq2a6s4jrz3WrJyQ__11743.0420745679$1307991422$gmane$org@mail.gmail.com>
References: <1307925825-28566-1-git-send-email-ccross@android.com>
	<201106132037.49009.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106132037.49009.rjw@sisk.pl>
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

On Mon, Jun 13, 2011 at 11:37 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, June 13, 2011, Colin Cross wrote:
>> This patch set tries to address Russell's concerns with platform
>> pm code calling into the driver for every block in the Cortex A9s
>> during idle, hotplug, and suspend. =A0The first patch adds cpu pm
>> notifiers that can be called by platform code, the second uses
>> the notifier to save and restore the GIC state, and the third
>> saves the VFP state.
>>
>> The notifiers are used for two types of events, CPU PM events and
>> CPU complex PM events. =A0CPU PM events are used to save and restore
>> per-cpu context when a single CPU is preparing to enter or has
>> just exited a low power state. =A0For example, the VFP saves the
>> last thread context, and the GIC saves banked CPU registers.
>>
>> CPU complex events are used after all the CPUs in a power domain
>> have been prepared for the low power state. =A0The GIC uses these
>> events to save global register state.
>>
>> Platforms that call the cpu_pm APIs must select
>> CONFIG_ARCH_USES_CPU_PM
>>
>> L2 cache is not covered by this patch set, as the determination
>> of when the L2 is reset and when it is retained is
>> platform-specific, and most of the APIs necessary are already
>> present.
>>
>> =A0arch/arm/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07 ++
>> =A0arch/arm/common/gic.c =A0 =A0 =A0 =A0 | =A0212 ++++++++++++++++++++++=
+++++++++++++++++++
>> =A0arch/arm/include/asm/cpu_pm.h | =A0 54 +++++++++++
>> =A0arch/arm/kernel/Makefile =A0 =A0 =A0| =A0 =A01 +
>> =A0arch/arm/kernel/cpu_pm.c =A0 =A0 =A0| =A0181 ++++++++++++++++++++++++=
+++++++++++
>
> Is there any reason why this has to be ARM-specific? =A0There are other
> architectures where this kind of feature might make sense (SH and
> powerpc at least).

Nothing other than there are currently no adaptations for any drivers
besides ARM, but I can move it somewhere outside ARM.  Any suggestions
where?

> Besides, is there any overlap between this feature and the CPU hotplug
> notifiers?

I don't think so - the hotplug notifiers are used when a CPU is being
removed from the system, so no saving and restoring is necessary - the
CPU will be rebooted from scratch.  They are used by systems outside
the CPU that need to know that a CPU no longer exists.

CPU PM notifiers are used when a CPU is going through reset in a way
that should be transparent to most of the system.  Only drivers within
the CPU itself need a notification.  Note that both ARM drivers I
modified did not have a register_cpu_notifier call.

> Rafael
>
