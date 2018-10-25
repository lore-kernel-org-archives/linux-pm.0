From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Date: Thu, 25 Oct 2018 15:43:39 -0700
Message-ID: <20181025224339.GB22824@google.com>
References: <1539257761-23023-1-git-send-email-tdas@codeaurora.org>
 <1539257761-23023-2-git-send-email-tdas@codeaurora.org>
 <CAP245DV4yK2u2tS_Jjgb1PBx+qkXPXBOs3w4THNDaBEw7WGDLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP245DV4yK2u2tS_Jjgb1PBx+qkXPXBOs3w4THNDaBEw7WGDLg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Taniya Das <tdas@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <skannan@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Oct 23, 2018 at 05:23:34PM +0530, Amit Kucheria wrote:
> Hi Taniya,
> 
> Both the patches are missing v9 in their subject line - this threw off
> patchwork when trying to download the patches.
> 
> On Thu, Oct 11, 2018 at 5:06 PM Taniya Das <tdas@codeaurora.org> wrote:
> >
> > Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> > SoCs. This is required for managing the cpu frequency transitions which are
> > controlled by the hardware engine.
> 
> I tested these patches on the sdm845-mtp against 4.19 and found that
> the frequency gets stuck at the highest opp (the boost frequency)
> after running a couple of 'yes > /dev/null &' instances. Have you
> tested these against a mainline kernel?
> 
> See cpufreq statistics below:
> 
> linaro-test [rc=0]# cat policy?/scaling_cur_freq
> 300000
> 2803200
> 
> linaro-test [rc=0]# cat policy?/stats/time_in_state
> 300000 100840
> 403200 388
> 480000 71
> 576000 54
> 652800 22
> 748800 11
> 825600 5
> 902400 5
> 979200 9
> 1056000 3
> 1132800 2
> 1228800 5
> 1324800 8
> 1420800 2
> 1516800 1
> 1612800 0
> 1689600 0
> 1766400 392
> 825600 22048
> 902400 21
> 979200 4
> 1056000 15
> 1209600 6
> 1286400 0
> 1363200 1
> 1459200 0
> 1536000 0
> 1612800 1
> 1689600 0
> 1766400 0
> 1843200 2
> 1920000 2
> 1996800 0
> 2092800 0
> 2169600 0
> 2246400 0
> 2323200 0
> 2400000 0
> 2476800 0
> 2553600 0
> 2649600 0
> 2707200 0
> 2764800 0
> 2784000 0
> 2803200 79718

I can repro this on SDM845 with a v4.19 kernel.

Since the little cores don't have a boost frequency I think maxing out
can be expected with a high workload and no thermal throttling.
However the big cores have a boost frequency (2.803 MHz), so the
driver shouldn't be stuck at it. Though in practice I also wonder if
the ~1% 'boost' makes a big difference in terms of performance or CPU
overload ...

Cheers

Matthias
