From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / wakeirq: check that wake IRQ is valid before accepting it
Date: Sat, 14 Nov 2015 01:11:42 +0100
Message-ID: <2411616.tZ7ojtyi3G@vostro.rjw.lan>
References: <20151112182657.GA19785@dtor-ws> <5644DD73.2090904@ti.com> <20151112185211.GB8494@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151112185211.GB8494@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, November 12, 2015 10:52:11 AM Dmitry Torokhov wrote:
> On Thu, Nov 12, 2015 at 08:41:55PM +0200, Grygorii Strashko wrote:
> > On 11/12/2015 08:26 PM, Dmitry Torokhov wrote:
> > >Check that IRQ number passed to dev_pm_set_wake_irq and
> > >dev_pm_set_dedicated_wake_irq is valid (not negative) before accepting it.
> > >
> > >Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > >---
> > >
> > >My recent change to i2c core introduced a code path that led to calling
> > >dev_pm_set_wake_irq(&client->dev, -ENOENT), which succeeded but
> > >obviously did the wrong thing. Checking the IRQ and bailing out early
> > >would have helped noticing this issue earlier.
> > >
> > >  drivers/base/power/wakeirq.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > >diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> > >index eb6e674..0d77cd6 100644
> > >--- a/drivers/base/power/wakeirq.c
> > >+++ b/drivers/base/power/wakeirq.c
> > >@@ -68,6 +68,9 @@ int dev_pm_set_wake_irq(struct device *dev, int irq)
> > >  	struct wake_irq *wirq;
> > >  	int err;
> > >
> > >+	if (irq < 0)
> > 
> > <= 0 ?
> 
> Maybe. I am still confused whether we treat 0 as invalid or not.

Well, it all boils down to whether or not IRQ 0 may be a valid wakeup IRQ
on any architectures.

In any case, though, we can add that check later, so I'll apply the patch
as is.

Thanks,
Rafael
