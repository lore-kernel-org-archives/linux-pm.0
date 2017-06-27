From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Do nothing in system suspend/resume
 when RT suspended
Date: Tue, 27 Jun 2017 17:34:56 +0300
Message-ID: <1498574096.22624.201.camel@linux.intel.com>
References: <20170330120444.12499-1-jarkko.nikula@linux.intel.com>
         <CAPDyKFqfDYg1ZzcJ2Z7md5CD6tYWRMwi4N8M82DesG_ybVKHMw@mail.gmail.com>
         <da36d4c0-7bcb-be18-6c8c-9fd714e2f1e0@linux.intel.com>
         <CAPDyKFqg3TDMwBO7a-1zuKYeLjE-BQ4RPmtXFKzA0s2a50jQqg@mail.gmail.com>
         <CAPDyKFrJGFHvvM=-xYLcSTtv0FVvo=CNjnA9RAdm=pUrg552GQ@mail.gmail.com>
         <CAPDyKFoqZuv3niz_0FQ1WVP2+gNjebxw9zLVnJ-L0WN24LK3eA@mail.gmail.com>
         <1497974938.22624.170.camel@linux.intel.com>
         <CAPDyKFrC8PEu4v+Ce4Y-ZE+9dRs3OR7TcTrPA54qKGtZjkNL3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrC8PEu4v+Ce4Y-ZE+9dRs3OR7TcTrPA54qKGtZjkNL3A@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, John Stultz <john.stultz@linaro.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

+Cc: Hans.

On Wed, 2017-06-21 at 16:40 +0200, Ulf Hansson wrote:
> On 20 June 2017 at 18:08, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, 2017-06-20 at 15:07 +0200, Ulf Hansson wrote:
> > > On 16 June 2017 at 15:49, Ulf Hansson <ulf.hansson@linaro.org>
> > > wrote:
> > > > Jarkko, Andy,
> > > > 
> > > > I just wanted to mention that I haven't forgot about this, I am
> > > > doing
> > > > the final changes for the ACPI PM domain at this very moment,
> > > > however
> > > > I need a couple of more days more before I can post something.
> > > > 

> > I have gone through the series briefly.
> > My concern is a quite nasty bug we have workaround for in
> > acpi_lpss.c,
> > i.e. auto power gating of DesignWare DMA on Intel Braswell
> > (CherryTrail)
> > platforms when it's enumerated via ACPI.
> 
> First, as long as there is no driver calling the new API
> acpi_dev_disable_direct_comlete(), the ACPI PM domain should behave
> exactly the same as before these changes.
> 
> However, regarding your concern, can you please be a bit more precise
> on how you deal with the problems. I would appreciate if you could
> give me real pointers to the code for the workaround, the above is too
> hand wavy for me to understand.

In acpi_lpss.c there are big comments about this issue.

Hans, Cc'ed, is working on that in relation to PWM power problems.

> 
> So where things really starts to change is in the final i2c patch in
> the series, which converts the i2c designware platform driver to use
> the runtime PM centric approach, and to do that, it calls the
> acpi_dev_disable_direct_complete().

Does it mean we will loose a possibility to use DMA for I2C (not much I
care about and would be unlikely a user for this, just wondering)?

> > 
> > Below is the sequence to test if it works and survives removal and
> > system sleep (lpss-power.sh is the script which shows a power state
> > of
> > selected devices along with PMC Atom status registers and runtime
> > PM):
> > 
> >    0 lpss-power.sh
> >    1 mount -t debugfs none /sys/kernel/debug
> >    2 lpss-power.sh
> >    3 modprobe i2c-designware-platform
> >    4 lpss-power.sh
> >    5 modprobe sdhci-acpi
> >    6 lpss-power.sh
> >    7 lsmod
> >    8 modprobe dw-dmac
> >    9 lpss-power.sh
> >   10 modprobe -r dw-dmac
> >   11 lpss-power.sh
> >   12 modprobe dw-dmac
> >   13 lpss-power.sh
> >   14 rtcwake -m mem -s3
> >   15 lpss-power.sh
> >   16 modprobe -r dw-dmac
> >   17 lpss-power.sh
> >   18 modprobe dw-dmac
> >   19 lpss-power.sh
> >   20 stty -F /dev/ttyS2 921600
> >   21 dmesg > /dev/ttyS2
> >   22 cat /proc/interrupts
> >   23 cat < /dev/ttyS1
> >   24 lpss-power.sh
> >   25 cat < /dev/ttyS1 &
> >   26 lpss-power.sh
> >   27 rtcwake -m mem -s3
> >   28 lpss-power.sh
> >   29 fg
> >   30 lpss-power.sh
> > 
> > Be aware that DMA is not enabled for I2C!
> 
> So if DMA isn't enabled for I2C, what is there to worry about?

Since LPSS are all in the same ACPI PM, and I would really carefully
change behaviour for any of LPSS component driver without wide testing.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
