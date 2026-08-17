Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BB13101A7;
	Mon, 17 Aug 2026 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952804; cv=none; b=TGDSjb0qUR/OnsNy4QCYELCjrydJS6SFKEa9wTk+2oYiajLVGBXXaVFaMKEU1YlNAUB2pkRM2bxhqUqaKbJwLEsShSwT7ztkIEwYS8KgL2QCpl4yrEcMlewlgS5gF6Kgae2siNSuEJZUElIHXkCzmotblfYH5+/nDUNrJq8JQpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952804; c=relaxed/simple;
	bh=8vWiXpScq39hM+f+57eyev3yKiD8nXRZiw2/bh4X5LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2ZZdReAGN+BBKihFiQ3KBMiplwYI+XsqWOujvXqJnakWKzb+VigL4URO+nAB3iu4n3O5u+m0MphRA5HmX1x1G3kRBxoXUxtTAGU33CbxiJm+0+sv8zgX+PlIXnHGGuTmAqyXlk6FnVwQbjvCHoZwDfsE+KNJ6hQ0xOUQ6r1X1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zk+9phQQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zk+9phQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7661F000E9;
	Mon, 17 Aug 2026 07:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786952803;
	bh=EfzfZ3WFooba752OuvZMCcFBHXXIRsa37HjAsyNE0TM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zk+9phQQRNSb/xXRC+ZbXYah0twgvdAlKB1i7wThBkJh1zKJyxZ+igC8PDxYM+XEw
	 oJsSi3OI9uC5pQ10sQCv+t1nNKxMEqcTgNbp3dhEe0H1P07yNteDmQ2gXe3WVG6bTP
	 C0KA8ERlexcwKVKGNm7AG/kRzI2n3pI7y3y9lw80wdL57bgympvIkuvlaTfaeL03wF
	 SaM9SzerN0sBIpkzkLq/e6EjX+t56qlvCqnoMOpYIc30DvccHVBO2JYxBRbhOqAQJ+
	 SQFFcE/Ls2uBeaC1Pf31ZSnX6Z0FLi/Ep/I+Zecpzz0RFED45BCWq2/e1p5M6Rvx7O
	 ZYzgqXkyRRGdg==
Date: Mon, 17 Aug 2026 09:46:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PM / devfreq: add Airoha SoC devfreq driver
Message-ID: <20260817-strange-belligerent-gazelle-d55c5c@quoll>
References: <20260810143057.651478-1-ansuelsmth@gmail.com>
 <20260810143057.651478-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810143057.651478-2-ansuelsmth@gmail.com>

On Mon, Aug 10, 2026 at 04:30:55PM +0200, Christian Marangi wrote:
> Add simple Airoha SoC devfreq driver. This simple driver register a
> driver from a given clock and register a passive governor to scale the
> frequency with the CPU frequency.
> 
> required-opp on the CPU frequency will be used to correctly bind the
> clock to the related CPU frequency.
> 
> GSW, NPU, SOE, BUS and many other clock will register this devfreq
> driver to scale all these internal peripheral  from idle to performance
> mode.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/devfreq/Kconfig          | 10 ++++
>  drivers/devfreq/Makefile         |  1 +
>  drivers/devfreq/airoha-devfreq.c | 99 ++++++++++++++++++++++++++++++++
>  3 files changed, 110 insertions(+)
>  create mode 100644 drivers/devfreq/airoha-devfreq.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index c999c4a1e567..1e857a7e9caf 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -75,6 +75,16 @@ config DEVFREQ_GOV_PASSIVE
>  
>  comment "DEVFREQ Drivers"
>  
> +config ARM_AIROHA_DEVFREQ
> +	tristate "Scaling support for Airoha SoC"
> +	depends on ARCH_AIROHA || COMPILE_TEST
> +	select DEVFREQ_GOV_PASSIVE
> +	help
> +	  This adds the DEVFREQ driver for the Airoha SoC.
> +
> +	  The driver register with the cpufreq notifier and find the right frequency
> +	  based on the required OPP set in DT.
> +
>  config ARM_EXYNOS_BUS_DEVFREQ
>  	tristate "ARM Exynos Generic Memory Bus DEVFREQ Driver"
>  	depends on ARCH_EXYNOS || COMPILE_TEST
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 404179d79a9d..5ca27684dee3 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
>  obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>  
>  # DEVFREQ Drivers
> +obj-$(CONFIG_ARM_AIROHA_DEVFREQ)	+= airoha-devfreq.o
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>  obj-$(CONFIG_ARM_HISI_UNCORE_DEVFREQ)	+= hisi_uncore_freq.o
>  obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)	+= imx-bus.o
> diff --git a/drivers/devfreq/airoha-devfreq.c b/drivers/devfreq/airoha-devfreq.c
> new file mode 100644
> index 000000000000..cb6d8b49e4a4
> --- /dev/null
> +++ b/drivers/devfreq/airoha-devfreq.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/cpufreq.h>
> +#include <linux/devfreq.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/slab.h>
> +#include <linux/pm_opp.h>
> +
> +struct airoha_devfreq_data {
> +	struct clk *clk;
> +
> +	struct devfreq_passive_data gov_data;
> +};
> +
> +static int airoha_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
> +{
> +	struct airoha_devfreq_data *data = dev_get_drvdata(dev);
> +
> +	*freq = clk_get_rate(data->clk);
> +
> +	return 0;
> +};
> +
> +static int airoha_devfreq_target(struct device *dev, unsigned long *freq,
> +				 u32 flags)
> +{
> +	struct airoha_devfreq_data *data = dev_get_drvdata(dev);
> +
> +	return clk_set_rate(data->clk, *freq);
> +};

Some odd copy-paste.

Anyway, your driver is heavily incomplete. You can scale the clock
directly from each device driver (each should register devfreq). You do
not need completely new driver for that.

Best regards,
Krzysztof

