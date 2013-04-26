From: Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 0/3] Runtime Interpreted Power Sequences
Date: Fri, 26 Apr 2013 11:30:39 -0700
Message-ID: <20130426183038.GA26373@teo>
References: <1353047903-14363-1-git-send-email-acourbot@nvidia.com>
 <CAPnjgZ1P6dmRB0sO2qBUtd=WBiNcY339NAit2faaotAfEqQDeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1P6dmRB0sO2qBUtd=WBiNcY339NAit2faaotAfEqQDeQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Leela Krishna Amudala <l.krishna-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lk <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 26, 2013 at 11:55:35AM -0700, Simon Glass wrote:
> On Thu, Nov 15, 2012 at 10:38 PM, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> > Hopefully the final series before the feature gets merged. Anton Vorontsov
> > kindly accepted to take it into his tree, so this series is mostly a call for
> > acks, tests and reviews notices before the merge window for 3.8 opens. If you
> > are interested in seeing this feature, please add your name.
> >
> > This series also adds an entry for the subsystem into MAINTAINERS, setting me as
> > the person in charge.
> >
> > Changes from v7:
> > - fix bug reported by Tony Prisk
> > - add MAINTAINERS entry
> >
> > Alexandre Courbot (3):
> >   Runtime Interpreted Power Sequences
> >   pwm_backlight: use power sequences
> >   Take maintainership of power sequences
> 
> Did this actually land?

At least not through my tree. I saw a huge discussion, and I am not sure
how it ended and whether there was a consensus.

Thanks,

Anton
