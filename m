From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] CPPC-CPUFreq: Delete an unnecessary check before the function call "kfree"
Date: Sat, 07 Nov 2015 02:10:09 +0100
Message-ID: <2429041.ODHvPqId6J@vostro.rjw.lan>
References: <530C5E18.1020800@users.sourceforge.net> <563BB8DF.7020908@users.sourceforge.net> <20151106014228.GD3773@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50154 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757955AbbKGAk4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2015 19:40:56 -0500
In-Reply-To: <20151106014228.GD3773@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

On Friday, November 06, 2015 07:12:28 AM Viresh Kumar wrote:
> On 05-11-15, 21:15, SF Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Thu, 5 Nov 2015 21:10:29 +0100
> > 
> > The kfree() function tests whether its argument is NULL and then
> > returns immediately. Thus the test around the call is not needed.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  drivers/cpufreq/cppc_cpufreq.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

Rafael

