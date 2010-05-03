From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 03 May 2010 16:37:22 -0700
Message-ID: <87sk68r1zh.fsf__20620.036047376$1272929993$gmane$org@deeprootsystems.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<87wrvl5479.fsf@deeprootsystems.com>
	<20100503180741.GB2098@rakim.wolfsonmicro.main>
	<201005032318.35383.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Monday 03 May 2010, Mark Brown wrote:
>> On Mon, May 03, 2010 at 09:40:26AM -0700, Kevin Hilman wrote:
>> 
>> > At least from the kernel perspective, both suspend blockers and
>> > runtime PM have the same goal.  Given that, which framework should the
>> > driver writer target?  Both?  Seems like duplicate effort.  Using
>> > suspend blockers assumes the system is in opportunitstic suspend mode
>> > and (at least in the keypad example given) assumes a suspend-blocker
>> > aware userspace (Android.) Without both, targeted power savings will
>> > not be acheived.
>> 
>> The other concern here is that for many mobile systems the actual
>> semantic intended by "suspend" as it's currently used is more runtime PM
>> like than full suspend - the classic example of this is that when
>> suspending while on a call in a phone you don't want to suspend the
>> modem or audio CODEC, you want to leave them running.  If you use a full
>> system suspend then the drivers for affected components have to play
>> guessing games (or add currently non-standard knobs for apps to twiddle)
>> to decide if the system intends them to actually implement the suspend
>> or not but with runtime PM it all falls out very naturally without any
>> effort on the part of the driver.
>> 
>> > To me, runtime PM is a generic and flexible approach that can be used
>> > with any userspace.  Driver writers should not have to care whether
>> > the system is in "opportunistic" mode or about whether userspace is
>> > suspend blocker capable.  They should only have to think about when
>> > the device is (or should be) idle.
>> 
>> I fully agree with this.  We do need to ensure that a runtime PM based
>> system can suspend the CPU core and RAM as well as system suspend can
>> but that seems doable.
>
> I _think_ it would be hard at least.  On ACPI-based systems it's not doable at
> all AFAICS.

Please forgive the ignorance of ACPI (in embedded, we thankfully live
in magical world without ACPI) but doesn't that already happen with
CPUidle and C-states?  I think of CPUidle as basically runtime PM for
the CPU.  IOW, runtime PM manages the devices, CPUidle manages the CPU
(via C-states), resulting in dynaimc PM for the entire system.  What
am I missing?

> However, the real question is whether or not the opportunistic suspend feature
> is worth adding to the kernel as such and I think it is.
>
> To me, it doesn't duplicate the runtime PM framework which is aimed at the power
> management of individual devices rather than the system as a whole.

>From the use cases presented, the *usage* of suspend blockers is aimed
at power management of individual devices or subsystems, just like
usage of runtime PM.

So I still see a large duplication in the usage and the goals of both
frameworks.  The goal of both is to always enter lowest-power state
except

 - if there's activity (runtime PM for devices, CPUidle for CPU)
 - if there's a suspend blocker (opportunitic suspend)

In addition, it will likely cause duplicate work to be done in
drivers.  Presumably, PM aware drivers will want to know if the system
is in opportunistic mode.  For example, for many drivers, doing
runtime PM may not be worth the effort if the system is in
opportunistic mode.

This last point is especially troubling.  I don't find it a comforting
path to go down if the drivers have to start caring about which PM
policy is currently in use.

Kevin
