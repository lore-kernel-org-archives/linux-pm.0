From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: rcar: Add support for R8A7795 SoC
Date: Tue, 10 May 2016 13:49:07 +0530
Message-ID: <20160510081907.GB3016@vireshk-i7>
References: <1462372543-31835-1-git-send-email-geert+renesas@glider.be>
 <5731664D.1030909@rvc.renesas.com>
 <573169CD.8050607@rvc.renesas.com>
 <57316A4E.7040100@rvc.renesas.com>
 <20160510050710.GC2790@vireshk-i7>
 <CAMuHMdWYrf4oZU-8YZ-v-MxznUwJZsqLcbRhiMK=CB2+UoR6uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWYrf4oZU-8YZ-v-MxznUwJZsqLcbRhiMK=CB2+UoR6uw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Toru Oishi <toru.oishi.zj@rvc.renesas.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10-05-16, 10:17, Geert Uytterhoeven wrote:
> Hi Viresh,
> 
> On Tue, May 10, 2016 at 7:07 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 10-05-16, 11:57, Khiem Nguyen wrote:
> >> After the commit "a399dc9fc50 cpufreq: shmobile: Use generic platdev
> >> driver", will use cpufreq-dt-platdev driver to enable cpufreq-dt support.
> >> Hence, follow the implementation to support new R8A7795 SoC.
> >>
> >> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
> >> ---
> >>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Quoting Viresh when this file was introduced:
> | This is going to be done once per boot and this shouldn't hurt. And for new
> | platforms we may do things differently as they are going to use
> opp-v2 bindings.
> 
> As r8a7795/r8a7796 are not arm32 "shmobile", but arm64, perhaps we should
> use this new "opp-v2" binding instead? Has it been finalized?

Yeah, that would be preferred.

-- 
viresh
