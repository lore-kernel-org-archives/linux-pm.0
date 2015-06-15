From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq:gx-suspmod - Fix two typos in two comments.
Date: Tue, 16 Jun 2015 01:37:34 +0200
Message-ID: <3487385.Nns3N1VCRA@vostro.rjw.lan>
References: <1432357609-4102-1-git-send-email-shailendra.capricorn@gmail.com> <20150525072114.GB9992@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41624 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751454AbbFOXLh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 19:11:37 -0400
In-Reply-To: <20150525072114.GB9992@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shailendra Verma <shailendra.capricorn@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, May 25, 2015 12:51:14 PM Viresh Kumar wrote:
> On 23-05-15, 10:36, Shailendra Verma wrote:
> > 
> > Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
> > ---
> >  drivers/cpufreq/gx-suspmod.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/gx-suspmod.c b/drivers/cpufreq/gx-suspmod.c
> > index 1d723dc..3488c9c 100644
> > --- a/drivers/cpufreq/gx-suspmod.c
> > +++ b/drivers/cpufreq/gx-suspmod.c
> > @@ -144,7 +144,7 @@ module_param(max_duration, int, 0444);
> >  
> >  
> >  /**
> > - * we can detect a core multipiler from dir0_lsb
> > + * we can detect a core multiplier from dir0_lsb
> >   * from GX1 datasheet p.56,
> >   *	MULT[3:0]:
> >   *	0000 = SYSCLK multiplied by 4 (test only)
> > @@ -346,7 +346,7 @@ static int cpufreq_gx_verify(struct cpufreq_policy *policy)
> >  
> >  	/* it needs to be assured that at least one supported frequency is
> >  	 * within policy->min and policy->max. If it is not, policy->max
> > -	 * needs to be increased until one freuqency is supported.
> > +	 * needs to be increased until one frequency is supported.
> >  	 * policy->min may not be decreased, though. This way we guarantee a
> >  	 * specific processing capacity.
> >  	 */
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for 4.2, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
