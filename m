From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 6/7] cpufreq: intel_pstate: Trivial code cleanup
Date: Tue, 10 Jun 2014 17:31:38 +0200
Message-ID: <1447217.dTmMAkaUnF@vostro.rjw.lan>
References: <5396208F.6070400@semaphore.gr> <53972070.3020608@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60808 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750843AbaFJPOP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 11:14:15 -0400
In-Reply-To: <53972070.3020608@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, Viresh Kumar <viresh.kumar@linaro.org>, dirk.j.brandewie@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tuesday, June 10, 2014 08:12:48 AM Dirk Brandewie wrote:
> On 06/09/2014 02:01 PM, Stratos Karafotis wrote:
> > Remove unnecessary blank lines.
> > Remove unnecessary parentheses.
> > Remove unnecessary braces.
> > Put the code in one line where possible.
> > Add blank lines after variable declarations.
> > Alignment to open parenthesis.
> >
> 
> I don't have an issue with this patch in general but I would rather
> the cleanup be done when there is a functional change in the given
> hunk of code otherwise you are setting up a fence for stable/backporters
> of functional changes in the future.

I actually prefer separate cleanups so as to avoid doing multiple things
in one patch.

Rafael

