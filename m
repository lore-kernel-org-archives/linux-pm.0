From: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Subject: Re: [PATCH 00/21] On-demand device registration
Date: Thu, 04 Jun 2015 22:39:31 +0200
Message-ID: <5570B783.1050808@ahsoftware.de>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com> <CAL_Jsq+EWLEJhRudTGAwYsOg4tX2-pGhygeQGHae9RL8rBpMiA@mail.gmail.com> <556F5C24.1030101@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <556F5C24.1030101-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, =?UTF-8?B?U3TDqXBoYW5lIE1hcmNoZXNpbg==?= <stephane.marchesin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TZUIDd8j+nm9g@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Am 03.06.2015 um 21:57 schrieb Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org:

=2E..

> So few comments from above:
> - registering devices later during the System boot may improve boot t=
ime.
>   But resolving of all deferred probes may NOT improve boot time ;)=20
>   Have you seen smth like this?

If someone is out for boot time reduction, I think one of the best ways
would by making driver initialization parallel. Keep in mind that all
linked in drivers currently are initialized in series.

As it seems to have been forgotten or overread, I've mentioned in my
series of patches last year that, with a few changes, it's possible to
let the algorithm I've used (dfs) to spit out all drivers which can be
initialized in parallel.

But as I'm not paid for the work I've done and just did it out of
curiosity, interest or how ever you want name it, I haven't spend any
more time into that topic, especially as I'm missing the necessary
connections to get patches into the kernel. ;)

But, as said, it's easy (at least if aren't getting panic when it comes
to a bit of algorithm theory) to get a list drivers you can start in
parallel if you have such a complete list of dependencies as DT already
offers. Just look at the pictures generate by dtc (using my patches),
you will see, they already show which drivers can be initialized in
parallel.

So it would be easy to use e.g. all cores already very early at boot to
initialize drivers, not just after init got started. Besides that the
w=C3=BCrgaround of defered init (which, btw. leads devs to supress erro=
r
messages, which is especially bad if you are searching a problem) isn't
needed anymore if you have a list of dependecies (however you get it,
I've used DT because the dependencies already are all there).

Regards,

Alexander Holler
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
