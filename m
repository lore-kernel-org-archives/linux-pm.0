From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Date: Fri, 8 Feb 2019 11:52:38 +0100
Message-ID: <CAJZ5v0ih+CgYtt5FFb0thCEkCMpXfQHFaLugCOf_FAikCHgK6w@mail.gmail.com>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com> <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
 <CAJZ5v0iU1+YdAqHai+r_ubC1FarC2JWBuc98MG58n+y9=1WB=A@mail.gmail.com>
 <20190208103133.ysvaroyniuc3k4i5@vireshk-i7> <CAJZ5v0ghQ6bTV8atd6dtq8=ZBDUpDRVsCiAhwQVtfoMH-JhH9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0ghQ6bTV8atd6dtq8=ZBDUpDRVsCiAhwQVtfoMH-JhH9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Gerlach <d-gerlach@ti.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 8, 2019 at 11:42 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Feb 8, 2019 at 11:31 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 08-02-19, 11:22, Rafael J. Wysocki wrote:
> > > There are cpufreq driver suspend and resume callbacks, maybe use them?
> > >
> > > The driver could do the I2C transactions in its suspend/resume
> > > callbacks and do nothing in online/offline if those are part of
> > > system-wide suspend/resume.
> >
> > These are per-policy things that we need to do, not sure if driver
> > suspend/resume is a good place for that. It is more for a case where
> > CPU 0-3 are in one policy and 4-7 in another. Now 1-7 are
> > hot-unplugged during system suspend and hotplugged later on. This is
> > more like complete removal/addition of devices instead of
> > suspend/resume.
>
> No, it isn't.  We don't remove devices on offline.  We migrate stuff
> away from them and (opportunistically) power them down.
>
> If this is system suspend, the driver kind of knows that offline will
> take place, so it can prepare for it.  Likewise, when online takes
> place during system-wide resume, it generally is known that this is
> system-wide resume (there is a flag to indicate that in CPU hotplug),
> it can be "smart" and avoid accessing suspended devices.  Deferring
> the frequency set up until the driver resume time should do the trick
> I suppose.

BTW, do transitions to idle states involve I2C transactions on the
systems in question?
