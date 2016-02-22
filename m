From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: fix comment about return value of cpufreq_register_driver()
Date: Mon, 22 Feb 2016 14:15:10 +0100
Message-ID: <1933400.vKzGWdH0aj@vostro.rjw.lan>
References: <1456026601-31282-1-git-send-email-ebiggers3@gmail.com> <20160222052446.GD28226@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56561 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754554AbcBVNNk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 08:13:40 -0500
In-Reply-To: <20160222052446.GD28226@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eric Biggers <ebiggers3@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, February 22, 2016 10:54:46 AM Viresh Kumar wrote:
> On 20-02-16, 21:50, Eric Biggers wrote:
> > The comment has been incorrect since commit 4dea5806d332
> > ("cpufreq: return EEXIST instead of EBUSY for second registering").
> > 
> > Signed-off-by: Eric Biggers <ebiggers3@gmail.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index e979ec7..bfefc91 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2384,7 +2384,7 @@ EXPORT_SYMBOL_GPL(cpufreq_boost_enabled);
> >   * submitted by the CPU Frequency driver.
> >   *
> >   * Registers a CPU Frequency driver to this core code. This code
> > - * returns zero on success, -EBUSY when another driver got here first
> > + * returns zero on success, -EEXIST when another driver got here first
> >   * (and isn't unregistered in the meantime).
> >   *
> >   */
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for 4.6, thanks!

