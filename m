From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Wed, 23 Oct 2013 15:51:16 +0200
Message-ID: <20131023135116.GC31126@lunn.ch>
References: <1382533461-31021-1-git-send-email-andrew@lunn.ch>
 <CAKohpombg7mAmgxxvUg8kz1MaFwcycR1eL0UrgELY2WdGfrAag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:43400 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163Ab3JWNzv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 23 Oct 2013 09:55:51 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpombg7mAmgxxvUg8kz1MaFwcycR1eL0UrgELY2WdGfrAag@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Oct 23, 2013 at 07:10:41PM +0530, Viresh Kumar wrote:
> On 23 October 2013 18:34, Andrew Lunn <andrew@lunn.ch> wrote:
> > The Marvell Dove SoC can run the CPU at two frequencies. The high
> > frequencey is from a PLL, while the lower is the same as the DDR
> > clock. Add a cpufreq driver to swap between these frequences.
> >
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > ---
> > Sort header files
> > Comment the interrupt handler
> 
> Really? I don't see these two comments being incorporated..
> Also, you would be required to update your patchset ones my
> patches are in (And that will happen for v3.13)..

+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <asm/proc-fns.h>

There does seem to be a convention that kernel.h and module.h come
first, and then i have the rest in order. 

+/*
+ * Handle the interrupt raised when the frequency change is
+ * complete.
+ */
+static irqreturn_t dove_cpufreq_irq(int irq, void *dev)
+{
+       return IRQ_HANDLED;
+}

What more would you like to see in the comment?

Thanks
     Andrew


