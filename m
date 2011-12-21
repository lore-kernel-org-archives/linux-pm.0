From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 0/3] coupled cpuidle state support
Date: Wed, 21 Dec 2011 01:40:54 -0800
Message-ID: <CAMbhsRRP7s9xsHqxhb=iMfHAJFcqAea-6CDORZS34RCPNo+UWw__23269.0053912394$1324460467$gmane$org@mail.gmail.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
	<4EF1A0B4.5080307@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4EF1A0B4.5080307@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-tegra@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 21, 2011 at 1:02 AM, Arjan van de Ven <arjan@linux.intel.com> w=
rote:
> On 12/21/2011 1:09 AM, Colin Cross wrote:
>> On some ARM SMP SoCs (OMAP4460, Tegra 2, and probably more), the
>> cpus cannot be independently powered down, either due to
>> sequencing restrictions (on Tegra 2, cpu 0 must be the last to
>> power down), or due to HW bugs (on OMAP4460, a cpu powering up
>> will corrupt the gic state unless the other cpu runs a work
>> around). =A0Each cpu has a power state that it can enter without
>> coordinating with the other cpu (usually Wait For Interrupt, or
>> WFI), and one or more "coupled" power states that affect blocks
>> shared between the cpus (L2 cache, interrupt controller, and
>> sometimes the whole SoC). =A0Entering a coupled power state must
>> be tightly controlled on both cpus.
>>
>> The easiest solution to implementing coupled cpu power states is
>> to hotplug all but one cpu whenever possible, usually using a
>> cpufreq governor that looks at cpu load to determine when to
>> enable the secondary cpus. =A0This causes problems, as hotplug is an
>> expensive operation, so the number of hotplug transitions must be
>> minimized, leading to very slow response to loads, often on the
>> order of seconds.
>>
>> This patch series implements an alternative solution, where each
>> cpu will wait in the WFI state until all cpus are ready to enter
>> a coupled state, at which point the coupled state function will
>> be called on all cpus at approximately the same time.
>>
>> Once all cpus are ready to enter idle, they are woken by an smp
>> cross call. =A0At this point, there is a chance that one of the
>> cpus will find work to do, and choose not to enter suspend. =A0A
>> final pass is needed to guarantee that all cpus will call the
>> power state enter function at the same time. =A0During this pass,
>> each cpu will increment the ready counter, and continue once the
>> ready counter matches the number of online coupled cpus. =A0If any
>> cpu exits idle, the other cpus will decrement their counter and
>> retry.
>
> this smells fundamentally racey to me; you can get an interrupt one
> cycle after you think you're done, but before the last guy enters WFI...
>
> how do you solve that issue ?

All the cpus have interrupts off when they increment the counter, so
they cannot receive an interrupt.  If an interrupt is pending on one
of those cpus, it will be handled later when WFI aborts due to the
pending interrupt.
