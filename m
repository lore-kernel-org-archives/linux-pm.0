From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: [RFC PATCH] PM: Introduce generic DVFS framework
 with device-specific OPPs
Date: Thu, 28 Apr 2011 16:34:45 +0900
Message-ID: <BANLkTikC9JJXV9rGFJhe0LAcBrBtyseEgA__1304.71574743769$1303976139$gmane$org@mail.gmail.com>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<201104261309.47629.rjw@sisk.pl>
	<BANLkTi=tBYT4NpayaoAA1+f1uaj9QyT+Yw@mail.gmail.com>
	<BANLkTi=GVZnZuXmbK54Swi8Nv9ZZGhZcNw@mail.gmail.com>
	<BANLkTin4rrniJpOheLH=JE0jq7vFpdDbrA@mail.gmail.com>
	<BANLkTi=WWASxk3Fz83324k40Lbq+ccAPeA@mail.gmail.com>
	<BANLkTikEtTDp3Cpj0D5z34wA0_G_DWwKFg@mail.gmail.com>
	<alpine.LFD.2.02.1104272104390.3323@ionos>
	<BANLkTinWD0ktYKzR_jnQSE76AuW+Z1PSLw@mail.gmail.com>
	<BANLkTi=Be3DrAUoPmgHpjhAVmN-Pi5Au7g@mail.gmail.com>
	<BANLkTiniJUgTTDh7SF8yNMeSMa+JYM21wA@mail.gmail.com>
	<BANLkTimzWyvcBV2ymxaMf=HmRhGYBboB1w@mail.gmail.com>
	<BANLkTik6L8HkJ0YjQYjh_3eEmbffyk1kRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTik6L8HkJ0YjQYjh_3eEmbffyk1kRA@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@google.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 28, 2011 at 4:06 PM, Colin Cross <ccross@google.com> wrote:
> On Wed, Apr 27, 2011 at 11:50 PM, MyungJoo Ham <myungjoo.ham@samsung.com>=
 wrote:
>> On Thu, Apr 28, 2011 at 3:44 PM, Colin Cross <ccross@google.com> wrote:
>>> On Wed, Apr 27, 2011 at 11:12 PM, MyungJoo Ham <myungjoo.ham@samsung.co=
m> wrote:
>>>> On Thu, Apr 28, 2011 at 5:48 AM, Colin Cross <ccross@google.com> wrote:
>>>>> OPP currently has opp_enable and opp_disable functions. =A0I don't
>>>>> understand why these are needed, they are only used at init time to
>>>>> determine available voltages, which could be handled by never passing
>>>>> unavailable voltages to the dvfs implementation.
>>>>
>>>> We need them in runtime.
>>>>
>>>> A device "a" may want to guarantee that a device "b" to be at least
>>>> "200MHz" or faster while it does some operations. Then, "a" will
>>>> opp_disable("b", 100MHz and others); and opp_enable("b", them) later
>>>> on. We have similar issues with multimedia blocks (MFC, Camera, FB,
>>>> GPU) and CPU/Memory Bus. Ondemand governor of CPUFREQ has some delay
>>>> on catching up a workload (1.5x the sampling rate in average, <2.0x
>>>> the sampling rate in worst cases), which may incur flickering/tearing
>>>> issues with multimedia streams. On the other hand, a general thermal
>>>> monitor or battery manager might want to limit energy usage by
>>>> disabling top performance clocks if it is too hot or the battery level
>>>> is low.
>>>
>>> That sounds like a very strange api, when what you really mean is
>>> clk_set_min_rate or clk_set_max_rate.
>>
>> Essentially, that's what needed.
>> However, with clk_set_min/max_rate, don't we need to let another
>> device to be consumer of other devices' clocks? Not just introducing a
>> device to other devices?
>
> Yes, but that's effectively what you're doing through a backwards api
> anyways. =A0The question is, for these complicated clock scenarios where
> the final frequency of a clock depends on so many factors, should that
> control go through the clock framework, or through some sort of global
> clock governor (which is where OPP would reappear).
>

In the use cases of runtime clock setting by devfreq or other devices
mentioned above, we are controlling the device's performance with the
representative clock of the device, not a specific clock among the
clocks that the device has. For a device "A" with clock "a1" and "a2",
another device "B" would not control both "a1" and "a2" directly to
get the guaranteed performance from "A". Besides, "B" should not do so
if there are specific orders, delays, and other controls for "A" to
properly change performance.

Therefore, my answer is that it would be preferred to control through
some wrapper/interface/or anything that is connected to the device of
the controlled clocks (and let the device's callback or something
control its clocks), not to control through clock framework directly.
In this version of devfreq+OPP, these are handled by the "target"
callback.


Cheers!
- MyungJoo
-- =

MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
