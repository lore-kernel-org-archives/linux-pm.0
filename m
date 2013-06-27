From: Jacob Shin <jacob.shin@amd.com>
Subject: Re: od_set_powersave_bias: NULL pointer dereference
Date: Thu, 27 Jun 2013 10:21:43 -0500
Message-ID: <20130627152143.GA5324@jshin-Toonie>
References: <51C87ADC.4070409@canonical.com>
 <CAKohponCrC93D88Fgg_3LKsLG0KMeCVKsTEoy-N3jsdUQdgWvA@mail.gmail.com>
 <20130625161935.GA10208@jshin-Toonie>
 <CAKohpomSa0FRviZHkkJOeUUxubbzueVb3yyP5G8ASwpRB6wANQ@mail.gmail.com>
 <20130626142852.GA2326@jshin-Toonie>
 <CAKohpom_jHQeR2FKFS3-RkxpPrJvekw8pDb-qnApnzu-VqreBQ@mail.gmail.com>
 <20130626175722.GA20226@jshin-Toonie>
 <CAKohpo=UTmpLmyQs5+xLNnCLMCeZHNQT3USjmK1NTaFJLNQg-Q@mail.gmail.com>
 <20130627145505.GA3076@jshin-Toonie>
 <CAKohpomSNGn1wTzbCxpHN5fu2L6mJ1fnhvt2uLBWLgQE8fS6Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co1ehsobe006.messaging.microsoft.com ([216.32.180.189]:36051
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752777Ab3F0PVw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2013 11:21:52 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpomSNGn1wTzbCxpHN5fu2L6mJ1fnhvt2uLBWLgQE8fS6Rg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tim Gardner <tim.gardner@canonical.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, Jun 27, 2013 at 08:39:12PM +0530, Viresh Kumar wrote:
> On 27 June 2013 20:25, Jacob Shin <jacob.shin@amd.com> wrote:
> > diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> > index 4b9bb5d..93eb5cb 100644
> > --- a/drivers/cpufreq/cpufreq_ondemand.c
> > +++ b/drivers/cpufreq/cpufreq_ondemand.c
> > @@ -47,6 +47,8 @@ static struct od_ops od_ops;
> >  static struct cpufreq_governor cpufreq_gov_ondemand;
> >  #endif
> >
> > +static unsigned int default_powersave_bias;
>
> Why are the above three changes required? And in case they are, then
> they must have been commited separately.
> 
> Because you haven't replied to my earlier comment on this, I
> thought you agreed. But it looks you haven't read my first
> reply well.

Sorry I totally missed it,

I was trying to account for the case when od_set_powersave_bias() is
called while ondemand is not the current governor. And then later
becomes the current governor. So when od_init() is called it will take
the expected default, rather than 0.

