From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/9] i2c: designware: Fix system suspend
Date: Thu, 22 Jun 2017 13:49:33 +0300
Message-ID: <20170622104933.GY629@lahna.fi.intel.com>
References: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
 <1498072888-14782-2-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0iYwPE8rpn=aZ9n6LV-qbAK3kynRqVZ7xxuB+gYar_fyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iYwPE8rpn=aZ9n6LV-qbAK3kynRqVZ7xxuB+gYar_fyg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>, stable@vger.linux.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 22, 2017 at 01:31:51AM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 21, 2017 at 9:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > The commit 8503ff166504 ("i2c: designware: Avoid unnecessary resuming
> > during system suspend"), may suggest to the PM core to try out the so
> > called direct_complete path for system sleep. In this path, the PM core
> > treats a runtime suspended device as it's already in a proper low power
> > state for system sleep, which makes it skip calling the system sleep
> > callbacks for the device, except for the ->prepare() and the ->complete()
> > callback.
> >
> > Moreover, under certain circumstances the PM core may unset the
> > direct_complete flag for a parent device, in case its child device are
> > being system suspended before. In other words, the PM core doesn't skip
> > calling the system sleep callbacks, no matter if the device is runtime
> > suspended or not.
> >
> > In cases of an i2c slave device, the above situation is triggered.
> > Unfortunate, this also breaks the assumption that the i2c device is always
> > runtime resumed, whenever the dw_i2c_plat_suspend() callback is being
> > invoked, which then leads to a regression.
> >
> > More precisely, dw_i2c_plat_suspend() then calls clk_core_disable() and
> > clk_core_unprepare(), for an already disabled/unprepared clock, leading to
> > complaints about clocks calls being wrongly balanced.
> >
> > In cases when the i2c device is attached to the ACPI PM domain, the problem
> > doesn't occur. That's because ACPI's ->suspend() callback, assigned to
> > acpi_subsys_suspend(), calls pm_runtime_resume() for the i2c device.
> 
> Which really is expected to happen, so direct_complete should only be
> used along with the ACPI PM domain in this case.
> 
> Moreover, in the ACPI PM domain case acpi_subsys_prepare() is supposed
> to do the right thing without dw_i2c_plat_prepare() and the return
> value of the latter will be ignored anyway, so dw_i2c_plat_prepare()
> will only have effect without ACPI PM domain AFAICS.
> 
> It looks like commit 8503ff166504 is entirely misguided.

Indeed it is. At the time I suggested that change I did not really
understand how the direct complete is supposed to be used :-/

Thanks Ulf for taking care of this!

I tested this series on Dell XPS 9350 which has touch panel connected to
I2C and suspend/resume still works fine and I can see the controller
going to D3 when the touch panel is idle.

I can perform more comprehensive testing next week.
