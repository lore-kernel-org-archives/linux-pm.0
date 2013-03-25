From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 07/15] ARM: cpuidle: add init/exit routine
Date: Mon, 25 Mar 2013 22:42:03 +0100
Message-ID: <20130325214203.GD631@lunn.ch>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <1364234140-514-8-git-send-email-daniel.lezcano@linaro.org>
 <20130325181038.GA631@lunn.ch>
 <51509873.1010408@linaro.org>
 <20130325190908.GC631@lunn.ch>
 <5150A378.60608@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:59297 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758665Ab3CYVnX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Mar 2013 17:43:23 -0400
Content-Disposition: inline
In-Reply-To: <5150A378.60608@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, rjw@sisk.pl, tglx@linutronix.de, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, linus.walleij@linaro.org, linux@arm.linux.org.uk

> If the DT binding was allowed, I *may* not be ARM specific but will
> certainly used only by the ARM drivers as the x86 platform uses ACPI or
> static tables.

And powerpc? Its powerpc that created DT, as far as i understand.

arch/powerpc/platforms/pseries/processor_idle.c

static int pseries_idle_devices_init(void)
{
        int i;
        struct cpuidle_driver *drv = &pseries_idle_driver;
        struct cpuidle_device *dev;

        pseries_cpuidle_devices = alloc_percpu(struct cpuidle_device);
        if (pseries_cpuidle_devices == NULL)
                return -ENOMEM;

        for_each_possible_cpu(i) {
                dev = per_cpu_ptr(pseries_cpuidle_devices, i);
                dev->state_count = drv->state_count;
                dev->cpu = i;
                if (cpuidle_register_device(dev)) {
                        printk(KERN_DEBUG \
                                "cpuidle_register_device %d failed!\n", i);
                        return -EIO;
                }
        }

        return 0;
}


This looks pretty similar to the code you are consolidating. Can your
'ARM' code be made to work on powerpc?

     Andrew

