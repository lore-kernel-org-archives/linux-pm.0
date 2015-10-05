From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v6 3/6] power: Add support for DA9150 Fuel-Gauge
Date: Mon, 5 Oct 2015 13:10:12 -0300
Message-ID: <CAOMZO5BnrNrXnuVOdhtNXsmgtm4KVVzs41g3CfZX9penEHLutg@mail.gmail.com>
References: <cover.1444059987.git.Adam.Thomson.Opensource@diasemi.com>
	<80d467703ba19bef12e9bcdd246e1de7bd33a8b1.1444059987.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <80d467703ba19bef12e9bcdd246e1de7bd33a8b1.1444059987.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 5, 2015 at 1:03 PM, Adam Thomson
<Adam.Thomson.Opensource@diasemi.com> wrote:

> +       /* Register IRQ */
> +       irq = platform_get_irq_byname(pdev, "FG");
> +       if (irq < 0) {
> +               dev_err(dev, "Failed to get IRQ FG: %d\n", irq);

You need to do "ret = irq" here. Otherwise you will return success in irq_fail.

> +               goto irq_fail;
