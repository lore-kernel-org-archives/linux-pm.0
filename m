From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] cpufreq: Enable big.LITTLE cpufreq driver on arm64
Date: Thu, 05 Jun 2014 14:10:04 +0200
Message-ID: <20323352.3KEVHO00Qv@vostro.rjw.lan>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org> <3610030.uyJEv7eFhP@vostro.rjw.lan> <20140605100416.GB27946@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50480 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751125AbaFELwr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Jun 2014 07:52:47 -0400
In-Reply-To: <20140605100416.GB27946@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Brown <broonie@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>

On Thursday, June 05, 2014 11:04:16 AM Catalin Marinas wrote:
> Hi Rafael,
> 
> On Tue, May 20, 2014 at 12:36:56AM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, May 20, 2014 12:07:29 AM Mark Brown wrote:
> > > 
> > > --MAH+hnPXVZWQ5cD/
> > > Content-Type: text/plain; charset=us-ascii
> > > Content-Disposition: inline
> > > 
> > > On Tue, May 20, 2014 at 01:19:03AM +0200, Rafael J. Wysocki wrote:
> > > 
> > > > I've queued this one up for 3.16, thanks!
> > > 
> > > This will fail to build without patch 1 - it uses the stubs added there.
> > 
> > OK, dropping then.
> 
> This patch still made it as commit 4920ab84979d (cpufreq: Enable
> big.LITTLE cpufreq driver on arm64) and fails to build on arm64. Could
> you please revert it?

I will.

Rafael

