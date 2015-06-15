From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq:cpufreq-nforce2 - Fix typo in comment to function nforce2_init().
Date: Tue, 16 Jun 2015 01:37:10 +0200
Message-ID: <3504368.GjVHUm5yDP@vostro.rjw.lan>
References: <1432357578-4069-1-git-send-email-shailendra.capricorn@gmail.com> <20150525072039.GA9992@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58970 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750842AbbFOXLO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 19:11:14 -0400
In-Reply-To: <20150525072039.GA9992@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shailendra Verma <shailendra.capricorn@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, May 25, 2015 12:50:39 PM Viresh Kumar wrote:
> On 23-05-15, 10:36, Shailendra Verma wrote:
> 
> Always mention something here on why this is required. Even if the
> subject is good enough :)
> 
> > Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
> > ---
> >  drivers/cpufreq/cpufreq-nforce2.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
> > index a225809..db69eeb 100644
> > --- a/drivers/cpufreq/cpufreq-nforce2.c
> > +++ b/drivers/cpufreq/cpufreq-nforce2.c
> > @@ -414,7 +414,7 @@ static int nforce2_detect_chipset(void)
> >   * nforce2_init - initializes the nForce2 CPUFreq driver
> >   *
> >   * Initializes the nForce2 FSB support. Returns -ENODEV on unsupported
> > - * devices, -EINVAL on problems during initiatization, and zero on
> > + * devices, -EINVAL on problems during initialization, and zero on
> >   * success.
> >   */
> >  static int __init nforce2_init(void)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for 4.2, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
