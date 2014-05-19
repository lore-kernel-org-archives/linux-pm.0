From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] cpufreq: Enable big.LITTLE cpufreq driver on arm64
Date: Tue, 20 May 2014 01:36:56 +0200
Message-ID: <3610030.uyJEv7eFhP@vostro.rjw.lan>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org> <2437793.vfcRUkFCet@vostro.rjw.lan> <20140519230729.GD30457@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54185 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751253AbaESXUB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 May 2014 19:20:01 -0400
In-Reply-To: <20140519230729.GD30457@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>

On Tuesday, May 20, 2014 12:07:29 AM Mark Brown wrote:
> 
> --MAH+hnPXVZWQ5cD/
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Tue, May 20, 2014 at 01:19:03AM +0200, Rafael J. Wysocki wrote:
> 
> > I've queued this one up for 3.16, thanks!
> 
> This will fail to build without patch 1 - it uses the stubs added there.

OK, dropping then.

Rafael

