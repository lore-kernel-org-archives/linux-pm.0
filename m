From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 0/9] PM / ACPI / i2c: Fix system suspend and deploy
 runtime PM centric path for ACPI
Date: Wed, 21 Jun 2017 15:39:21 -0700
Message-ID: <CALAqxLXe0mTN=RizWroJE3p=dcr8JbV+jTws6WjtG1SpWJd5mg@mail.gmail.com>
References: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 21, 2017 at 12:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The i2c designware platform driver, drivers/i2c/busses/i2c-designware-platdrv.c,
> currently suffers from a regression, which easily can be triggerd during system
> suspend/resume.
>
> In particular the regression concerns those SoCs, which doesn't have the i2c
> device being attached to the ACPI PM domain.
>
> The regression, introduced in commit 8503ff166504 ("i2c: designware: Avoid
> unnecessary resuming during system suspend"), takes advantage of the so called
> direct_complete path during system sleep, which works well when using the ACPI
> PM domain, however as stated, that's not the case for other SoCs.
>
> In this series, patch 1, takes a very simplistic approach to solve the problem
> and the change is limited to the i2c driver itself. The aim with this change is
> to make it acceptable as a fix for v4.2+.
>
> However, patch 1 is unfortunate also reverting back to the old behaviour,
> avoiding the direct_complete path, by always runtime resuming the device in the
> device_prepare() phase during system sleep. In many cases this is a waste,
> especially when the device could have remained runtime suspended during the
> entire system sleep sequence.
>
> The rest of the changes in this series, addresses the above problem, avoiding
> to runtime resume the device unless it's really needed. One could have tried
> out other local hacks, limited to the i2c driver, but I believe the problem
> could exist for other drivers/devices as well, thus I aim for a more generic
> solution.
>
> In principle, this series enables the proven runtime PM centric approach to
> implement system sleep in the i2c driver. However, to do that the ACPI PM
> domain have to collaborate and understand this behaviour. Therefore a number of
> changes, patch 2 to patch 8, makes the needed changes to the ACPI PM domain.
> In the last change, patch9, the i2c driver converts to the runtime PM centric
> approach.
>
> It shall be noted, the behaviour of the ACPI PM domain should remain intact,
> still taking benefit of using the direct_complete path during system sleep,
> except for those devices that explicitly request it not to.
>
> This series has been tested on an ARM64 Hikey board, not having its i2c device
> attach to the ACPI PM domain. This means that the ACPI changes has so far only
> been compile tested. Any help in testing on relevant Intel SoCs is greatly
> appreciated and so is of course review comments.
>
> The series is based upon Rafael's pm tree and linux-next branch. It's also
> available at the following git:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git acpi_pm_i2c_rpm_path

With this patchset I'm not seeing any i2c errors on resume w/ the
HiKey (which I do see if I remove these patches).

Tested-by: John Stultz <john.stultz@linaro.org>

Unfortunately... that said, in testing I did just find a regression
elsewhere with suspend/resume on HiKey, where we'll not go all the way
to suspend if wifi is enabled. So If anyone else is having trouble
testing these patches on HiKey, turn off wifi for now.

thanks
-john
