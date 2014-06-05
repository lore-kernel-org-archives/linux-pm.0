From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/3] cpufreq: Enable big.LITTLE cpufreq driver on arm64
Date: Thu, 5 Jun 2014 11:04:16 +0100
Message-ID: <20140605100416.GB27946@arm.com>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <2437793.vfcRUkFCet@vostro.rjw.lan>
 <20140519230729.GD30457@sirena.org.uk>
 <3610030.uyJEv7eFhP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:15002 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750964AbaFEKEc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Jun 2014 06:04:32 -0400
Content-Disposition: inline
In-Reply-To: <3610030.uyJEv7eFhP@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mark Brown <broonie@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>

Hi Rafael,

On Tue, May 20, 2014 at 12:36:56AM +0100, Rafael J. Wysocki wrote:
> On Tuesday, May 20, 2014 12:07:29 AM Mark Brown wrote:
> > 
> > --MAH+hnPXVZWQ5cD/
> > Content-Type: text/plain; charset=us-ascii
> > Content-Disposition: inline
> > 
> > On Tue, May 20, 2014 at 01:19:03AM +0200, Rafael J. Wysocki wrote:
> > 
> > > I've queued this one up for 3.16, thanks!
> > 
> > This will fail to build without patch 1 - it uses the stubs added there.
> 
> OK, dropping then.

This patch still made it as commit 4920ab84979d (cpufreq: Enable
big.LITTLE cpufreq driver on arm64) and fails to build on arm64. Could
you please revert it?

Thanks.

-- 
Catalin
