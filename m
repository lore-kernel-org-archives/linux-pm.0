From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] mfd: cros: add charger port count command definition
Date: Mon, 4 Jun 2018 09:59:00 +0100
Message-ID: <20180604085900.GN25455@dell>
References: <20180530031704.18597-1-fparent@baylibre.com>
 <20180530031704.18597-2-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180530031704.18597-2-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, eballetbo@gmail.com, gpain@baylibre.com
List-Id: linux-pm@vger.kernel.org

On Tue, 29 May 2018, Fabien Parent wrote:

> A new more command has been added to the ChromeOS embedded controller
> that allows to get the number of charger port count. Unlike
> EC_CMD_USB_PD_PORTS, this new command also includes the dedicated
> port if present.
> 
> This command will be used to expose the dedicated charger port
> in the ChromeOS charger driver.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  include/linux/mfd/cros_ec_commands.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Does not want to apply.  I didn't investigate why.

Please rebase and resend?
-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
