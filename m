From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] blackfin-cpufreq: Mark cpu_set_cclk() as static
Date: Sun, 03 Jan 2016 02:02:05 +0100
Message-ID: <2715978.vEuzRO1thj@vostro.rjw.lan>
References: <5674598B.6020000@users.sourceforge.net> <56786FF6.4060900@users.sourceforge.net> <20151222053543.GB12364@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61965 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751056AbcACAb3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 2 Jan 2016 19:31:29 -0500
In-Reply-To: <20151222053543.GB12364@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

On Tuesday, December 22, 2015 11:05:43 AM Viresh Kumar wrote:
> On 21-12-15, 22:32, SF Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Mon, 21 Dec 2015 22:12:26 +0100
> > 
> > The cpu_set_cclk() function was only used in a single source file so far.
> > Indicate this setting also by the corresponding linkage specifier.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Well, I never Acked this patch as such and you shouldn't have
> mentioned it by yourself. But it looks fine otherwise and so
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Series applied, thanks!

