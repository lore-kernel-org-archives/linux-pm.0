From: Salman Qazi <sqazi@google.com>
Subject: Re: RFC: A proposal for power capping through forced
	idle in the Linux Kernel
Date: Tue, 15 Dec 2009 12:50:24 -0800
Message-ID: <4352991a0912151250o38ec0d19id0518e4e1313654f__30936.2291278832$1260910391$gmane$org@mail.gmail.com>
References: <4352991a0912141511k7f9b8b79y767c693a4ff3bc2b@mail.gmail.com>
	<20091214161922.6f252492@infradead.org>
	<4352991a0912141636t35a96c14o5fd4b9e152e6e681@mail.gmail.com>
	<20091215102909.GA878@dirshya.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091215102909.GA878@dirshya.in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: svaidy@linux.vnet.ibm.com
Cc: Michael Rubin <mrubin@google.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Taliver Heath <taliver@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 15, 2009 at 2:29 AM, Vaidyanathan Srinivasan
<svaidy@linux.vnet.ibm.com> wrote:
> * Salman Qazi <sqazi@google.com> [2009-12-14 16:36:20]:
>
>> On Mon, Dec 14, 2009 at 4:19 PM, Arjan van de Ven <arjan@infradead.org> =
wrote:
>> > On Mon, 14 Dec 2009 15:11:47 -0800
>> > Salman Qazi <sqazi@google.com> wrote:
>> >
>> >
>> > I like the general idea, I have one request (that I didn't see quite in
>> > your explanation): Please make sure that all cpus in the system do
>> > their idle injection at the same time, so that memory can go into power
>> > saving mode as well during this time etc etc...
>> >
>
> The value of the overall idea is well understood but the
> implementation and benefits in terms of power savings was the major
> point of discussion earlier.
>
>> With the current interface, the forced idle percentages on the CPUs
>> are controlled independently. =A0There's a trade-off here. =A0If we inje=
ct
>> idle cycles on all the CPU at the same time, our machine
>> responsiveness also degrades: essentially every CPU becomes equally
>> bad for an interactive task to run on. =A0Our aim at the moment is to
>> try to concentrate the idle cycles on a small set of CPUs, to strive
>> to leave some CPUs where interactive tasks can run unhindered. =A0But,
>> given a different workload and goals the correct policy may be
>> different.
>>
>> Simultaneously idling multiple "cores" becomes necessary in the SMT
>> case: as there is no point in idling a single thread, while the other
>> thread is running full tilt. =A0So, in such a case it is necessary to
>> idle all the threads making up the physical core. =A0This feature has
>> not been implemented yet.
>>
>> I think the best approach may be to provide a way to specify the
>> policy from the user space. =A0Basically let the user decide at what
>> level of CPU hierarchy the forced idle percentages are specified.
>> Then, in the levels below, we simply inject at the same time.
>
> Synchronising the idle times across multiple cores and also selecting
> sibling threads belonging to the same core is important. =A0The current
> ACPI forced idle driver can inject idle time but not synchronized
> across multiple cores.
>
> Allowing the scheduler load balancer to avoid using a part of the
> sched domain tree will allow easy grouping of sibling threads and
> sibling cores if that saves more power.
>
> However as Arjan mentioned, new architectures have significant power
> savings at full system idle where memory power is reduced. =A0Injecting
> idle time in any of the core will actually increase the utilisation on
> the other cores (unless the system is full loaded) and reduce the full
> system idle time opportunity. =A0Basically injecting idle time on some
> of the cores in the system goes against the race-to-idle policy
> thereby decreasing overall system operating efficiency.
>
> Can you please clarify the following questions:
>
> * What is the typical duration of idle time injected?
> =A0 =A0 =A0 =A0- 10s of milli seconds? =A0CPUs are expected to goto lowest
> =A0 =A0 =A0 =A0 =A0power idle state within this time?

This depends on the specific user.  I can only speak for our Google's
intentions for this.  The duration of the injected time would
typically be single digit milliseconds.  We don't need the CPUs to go
into the lowest power idle state for our purposes.  We care more about
the predictable component of the power savings, as this is the
component that we can use elsewhere.  Given that there may be
interrupts that prevent us from reaching the lowest power idle state,
we should really not rely on that in our power models.  Therefore,
while it is great from an energy savings point of view to reach the
lowest power idle state, it doesn't help us from a power shifting
point of view.

>
> * You mentioned that natural idle time in the system is taken into
> =A0account before injecting forced idle time, which is a good feature
> =A0to have.
> =A0 =A0 =A0 =A0- In most workloads, as the utilisation drops, all the cpus
> =A0 =A0 =A0 =A0 =A0have similar idle times. =A0This is favourable for exp=
loiting
> =A0 =A0 =A0 =A0 =A0memory power saving.
> =A0 =A0 =A0 =A0- Now when more idle time need to be inserted, is it
> =A0 =A0 =A0 =A0 =A0uniformly spread across all CPUs?

The settings at the moment are per-CPU and so is enforcement.  The
current implementation does not do any CPU cross talk.  Each CPU
simply maintains its own minimum forced idle percentage and these
cycles are not horse traded across CPUs.  So, the answer to your
question in the general case is no.  The user may even choose to not
set any kind of a cap on some subset of CPUs.

>
> Suggestions:
>
> * Can cgroup hardlimits help here to inject idle times
> =A0http://lkml.org/lkml/2009/11/17/191
>
> =A0The problem of distributing idle time equally across CPUs and
> =A0relating sibling threads is still and issue, but can be worked out.
> =A0As of now hardlimits can distribute idle time across CPUs thereby
> =A0enabling full system idle.

Sibling threads is a major issue here.  If all of the idle cycles are
not injected simultaneously on both threads, then the resulting power
savings will not match the expected power savings.  Since we care
about predictability of the power savings, such savings would not help
us at all.  So, having a heuristic that improves the probability of
the right thing happening is not sufficient.  Hard assurances are
required.

Aside from that, our current implementation discriminates between
batch and interactive tasks.  In the first phase called "eager
injection", we let the interactive tasks run but prevent batch tasks
from running (preferring to idle the machine instead).  This allows us
to reduce the impact on interactive tasks by preventing batch tasks
from forcing the interactive tasks into the fully idle part of the
time period.  Thus, interactive tasks should not incur any additional
latency due to the behavior of the batch tasks.  If we are going to
use cgroup hardlimits, an equivalent feature would need to be added.
Basically, have an initial "protected period" for interactive tasks
where we do not let batch tasks run.



>
> --Vaidy
>
