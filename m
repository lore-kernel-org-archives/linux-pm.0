From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v9 01/15] ARM: Add Krait L2 register accessor functions
Date: Wed, 30 May 2018 08:55:10 -0700
Message-ID: <152769571081.144038.4314499217001219157@swboyd.mtv.corp.google.com>
References: <1520347148-27852-1-git-send-email-sricharan@codeaurora.org>
 <1520347148-27852-2-git-send-email-sricharan@codeaurora.org>
 <20180524173926.GC14924@minitux>
 <664089d4-b30d-99bb-2021-12128b2895ba@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <664089d4-b30d-99bb-2021-12128b2895ba@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>, Sricharan R <sricharan@codeaurora.org>
Cc: robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk
List-Id: linux-pm@vger.kernel.org

Quoting Sricharan R (2018-05-24 22:40:11)
> Hi Bjorn,
> =

> On 5/24/2018 11:09 PM, Bjorn Andersson wrote:
> > On Tue 06 Mar 06:38 PST 2018, Sricharan R wrote:
> > =

> >> From: Stephen Boyd <sboyd@codeaurora.org>
> >>
> >> Krait CPUs have a handful of L2 cache controller registers that
> >> live behind a cp15 based indirection register. First you program
> >> the indirection register (l2cpselr) to point the L2 'window'
> >> register (l2cpdr) at what you want to read/write.  Then you
> >> read/write the 'window' register to do what you want. The
> >> l2cpselr register is not banked per-cpu so we must lock around
> >> accesses to it to prevent other CPUs from re-pointing l2cpdr
> >> underneath us.
> >>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Russell King <linux@arm.linux.org.uk>
> >> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > =

> > This should have your signed-off-by here as well.
> > =

> =

>  ok.
> =

> > Apart from that:
> > =

> > Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > =

> =


Will these patches come around again? I'll do a quick sweep on them
today but I expect them to be resent.
