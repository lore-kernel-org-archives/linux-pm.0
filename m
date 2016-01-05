From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq-dt: fix handling regulator_get_voltage result
Date: Tue, 05 Jan 2016 14:03:22 +0100
Message-ID: <2016662.ItF90d0Nnq@vostro.rjw.lan>
References: <1451474324-15481-1-git-send-email-a.hajda@samsung.com> <20160104052856.GA27177@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47252 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752426AbcAEMcm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2016 07:32:42 -0500
In-Reply-To: <20160104052856.GA27177@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Andrzej Hajda <a.hajda@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Monday, January 04, 2016 10:58:56 AM Viresh Kumar wrote:
> On 30-12-15, 12:18, Andrzej Hajda wrote:
> > The function can return negative values so it should be assigned
> > to signed type.
> > 
> > The problem has been detected using proposed semantic patch
> > scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].
> > 
> > [1]: http://permalink.gmane.org/gmane.linux.kernel/2038576
> > 
> > Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> > ---
> >  drivers/cpufreq/cpufreq-dt.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

Rafael

