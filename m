From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: qoriq: Add ls1028a chip support
Date: Wed, 01 May 2019 12:41:08 +0200
Message-ID: <2243345.ebHGfCmnM5@kreacher>
References: <20190424023223.29614-1-andy.tang@nxp.com> <20190424090252.7cmwzxf4t5lwjat6@vireshk-i7> <CAJZ5v0jOOKW92X8iGPZD8Dfye4K9seXgiYaTLURby9Y3BbMYpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jOOKW92X8iGPZD8Dfye4K9seXgiYaTLURby9Y3BbMYpg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Andy Tang <andy.tang@nxp.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, April 24, 2019 11:25:07 AM CEST Rafael J. Wysocki wrote:
> On Wed, Apr 24, 2019 at 11:02 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 24-04-19, 09:24, Rafael J. Wysocki wrote:
> > > On Wed, Apr 24, 2019 at 6:01 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 24-04-19, 10:32, andy.tang@nxp.com wrote:
> > > > > From: Yuantian Tang <andy.tang@nxp.com>
> > > > >
> > > > > Enable cpufreq feature on ls1028a chip by adding its compatible
> > > > > string.
> > > > >
> > > > > Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> > > > > ---
> > > > >  drivers/cpufreq/qoriq-cpufreq.c |    1 +
> > > > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > > > >
> > > > > diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> > > > > index 4295e54..d308c4d 100644
> > > > > --- a/drivers/cpufreq/qoriq-cpufreq.c
> > > > > +++ b/drivers/cpufreq/qoriq-cpufreq.c
> > > > > @@ -280,6 +280,7 @@ static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
> > > > >
> > > > >       { .compatible = "fsl,ls1012a-clockgen", },
> > > > >       { .compatible = "fsl,ls1021a-clockgen", },
> > > > > +     { .compatible = "fsl,ls1028a-clockgen", },
> > > > >       { .compatible = "fsl,ls1043a-clockgen", },
> > > > >       { .compatible = "fsl,ls1046a-clockgen", },
> > > > >       { .compatible = "fsl,ls1088a-clockgen", },
> > > >
> > > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > >
> > > So do you want me to take this one directly?
> >
> > I actually applied it and then realized it is powerpc and so dropped
> > it. You want me to apply it ?
> 
> No, I can do that, thanks!
> 

Applied, thanks!
