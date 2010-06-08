From: Mike Chan <mike@android.com>
Subject: Re: PM QoS dynamic resource manager
Date: Tue, 8 Jun 2010 11:58:33 -0700
Message-ID: <AANLkTinGBvZm870CsjocsCV1SmQ-FCCbJLtKWR1juB1Q@mail.gmail.com>
References: <alpine.DEB.2.00.1005211533530.25765@pchidamb-lnx.qualcomm.com>
	<20100525145223.GA4974@gvim.org>
	<AANLkTikLgu2c1GPE3glHLlaznOM59SVeCj2NHzDjyjZR@mail.gmail.com>
	<20100608033333.GA23066@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100608033333.GA23066@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: linux-pm@lists.linux-foundation.org, mark gross <640e9920@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 7, 2010 at 8:33 PM, mark gross <640e9920@gmail.com> wrote:
> On Mon, Jun 07, 2010 at 05:18:25PM -0700, Mike Chan wrote:
>> On Tue, May 25, 2010 at 7:52 AM, mark gross <640e9920@gmail.com> wrote:
>> > On Fri, May 21, 2010 at 03:37:39PM -0600, Chidambaram, Praveen wrote:
>> >> Hi,
>> >>
>> >> I am looking for some extensible features for PM QoS. Specifically,
>> >> dynamic runtime parameters that my architecture could define at
>> >> runtime and the drivers can make use of.
>> >>
>> >> What are the plans in this regard?
>> >
>> > we've talked about it a few times in the past.
>> >
>> > It's come down to how do we prevent platform independent code from
>> > depending on such platform independent dynamic prarams in a sane manne=
r.
>> >
>> > I've alway's pushed for coming up with more reasonable abstractions th=
at
>> > could be re-used and adding them (like the bus thing) as opposed to
>> > having drivers make / use new parrameters dynamically.
>> >
>>
>> Would it be possible to elaborate on the bus resource ideas you had? I
>> couldn't find anything in the archives. Sounds like a similar that we
>> (Android / embedded world) are having (or will) on multiple platforms
>> (omap / msm/ tegra).
>>
>> -- Mike
>
> Its been 5 months since the last time this basic discussion happened,
> and I'll do some searching for the thread later but;
>
> But the bus thing we did post a patch to get the code aurora idea
> included, but for some reason that patch didn't stick.
> http://lkml.org/lkml/2010/4/22/213 =A0(I guess the details are in the
> archives) =A0I'm happy to re-visit it.
>

Interesting patch, it looks like having a "system wide bus" doesn't
easily apply to msm and tegra platforms.
An example of some things I would like to be able to control are i2c
and memory bus.

I'm tempted to suggest adding two types memory and i2c but I'm not
sure how future proof this will be given the growing complexity in the
embedded hardware road-map.
What about the possibility of registering not one but several buses?
You could add a bus qos param, with a type enum, or bind to some
platform_driver or bus_driver

Then there's the issue of having to deal with platform specific buses,
do you add this type to pm qos with only one user? Or have some
platform bus types defined somewhere. The generic code of min / max
for resource X can be useful so everyone doesn't spin their own
resource framework in their own architecture.

-- Mike

> WRT ideas I've had, that went unsupported (well, rejected) by the domain
> experts at that time, where around throttling the GPU and / or it access
> to the memory it used.
>
> Most of the ideas where around clock throttling of buses and memory.
> Things like throttling the graphics BW to whatever memory it was using,
> or clocking down the GPU when idle. =A0My thought was a pm_qos hint could
> be handy, but I was assured that modern hardware auto-throttled and
> didn't need this. =A0So I dropped it. =A0(At that time I also thought it
> would apply to HD audio to allow better DAC throttling. =A0I also dropped
> this one too for the same reasons.)
>
> One problem was what type of units to use when talking about the qos of
> the graphics was not obvious. =A0It needs to be something meaningful to
> be portable or provide a good abstraction.
>
> Bus bandwidth in KBS is ok for somethings but its not meaningful to an
> application that wants to request a specific minimum graphics
> performance. =A0As I type this I suppose a bandwidth for blts per
> second would work for the current Android graphics but for os stacks
> that more fully use the GL engine or games running on android I don't
> think that its a meaningful metric for describing GPU performance
> throttling.
>
> what ideas do you have? =A0I would like to seem more pm_qos users.
>
> --mgross
>
>
