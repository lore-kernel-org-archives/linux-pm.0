From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 00/16] ARM: shmobile: Add CPG/MSTP Clock Domain
Date: Wed, 5 Aug 2015 08:58:29 +0200
Message-ID: <CAMuHMdUFjgVWBc0hdm_L0Z0Os1OT8H4NzwQyQTGZQt8Bu7-9PQ@mail.gmail.com>
References: <1438691297-29235-1-git-send-email-geert+renesas@glider.be>
	<20150804134824.GA10194@verge.net.au>
	<20150805005543.GC20726@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150805005543.GC20726@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-clk@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Simon,

On Wed, Aug 5, 2015 at 2:55 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Aug 04, 2015 at 10:48:28PM +0900, Simon Horman wrote:
>> I have tentatively queued this up in its own branch,
>> cpg-mstp-clock-domain-for-v4.3.
>
> Where possible I prefer not to apply non-DTS/DTSI patches on top of
> DTS/DTSI patches, I believe this is in keeping with how the ARM SoC
> maintainers like things handled.  With this in mind I have shuffled things
> around a little, the result is:
>
> 1. The following are (still) queued up for v4.3 in their own
>    cpg-mstp-clock-domain-for-v4.3 branch:
>
>    clk: shmobile: Add CPG/MSTP Clock Domain support
>    clk: shmobile: r8a7778: Add CPG/MSTP Clock Domain support
>    clk: shmobile: r8a7779: Add CPG/MSTP Clock Domain support
>    clk: shmobile: rcar-gen2: Add CPG/MSTP Clock Domain support
>    clk: shmobile: rz: Add CPG/MSTP Clock Domain support
>    ARM: shmobile: r7s72100 dtsi: Add CPG/MSTP Clock Domain
>    ARM: shmobile: r8a7778 dtsi: Add CPG/MSTP Clock Domain
>    ARM: shmobile: r8a7779 dtsi: Add CPG/MSTP Clock Domain
>    ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain
>    ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain
>    ARM: shmobile: r8a7793 dtsi: Add CPG/MSTP Clock Domain
>    ARM: shmobile: r8a7794 dtsi: Add CPG/MSTP Clock Domain

OK.

> 2. The following are now queued up for v4.3 in a separate
>    sh-drivers-for-v4.3 branch. That branch is on top of the
>    cpg-mstp-clock-domain-for-v4.3 branch and I intend to send it directly
>    to Linus if/when a v4.3-rc has been released with the patches
>    listed in 1. present.
>
>    drivers: sh: Disable legacy default PM Domain on emev2
>    drivers: sh: Disable PM runtime for multi-platform ARM with genpd

OK

> 3. I have deferred the remaining two patches, listed below, for v4.4.
>    they currently reside in cpg-mstp-clock-domain-for-v4.4. That
>    branch is based on the sh-drivers-for-v4.3 branch.
>
>    clk: shmobile: mstp: Consider "zb_clk" suitable for power management
>    ARM: shmobile: R-Mobile: Use CPG/MSTP Clock Domain attach/detach helpers
>
> This means that the last two patches will disappear from next until
> after v4.3-rc1 is released but they, along with all the other patches,
> will be present in the renesas devel branch.

OK.

Note that as the last two depend on patch 1 only, you could e.g. queue
them up in group 1, between the clk and dtsi patches.
But it's up to you to reconsider.
I'm happy as-is, as the last two patches are just a code duplication clean up.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
