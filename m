From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [EXT] Re: [PATCH v2] clk: qoriq: Add clockgen support for lx2160a
Date: Thu, 25 Apr 2019 12:29:13 +0200
Message-ID: <CAJZ5v0jQFXpHmpxSYSUxwGkMV98g3S+zV1oh1RYxvkebmzT29Q@mail.gmail.com>
References: <1556185703-26243-1-git-send-email-vabhav.sharma@nxp.com>
 <CAJZ5v0iwrjonKpA3Skkhkg3g5Pp9Qzx0v2GBYKdv7eM_jL4p8g@mail.gmail.com> <VI1PR04MB43336A0C62B956CA29A7E621F33D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB43336A0C62B956CA29A7E621F33D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Tang <andy.tang@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Vabhav Sharma <vabhav.sharma@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sboyd@kernel.org" <sboyd@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 25, 2019 at 12:15 PM Andy Tang <andy.tang@nxp.com> wrote:
>
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: 2019年4月25日 18:04
> > To: Vabhav Sharma <vabhav.sharma@nxp.com>
> > Cc: linux-kernel@vger.kernel.org; linux-clk@vger.kernel.org;
> > linux-pm@vger.kernel.org; sboyd@kernel.org; mturquette@baylibre.com;
> > rjw@rjwysocki.net; viresh.kumar@linaro.org; Yogesh Narayan Gaur
> > <yogeshnarayan.gaur@nxp.com>; Andy Tang <andy.tang@nxp.com>
> > Subject: [EXT] Re: [PATCH v2] clk: qoriq: Add clockgen support for lx2160a
> >
> > Caution: EXT Email
> >
> > On Thu, Apr 25, 2019 at 11:48 AM Vabhav Sharma <vabhav.sharma@nxp.com>
> > wrote:
> > >
> > > From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > >
> > > Add clockgen support for lx2160a.
> > > Added entry for compat 'fsl,lx2160a-clockgen'.
> >
> > Well, if I'm expected to apply this, the above is a bit terse.
> >
> > It looks like the patch makes the qoriq-cpufreq driver handle some new
> > hardware, but the changelog doesn't say much about that.
> >
> > I'm guessing that the clockgen support added here makes it possible for
> > qoriq-cpufreq to handle this chip, is that correct?
> Yes, your guess is correct. The cpufreq feature is based on clock driver.
> It should had been separated to two patches and reduced the confuse.
> Do I need to update the commit message or you just take it?

Please update the commit message.

Thanks!
