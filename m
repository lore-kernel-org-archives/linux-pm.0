From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 09/10] cpufreq: cpu0: rename driver and internals to 'cpufreq_generic'
Date: Tue, 09 Sep 2014 02:02:21 +0200
Message-ID: <2178450.edMFOq1q8R@vostro.rjw.lan>
References: <cover.1409201048.git.viresh.kumar@linaro.org> <1721663.ItCsG3Tt8O@vostro.rjw.lan> <3644672.iCZ87qpZY4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51330 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752856AbaIHXmz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Sep 2014 19:42:55 -0400
In-Reply-To: <3644672.iCZ87qpZY4@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, santosh.shilimkar@ti.com, thomas.petazzoni@free-electrons.com, pramod.gurav@smartplayin.com

On Tuesday, September 09, 2014 01:52:10 AM Rafael J. Wysocki wrote:
> On Tuesday, September 09, 2014 01:39:32 AM Rafael J. Wysocki wrote:
> > On Monday, September 08, 2014 04:18:11 PM Stephen Boyd wrote:
> > > On 09/08/14 16:34, Rafael J. Wysocki wrote:
> > > > On Thursday, August 28, 2014 11:22:31 AM Viresh Kumar wrote:
> > > >> The naming convention of this driver was always under the scanner, people
> > > >> complained that it should have a more generic name than cpu0, as it manages all
> > > >> CPUs that are sharing clock lines.
> > > >>
> > > >> Also, in future it will be modified to support any number of clusters with
> > > >> separate clock/voltage lines.
> > > >>
> > > >> Lets rename it to 'cpufreq_generic' from 'cpufreq_cpu0'.
> > > > I'm not a big fan of changes like this to be honest, because they kind of
> > > > hide history.  For example, if you do a "git blame" on the new file, it will
> > > > show your commit and nothing before it.
> > > 
> > > Sounds like a tooling problem. But git blame doesn't have that behavior
> > > so there isn't actually any problem?
> > 
> > Ah, OK
> > 
> > It used to some time ago or maybe it depends on how you carry out the rename.
> 
> So more bikeshedding. :-)
> 
> Isn't "generic" somewhat too broad?  Surely it doesn't cover x86.  And does
> it actually cover anything without clocks/regulators?

For now, I'm going to queue up patches [1-8/10] from this series for 3.18.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
