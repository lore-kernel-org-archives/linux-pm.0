From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] cpufreq: Add Broadcom BCM2835 CPU frequency control
 driver
Date: Tue, 20 Oct 2015 20:54:23 -0600
Message-ID: <5626FE5F.8060209@wwwdotorg.org>
References: <1444592815-15271-1-git-send-email-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1444592815-15271-1-git-send-email-lkundrak@v3.sk>
Sender: cpufreq-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-rpi-kernel@lists.infradead.org, Dom Cobley <popcornmix@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/11/2015 01:46 PM, Lubomir Rintel wrote:
> This adds a device tree binding for Broadcom BCM2834 CPU frequency
> control driven via Raspberry Pi VideoCore 4 firmware interface.

I don't see any DT binding here; there's a new driver and an addition to
a DT file.

This looks like it should be 3 separate patches:

1) Document the DT binding for this driver.
(This one needs to be reviewed by the DT maintainers and sent to the DT
mailing list).

2) Add the driver

3) Add the relevant nodes/properties to the DT files.

Patch 2 would typically be applied by the cpufreq maintainer, and patch
3 by the RPi maintainer.

> diff --git a/drivers/cpufreq/bcm2835-cpufreq.c b/drivers/cpufreq/bcm2835-cpufreq.c
> new file mode 100644
> index 0000000..0fc4cb5
> --- /dev/null
> +++ b/drivers/cpufreq/bcm2835-cpufreq.c
> @@ -0,0 +1,199 @@
> +/*
> + * This driver dynamically manages the CPU Frequency of the ARM processor.
> + * Messages are sent to Videocore either setting or requesting the
> + * frequency of the ARM in order to match an appropriate frequency to the
> + * current usage of the processor. The policy which selects the frequency
> + * to use is defined in the kernel .config file, but can be changed during
> + * runtime.
> + *
> + * Copyright 2011 Broadcom Corporation.  All rights reserved.
> + * Copyright 2013,2015 Lubomir Rintel
> + *
> + * Unless you and Broadcom execute a separate written software license
> + * agreement governing use of this software, this software is licensed to you
> + * under the terms of the GNU General Public License version 2, available at
> + * http://www.broadcom.com/licenses/GPLv2.php (the "GPL").
> + *
> + * Notwithstanding the above, under no circumstances may you combine this
> + * software in any way with any other Broadcom software provided under a
> + * license other than the GPL, without Broadcom's express prior written
> + * consent.
> + */

That license doesn't sound right for the kernel. IANAL, but it sounds
like you (Lubomir) can choose to accept the code under GPLv2 and strip
out all the other license text. If the last paragraph absolutely has to
be maintained in the code, I'm not sure that this license is
GPL-compatible since it imposes additional restrictions beyond the GPL.

> +static u32 bcm2835_cpufreq_set_clock(int cur_rate, int arm_rate)
> +{
> +	int ret = 0;
> +	struct prop msg = {
> +		.dev_id = VCMSG_ID_ARM_CLOCK,
> +		.val = arm_rate * 1000,
> +	};
> +
> +	/* send the message */
> +	ret = rpi_firmware_property(fw, VCMSG_SET_CLOCK_RATE, &msg,
> +							sizeof(msg));

Why does this driver call the firmware directly, rather than using the
clock API?

> +static int bcm2835_cpufreq_target(struct cpufreq_policy *policy,
> +						unsigned int target_freq,
> +						unsigned int relation)
> +{
> +	unsigned int target = target_freq;
> +	u32 cur;
> +
> +	/* if we are above min and using ondemand, then just use max */
> +	if (strcmp("ondemand", policy->governor->name) == 0 &&
> +					target > policy->min)
> +		target = policy->max;

This sounds like a policy decision. Shouldn't the governer implement
policy, and this driver just do what it's told?

> +static struct platform_driver bcm2835_cpufreq_driver = {
> +	.probe = bcm2835_cpufreq_probe,
> +	.remove = bcm2835_cpufreq_remove,
> +	.driver = {
> +		.name = "bcm2835-cpufreq",
> +		.owner = THIS_MODULE,

I think you don't need that .owner line any more.

> +MODULE_LICENSE("GPL v2");

That doesn't match the license header in this file.
