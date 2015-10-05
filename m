From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: tegra20: remove superfluous CONFIG_PM ifdefs
Date: Mon, 05 Oct 2015 22:46:23 +0200
Message-ID: <2839016.SNCn424N2T@vostro.rjw.lan>
References: <1441732403-7248-1-git-send-email-b.zolnierkie@samsung.com> <1615370.p6S63xknIg@amdc1976> <2371290.4u0K8mkgaF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2371290.4u0K8mkgaF@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 09, 2015 10:14:50 PM Rafael J. Wysocki wrote:
> On Wednesday, September 09, 2015 12:36:39 PM Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > On Wednesday, September 09, 2015 03:13:45 AM Rafael J. Wysocki wrote:
> > > On Tuesday, September 08, 2015 07:13:23 PM Bartlomiej Zolnierkiewicz wrote:
> > > > CONFIG_PM ifdefs are superfluous and can be removed.
> > > > 
> > > > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > > Cc: Alexandre Courbot <gnurou@gmail.com>
> > > > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > 
> > > What tree does this apply to?
> > 
> > It applies fine to both next (next-20150909 branch) and current Linus'
> > tree (top commit is a794b4f).
> 
> OK
> 
> My cpufreq branch has not acquired tegra20-cpufreq.c yet, so I'll apply this
> one when -rc1 is out.  Or please ask whoever merged that driver to apply it
> earlier if you want to.

Applied now, thanks!

Rafael
