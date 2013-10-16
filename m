From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove unnecessary braces
Date: Thu, 17 Oct 2013 00:34 +0200
Message-ID: <2444417.nOPH9ihodY@vostro.rjw.lan>
References: <20131015174251.GA4366@eee-laptop> <CAKohpo=4AyyVkiwQikPDMXQzSFLhhOeVsGjFBcUqYDMvkFkruw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=4AyyVkiwQikPDMXQzSFLhhOeVsGjFBcUqYDMvkFkruw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Evgeny Kapaev <orener300@gmail.com>, cpufreq@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 16, 2013 10:02:45 AM Viresh Kumar wrote:
> On 15/10/2013, Evgeny Kapaev <orener300@gmail.com> wrote:
> > As per coding style, braces {} are not necessary for single statement block
> >
> > Signed-off-by: Evgeny Kapaev <orener300@gmail.com>

Queued up for 3.13, thanks!

> > ---
> >  drivers/cpufreq/speedstep-centrino.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/speedstep-centrino.c
> > b/drivers/cpufreq/speedstep-centrino.c
> > index f897d51..98797a6 100644
> > --- a/drivers/cpufreq/speedstep-centrino.c
> > +++ b/drivers/cpufreq/speedstep-centrino.c
> > @@ -373,9 +373,8 @@ static int centrino_cpu_init(struct cpufreq_policy
> > *policy)
> >  		return -ENODEV;
> >  	}
> >
> > -	if (centrino_cpu_init_table(policy)) {
> > +	if (centrino_cpu_init_table(policy))
> >  		return -ENODEV;
> > -	}
> >
> >  	/* Check to see if Enhanced SpeedStep is enabled, and try to
> >  	   enable it if not. */
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
