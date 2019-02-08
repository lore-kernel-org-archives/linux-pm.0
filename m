From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Date: Fri, 8 Feb 2019 14:28:12 +0000
Message-ID: <20190208142812.GA22401@e107155-lin>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
 <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
 <CAJZ5v0iU1+YdAqHai+r_ubC1FarC2JWBuc98MG58n+y9=1WB=A@mail.gmail.com>
 <20190208103133.ysvaroyniuc3k4i5@vireshk-i7>
 <CAJZ5v0ghQ6bTV8atd6dtq8=ZBDUpDRVsCiAhwQVtfoMH-JhH9A@mail.gmail.com>
 <20190208113904.GB7913@e107155-lin>
 <CAJZ5v0gbh2LDq+6P_CQ+GWOxEdQrRUqQnx7v59hvs2_wwx9=kw@mail.gmail.com>
 <20190208120949.GB13043@e107155-lin>
 <CAJZ5v0jkpMyXrg9HwFizXLBEu0tggBmMbhZZZxzt_+a10cmuYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jkpMyXrg9HwFizXLBEu0tggBmMbhZZZxzt_+a10cmuYA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Gerlach <d-gerlach@ti.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 08, 2019 at 01:23:37PM +0100, Rafael J. Wysocki wrote:
> On Fri, Feb 8, 2019 at 1:09 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >

[...]

> > Yes, in that case additional logic in the driver also needed. I am fine
> > if we enforce driver to deal with this issue, but was thinking if we can
> > make it generic. Also I was just trying to avoid adding _suspend/resume
> > to driver just to avoid this issue.
>
> I was wondering if cpufreq_offline()/online() could be invoked from
> cpufreq_suspend()/resume() for the nonboot CPUs - if the driver needs
> it (there could be a driver flag to indicate that).
>
> If they are made exit immediately when cpufreq_suspended is set (and
> the requisite driver flag is set too), that might work AFAICS.

Yes that sounds feasible. It should be fine to assume it's safe to call
cpufreq_online on a CPU even for CPU that might have failed to come
online or didn't reached a state in CPUHP from where CPUFreq callback
is executed or am I missing something ?

--
Regards,
Sudeep
