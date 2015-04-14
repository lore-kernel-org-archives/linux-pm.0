From: Michael Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v8 00/18] Tegra124 CL-DVFS / DFLL clocksource + cpufreq
Date: Tue, 14 Apr 2015 14:09:38 -0700
Message-ID: <20150414210938.19585.25150@quantum>
References: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
 <20150311100741.GK19577@ulmo.nvidia.com> <20150410211157.14369.51754@quantum>
 <20150414144339.GA30495@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150414144339.GA30495@ulmo.nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: gnurou@gmail.com, pgaikwad@nvidia.com, vinceh@nvidia.com, swarren@wwwdotorg.org, viresh.kumar@linaro.org, pdeschrijver@nvidia.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Mikko Perttunen <mikko.perttunen@kapsi.fi>, pwalmsley@nvidia.com, linux-tegra@vger.kernel.org, tuomas.tynkkynen@iki.fi, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Quoting Thierry Reding (2015-04-14 07:43:41)
> On Fri, Apr 10, 2015 at 02:11:57PM -0700, Michael Turquette wrote:
> > Quoting Thierry Reding (2015-03-11 03:07:43)
> > > Hi Mike,
> > > 
> > > Have you had a chance to look at these changes to the Tegra clock
> > > driver? If you're fine with it, I'd like to take these patches through
> > > the Tegra tree because the rest of the series depends on them. I can
> > > provide a stable branch in case we need to base other Tegra clock
> > > changes on top of this.
> > 
> > Hi Thierry,
> > 
> > Clock patches (and corresponding DT binding descriptions and changes to
> > DTS) look fine to me. Please add:
> > 
> > Acked-by: Michael Turquette <mturquette@linaro.org>
> > 
> > I did have a question about the beahvior of clk_put in one of Mikko's
> > patches but it should not gate this series. I'm just trying to find out
> > if we have a bug in the framework or if the Tegra driver is a special
> > case.
> > 
> > Also I do not think a stable branch is necessary.
> 
> Given how this didn't work at all for v4.1, why don't we try to do this
> the conventional way for v4.2? What I propose is that I collect all the
> patches that I've had in these branches into a single branch that I can
> send you shortly after v4.1-rc1. Then you can pull that into the clock
> tree when you're happy and I can pull that into the Tegra tree again if
> needed to resolve dependencies.

Sounds fine, so long as you do not rebase your branch.

> 
> One problem that I foresee is that the EMC clock driver relies on some
> symbols exported by the EMC driver, so it will fail to build on its own
> if merged into the clock tree. Usually I'd say we can solve this by
> merging a stable branch from the Tegra tree into the clock tree, but if
> any of the ARM SoC maintainers then decides that, for whatever reason,
> the Tegra pull request isn't good enough, you'd need to either redo the
> clock tree or we slip in the changes via the clock tree anyway.
> 
> Perhaps a solution would be to implement stubs for the API exposed by
> the EMC driver and merge that through the clock tree, which should give
> us a tree that can be built but be a no-op at runtime. Then we can add
> the actual code to enable EMC scaling in the Tegra tree by providing a
> real implementation. That way we only have the Tegra tree depend on the
> clock tree.

That sounds OK, but it does create some extra work for you.
Alternatively you can just take these patches through your tegra tree
into arm-soc with my Ack (which is the reason I gave it out in the first
place).

However if you have other clock patches which conflict then having the
stable branch makes good sense. The choice is yours since it will be an
extra burden on your to stub things out.

Regards,
Mike

> 
> How does that sound?
> 
> Thierry
