From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv3 0/4] coupled cpuidle state support
Date: Sat, 19 May 2012 12:34:07 +0530
Message-ID: <CAMQu2gxxmmZvMFjx-VZuLcvBgm6fxu72n+fufzx7ib6trqNg6g@mail.gmail.com>
References: <1336438662-10484-1-git-send-email-ccross@android.com>
	<4FB62611.7080908@ti.com> <201205182103.56301.rjw@sisk.pl>
	<CAMbhsRTvhP5+ow8koUsS8zbvJwyE_JMGHGasYvP58HudG8wJMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMbhsRTvhP5+ow8koUsS8zbvJwyE_JMGHGasYvP58HudG8wJMA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@android.com>
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Sat, May 19, 2012 at 1:48 AM, Colin Cross <ccross@android.com> wrote:
> On Fri, May 18, 2012 at 12:03 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> On Friday, May 18, 2012, Santosh Shilimkar wrote:
>>> On Tuesday 08 May 2012 06:27 AM, Colin Cross wrote:
>>> > On some ARM SMP SoCs (OMAP4460, Tegra 2, and probably more), the
>>> > cpus cannot be independently powered down, either due to
>>> > sequencing restrictions (on Tegra 2, cpu 0 must be the last to
>>> > power down), or due to HW bugs (on OMAP4460, a cpu powering up
>>> > will corrupt the gic state unless the other cpu runs a work
>>> > around). =A0Each cpu has a power state that it can enter without
>>> > coordinating with the other cpu (usually Wait For Interrupt, or
>>> > WFI), and one or more "coupled" power states that affect blocks
>>> > shared between the cpus (L2 cache, interrupt controller, and
>>> > sometimes the whole SoC). =A0Entering a coupled power state must
>>> > be tightly controlled on both cpus.
>>> >
>>>
>>> [...]
>>>
>>> > This series has been tested and reviewed by Santosh and Kevin
>>> > for OMAP4, which has a cpuidle series ready for 3.5, and Tegra
>>> > and Exynos5 patches are in progress. =A0I think this is ready to
>>> > go in. =A0Lean, are you maintaining a cpuidle tree for linux-next?
>>> > If not, I can publish a tree for linux-next, or this could go in
>>> > through Arnd's tree.
>>>
>>> I haven't seen any response so far on who is lining up this
>>> series for 3.5 ? Not sure if it made it to linux-next either.
>>
>> That should be Len, but he's been silent recently.
>>
>> How urgent is it?
>
> Len silently picked up the last version. =A0I just posted two fixes to
> it, hopefully he'll pick up those too.
Great !!
I will pull Len's tree and rebase OMAP patches against it.

Regards
Santosh
