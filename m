From: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Wed, 21 Oct 2015 08:59:51 -0700
Message-ID: <5627B677.5090109@gmail.com>
References: <561E1378.6000906@collabora.com> <20151017065750.GA18607@kroah.com> <20151018192931.GY14956@sirena.org.uk> <20151018193757.GA9147@kroah.com> <20151018195330.GB14956@sirena.org.uk> <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
Reply-To: frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, =?UTF-8?B?VGVyamUgQmVyZ3N0csO2bQ==?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>J
List-Id: linux-pm@vger.kernel.org

On 10/19/2015 5:34 AM, Tomeu Vizoso wrote:
> On 18 October 2015 at 21:53, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> On Sun, Oct 18, 2015 at 12:37:57PM -0700, Greg Kroah-Hartman wrote:
>>> On Sun, Oct 18, 2015 at 08:29:31PM +0100, Mark Brown wrote:
>>>> On Fri, Oct 16, 2015 at 11:57:50PM -0700, Greg Kroah-Hartman wrote=
:

< snip >

> hope you don't mind I summarize the points taken instead of replying
> to the individual emails. I tried to address all the concerns that
> have been raised again in the cover letter, but I guess I did a bad
> job at explaining myself, so here's another (more in-depth) go at it.

< snip >

> 3) Regarding total boot time, I don't expect this series to make much
> of a difference because though we would save a lot of matching and
> querying for resources, that's little time compared with how long we
> wait for hardware to react during probing. Async probing is more
> likely to help with drivers that take a long time to probe.

And then in your reply to Russell's reply to your email you say:

> To be clear, I was saying that this series should NOT affect total
> boot times much.

I'm confused.  If I understood correctly, improving boot time was
the key justification for accepting this patch set.  For example,
from "[PATCH v7 0/20] On-demand device probing":

   I have a problem with the panel on my Tegra Chromebook taking longer
   than expected to be ready during boot (St=C3=A9phane Marchesin repor=
ted what
   is basically the same issue in [0]), and have looked into ordered
   probing as a better way of solving this than moving nodes around in =
the
   DT or playing with initcall levels and linking order.

   ...

   With this series I get the kernel to output to the panel in 0.5s,
   instead of 2.8s.

Alexander Holler reported improved boot times for his patch set
in August, which is another approach to ordering probes
(http://article.gmane.org/gmane.linux.drivers.devicetree/133010).
His results for 5 boards was four booted faster, one slightly
slower:

   Some numbers (5 boots on each board, without and with ordering drive=
rs),
   all times are seconds.

   Kirkwood (dockstar, armv5):

   Boot to "Freeing unused kernel memory" (includes mounting the rootfs=
),
   unordered:
   4.456016 3.937801 4.114788 4.114526 3.949480 (average 4.1145222)
   ordered:
   3.173054 3.164045 3.141418 3.480679 3.459298 (3.2836988)
   Time needed to sort (of_init_build_order()):
   0.003024
   Time needed to match drivers to the order (without calling them):
   0.002884

   Beagleboard (rev C4, armv7):

   unordered:
   6.706024 6.821746 6.696014 6.673675 6.769866 (6.733465)
   ordered:
   5.544860 5.514160 5.505859 5.527374 5.496795 (5.5178096)
   sorting: 0.021209
   matching: 0.006165

   Beaglebone Black (rev A5, armv7):

   unordered:
   3.826531 3.825662 3.826648 3.825434 3.825263 (3.8259076)
   ordered:
   2.838554 2.838322 2.839459 2.838467 2.838421 (2.8386446)
   sorting: 0.004769
   matching: 0.004860

   imx6q (armv7):

   unordered:
   3.451998 3.418864 3.446952 3.429974 3.440996 (3.4377568)
   ordered:
   3.538312 3.549019 3.538105 3.515916 3.555715 (3.5394134)
   sorting: 0.004622
   matching: 0.003868

While not as dramatic as your results, they are somewhat supportive.
What has changed your assessment that the on-demand device probing
patches will give a big boot performance increase?  Do you have
new data or analysis?

-Frank
