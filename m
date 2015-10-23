From: Tim Bird <tim.bird-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Fri, 23 Oct 2015 08:45:06 -0700
Message-ID: <562A5602.7000208@sonymobile.com>
References: <20151018192931.GY14956@sirena.org.uk>
 <20151018193757.GA9147@kroah.com> <20151018195330.GB14956@sirena.org.uk>
 <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
 <5627B677.5090109@gmail.com> <20151021162758.GP32054@sirena.org.uk>
 <5627D6E0.5020708@gmail.com>
 <CAL_Jsq+FPtCuBnte2HTgbdpNYM=v_kLaCRcOC1kMaCQwVC=5Kw@mail.gmail.com>
 <562808AF.7090406@gmail.com>
 <CAAObsKAkyjdvNOS3+nuT0N9sudUFLsZXFtcm6Y038p+HSdsZsg@mail.gmail.com>
 <20151022144405.GC21861@kroah.com> <562930AB.1070203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <562930AB.1070203-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, =?UTF-8?Q?Terje_Bergstr=c3=b6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Jingoo
List-Id: linux-pm@vger.kernel.org

On 10/22/2015 11:53 AM, Frank Rowand wrote:
> On 10/22/2015 7:44 AM, Greg Kroah-Hartman wrote:
>> <oops, sent too early...>
>>
>> On Thu, Oct 22, 2015 at 11:05:11AM +0200, Tomeu Vizoso wrote:
>>> But that's moot currently because Greg believes that the time spent
>>> probing devices at boot time could be reduced enough so that the order
>>> in which devices are probed becomes irrelevant. IME that would have to
>>> be under 200ms so that the user doesn't notice and that's unicorn-far
>>> from any bootlog I have ever seen.
>>
>> But as no one has actually produced a bootlog, how do you know that?
>> Where exactly is your time being spent?  What driver is causing long
>> delays?  Why is the long-delay-drivers not being done in their own
>> thread?  And most importantly, why are you ignoring the work that people
>> did back in 2008 to solve the issue on other hardware platforms?
>>
>>> Given that downstreams are already carrying as many hacks as they
>>> could think of to speed total boot up, I think this is effectively
>>> telling them to go away.
>>
>> No I'm not, I'm asking for real data, not hand-wavy-this-is-going-to
>> solve-the-random-issue-i'm-having type patch by putting random calls in
>> semi-random subsystems all over the kernel.
>>
>> And when I ask for real data, you respond with the fact that you aren't
>> trying to speed up boot time here at all, so what am I supposed to think
> 
> I also had the understanding that this patch series was about improving
> boot time.  But I was kindly corrected that the behavior change was
> getting the panel displaying stuff at an earlier point in the boot sequence,
> _not_ completing the entire boot faster. 
> 
> The claim for the current series, in patch 0 in v7 is:
> 
>    With this series I get the kernel to output to the panel in 0.5s,
>    instead of 2.8s.

It's very common to want to get the display up before the
rest of the system.  So wanting to accelerate one part of the boot
at the expense to the rest of the system is a valid use case.
Deferred initcalls, which is out of tree primarily because it requires
the type of manual tweaking that Tomeu describes, specifically
addressed this issue.
> 
> Just to get side-tracked, one other approach at ordering to reduce
> deferrals reported a modest boot time reduction for four boards and a
> very slight boot time increase for one other board.) The report of boot
> times with that approach was in:
> 
>   http://article.gmane.org/gmane.linux.drivers.devicetree/133010
> 
> from Alexander Holler.
> 
> I have not searched further to see if there is more data of boot time
> reductions from any of the other attempts to change driver binding
> order to move dependencies before use of a resource.  But whether
> there is a performance improvement or not, there continues to be
> a stream of developers creatively impacting the binding order for
> their specific driver(s) or board.  So it seems that maybe there
> is an underlying problem, or we don't have adequate documentation
> explaining how to avoid a need to order bindings, or the
> documentation exists and is not being read.

Well, I have probe order problems unrelated to boot time, that
I solved by resorting to putting stuff into modules and loading
them post-boot.  So I'd be interested in easy solutions to managing
boot order in mainline.

> 
> I have been defaulting to the position that has been asserted by
> the device tree maintainters, that probe deferrals work just fine
> for at least the majority of cases (and is the message I have been
> sharing in my conference presentations about device tree).  But I
> suspect that there is at least a small minority of cases that are not
> well served by probe deferral.  (Not to be read as an endorsement of
> this specific patch series, just a generic observation.)

I've been worried about DT overhead adding to boot time for a while.
And IMHO probe deferral is just about the lamest way to solve boot
order dependencies I can imagine, from a computer science perspective.
(Well, there's a certain elegance to it, but it's a stupid "make
everything re-doable, back up and start over, time-wasting" elegance.)

However, when Android takes 35 seconds to boot, and most people almost never
cold-boot your product, a few seconds of kernel time-wasting on
cold-boot seem less important. Alas, when I started working on mobile
phones I stopped caring much about boot time.

Thus, I've never worried about the DT overhead enough to actually
measure it, as requested by Greg.  So I'll just shut up now. :-)
 -- Tim
  
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
