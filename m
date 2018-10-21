From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFC PATCH v2 02/17] soc/tegra: fuse: Export tegra_get_chip_id()
Date: Mon, 22 Oct 2018 00:33:23 +0300
Message-ID: <23d8d451-ec25-d557-660b-bdce90fcefb0@gmail.com>
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-3-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021205501.23943-3-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/21/18 11:54 PM, Dmitry Osipenko wrote:
> This function is used by tegra20-cpufreq driver which can be built as a
> kernel module.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/soc/tegra/fuse/tegra-apbmisc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
> index e5a4d8f98b10..c94dccf3eb30 100644
> --- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
> +++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
> @@ -51,6 +51,7 @@ u8 tegra_get_chip_id(void)
>  {
>  	return (tegra_read_chipid() >> 8) & 0xff;
>  }
> +EXPORT_SYMBOL_GPL(tegra_get_chip_id);
>  
>  u32 tegra_read_straps(void)
>  {
> 

A quick note.. I just recalled about existence of the of_machine_is_compatible() which will be more appropriate to use in the driver, hence this patch won't be needed.
