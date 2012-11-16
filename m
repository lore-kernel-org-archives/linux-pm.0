From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v8 1/3] Runtime Interpreted Power Sequences
Date: Thu, 15 Nov 2012 23:26:43 -0800
Message-ID: <20121116072642.GA22291@lizard>
References: <1353047903-14363-1-git-send-email-acourbot@nvidia.com>
 <1353047903-14363-2-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353047903-14363-2-git-send-email-acourbot@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Stephen Warren <swarren@nvidia.com>, Thierry Reding <thierry.reding@avionic-design.de>, Mark Zhang <markz@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Leela Krishna Amudala <l.krishna@samsung.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-pm@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Alexandre,

The code looks neat, thanks for you work!

Just a couple of comments...

On Fri, Nov 16, 2012 at 03:38:21PM +0900, Alexandre Courbot wrote:
[...]
> +
> +#include "power_seq_delay.c"
> +#include "power_seq_regulator.c"
> +#include "power_seq_pwm.c"
> +#include "power_seq_gpio.c"

This is odd, although I remember you already explained why you have to
include the .c files, instead of linking them separately. But I forgot the
reason. :) I think this deserves a comment in the code.

> +static int of_power_seq_parse_step(struct device *dev,
> +				   struct device_node *node,
> +				   struct power_seq *seq,
> +				   unsigned int step_nbr,
> +				   struct list_head *resources)
> +{
> +	struct power_seq_step *step = &seq->steps[step_nbr];
> +	struct power_seq_resource res, *res2;
> +	const char *type;
> +	int i, err;

nit: one variable declaration per line.

Thanks,
Anton.
