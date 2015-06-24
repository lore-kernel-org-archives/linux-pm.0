From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] PM / Domains: Avoid infinite loops in attach/detach code
Date: Wed, 24 Jun 2015 16:10:17 +0200
Message-ID: <10339007.ODJxqcfmHy@vostro.rjw.lan>
References: <1434622954-26747-3-git-send-email-geert+renesas@glider.be> <CAJZ5v0j2RkjsWQkDkjZOf8mx12CvLzOzmLG3yRT-04naa9==HQ@mail.gmail.com> <CAMuHMdU8sHuAKrRvVF1pV7FOCLYrdi1xfAiqb50tfJWhKK3jDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdU8sHuAKrRvVF1pV7FOCLYrdi1xfAiqb50tfJWhKK3jDQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Kevin Hilman <khilman@kernel.org>, Magnus Damm <damm@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 23, 2015 03:45:43 PM Geert Uytterhoeven wrote:
> Hi Rafael,
> 
> On Tue, Jun 23, 2015 at 3:38 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>>> @@ -2218,10 +2227,13 @@ int genpd_dev_pm_attach(struct device *dev)
> >>>>
> >>>>         dev_dbg(dev, "adding to PM domain %s\n", pd->name);
> >>>>
> >>>> -       while (1) {
> >>>> +       for (i = 0; i < GENPD_RETRIES; i++) {
> >>>>                 ret = pm_genpd_add_device(pd, dev);
> >>>>                 if (ret != -EAGAIN)
> >>>>                         break;
> >>>> +
> >>>> +               if (i > GENPD_RETRIES / 2)
> >>>> +                       udelay(GENPD_DELAY_US);
> >>>
> >>> In this execution path, we retry when getting -EAGAIN while believing
> >>> the reason to the error are only *temporary* as we are soon waiting
> >>> for all devices in the genpd to be system PM resumed. At least that's
> >>> my understanding to why we want to deal with -EAGAIN here, but I might
> >>> be wrong.
> >>>
> >>> In this regards, I wonder whether it could be better to re-try only a
> >>> few times but with a far longer interval time than a couple us. What
> >>> do you think?
> >>
> >> That's indeed viable. I have no idea for how long this temporary state can
> >> extend.
> >
> > A usual approach to this kind of thing is to use exponential fallback
> > where you increase the delay twice with respect to the previous one
> > every time.
> 
> Right, but when do you give up?

Well, I guess you know what a reasonable timeout should be?

> Note that udelay() is a busy loop. Should it fall back to msleep() after
> a while?

If we can't fall back to msleep() at one point, you may as well simply poll
periodically as you did originally.

Thanks,
Rafael

