From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 1/3] power: supply: Add support for the Qualcomm
 Battery Monitoring System
Date: Sat, 7 Apr 2018 09:37:21 -0700
Message-ID: <d33902cb-65d8-9790-7950-e30134f68578@infradead.org>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180407135934.26122-1-ctatlor97@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Craig Tatlor <ctatlor97@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/07/2018 06:59 AM, Craig Tatlor wrote:
> This patch adds a driver for the BMS (Battery Monitoring System)
> block of the PM8941 PMIC, it uses a lookup table defined in the
> device tree to generate a capacity from the BMS supplied OCV, it
> then ammends the coulomb counter to that to increase the accuracy
> of the estimated capacity.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> ---
>  drivers/power/supply/Kconfig    |   9 +
>  drivers/power/supply/Makefile   |   1 +
>  drivers/power/supply/qcom_bms.c | 500 ++++++++++++++++++++++++++++++++
>  3 files changed, 510 insertions(+)
>  create mode 100644 drivers/power/supply/qcom_bms.c

> diff --git a/drivers/power/supply/qcom_bms.c b/drivers/power/supply/qcom_bms.c
> new file mode 100644
> index 000000000000..5aa6e906d1b9
> --- /dev/null
> +++ b/drivers/power/supply/qcom_bms.c
> @@ -0,0 +1,500 @@

Hi,

> +static unsigned int between(int left, int right, int val)
> +{
> +	if (left <= val && val >= right)

maybe double-check those if() conditions?
[or I need my morning coffee]

> +		return 1;
> +
> +	return 0;
> +}

thanks,
-- 
~Randy
