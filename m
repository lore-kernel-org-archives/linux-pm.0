From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Do nothing in system suspend/resume
 when RT suspended
Date: Tue, 20 Jun 2017 19:08:58 +0300
Message-ID: <1497974938.22624.170.camel@linux.intel.com>
References: <20170330120444.12499-1-jarkko.nikula@linux.intel.com>
         <CAPDyKFqfDYg1ZzcJ2Z7md5CD6tYWRMwi4N8M82DesG_ybVKHMw@mail.gmail.com>
         <da36d4c0-7bcb-be18-6c8c-9fd714e2f1e0@linux.intel.com>
         <CAPDyKFqg3TDMwBO7a-1zuKYeLjE-BQ4RPmtXFKzA0s2a50jQqg@mail.gmail.com>
         <CAPDyKFrJGFHvvM=-xYLcSTtv0FVvo=CNjnA9RAdm=pUrg552GQ@mail.gmail.com>
         <CAPDyKFoqZuv3niz_0FQ1WVP2+gNjebxw9zLVnJ-L0WN24LK3eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoqZuv3niz_0FQ1WVP2+gNjebxw9zLVnJ-L0WN24LK3eA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, John Stultz <john.stultz@linaro.org>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 2017-06-20 at 15:07 +0200, Ulf Hansson wrote:
> On 16 June 2017 at 15:49, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> > Jarkko, Andy,
> > 
> > I just wanted to mention that I haven't forgot about this, I am
> > doing
> > the final changes for the ACPI PM domain at this very moment,
> > however
> > I need a couple of more days more before I can post something.
> > 
> 
> I have now published a branch at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
> acpi_pm_domain_wip
> 
> It contains both changes for the i2c designware platform driver and
> for the ACPI PM domain. If you by coincidence happen to have slack
> time (probably not), then please try it out.
> 
> The branch is based upon today's version of Rafael's pm tree linux-
> next branch.
> 
> If everything goes well, I intend to post the patches after some more
> tests.
> 

I have gone through the series briefly.
My concern is a quite nasty bug we have workaround for in acpi_lpss.c,
i.e. auto power gating of DesignWare DMA on Intel Braswell (CherryTrail)
platforms when it's enumerated via ACPI.

Below is the sequence to test if it works and survives removal and
system sleep (lpss-power.sh is the script which shows a power state of
selected devices along with PMC Atom status registers and runtime PM):

   0 lpss-power.sh 
   1 mount -t debugfs none /sys/kernel/debug
   2 lpss-power.sh 
   3 modprobe i2c-designware-platform
   4 lpss-power.sh 
   5 modprobe sdhci-acpi
   6 lpss-power.sh 
   7 lsmod
   8 modprobe dw-dmac
   9 lpss-power.sh 
  10 modprobe -r dw-dmac
  11 lpss-power.sh 
  12 modprobe dw-dmac
  13 lpss-power.sh 
  14 rtcwake -m mem -s3
  15 lpss-power.sh 
  16 modprobe -r dw-dmac
  17 lpss-power.sh 
  18 modprobe dw-dmac
  19 lpss-power.sh 
  20 stty -F /dev/ttyS2 921600
  21 dmesg > /dev/ttyS2
  22 cat /proc/interrupts 
  23 cat < /dev/ttyS1
  24 lpss-power.sh 
  25 cat < /dev/ttyS1 &
  26 lpss-power.sh 
  27 rtcwake -m mem -s3
  28 lpss-power.sh
  29 fg
  30 lpss-power.sh 

Be aware that DMA is not enabled for I2C!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
