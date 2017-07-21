From: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH v2 2/4] thermal: add brcmstb AVS TMON driver
Date: Fri, 21 Jul 2017 22:04:42 +0200
Message-ID: <1b44dcc1381fda8ab3f29c97718e9999@milecki.pl>
References: <20170721192735.6546-1-code@mmayer.net>
 <20170721192735.6546-3-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170721192735.6546-3-code@mmayer.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Mayer <code@mmayer.net>
Cc: Mark Rutland <mark.rutland@arm.com>, Device Tree List <devicetree@vger.kernel.org>, Doug Berger <opendmb@gmail.com>, Markus Mayer <mmayer@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Power Management List <linux-pm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>, Olof Johansson <olof@lixom.net>, Florian Fainelli <f.fainelli@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Brian Norris <computersforpeace@gmail.com>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

I'm far from being thermal expert, to me it looks OK, only 1 trivial 
issue
noticed (see below).


On 2017-07-21 21:27, Markus Mayer wrote:
> +static void avs_tmon_trip_enable(struct brcmstb_thermal_priv *priv,
> +				 enum avs_tmon_trip_type type, int en)
> +{
> +	struct avs_tmon_trip *trip = &avs_tmon_trips[type];
> +	u32 val = __raw_readl(priv->tmon_base + trip->enable_offs);
> +
> +	pr_debug("%sable trip, type %d\n", en ? "en" : "dis", type);

This probably could be dev_dbg?


> +static void avs_tmon_set_trip_temp(struct brcmstb_thermal_priv *priv,
> +				   enum avs_tmon_trip_type type,
> +				   int temp)
> +{
> +	struct avs_tmon_trip *trip = &avs_tmon_trips[type];
> +	u32 val, orig;
> +
> +	pr_debug("set temp %d to %d\n", type, temp);

Same here.


> +static int brcmstb_set_trips(void *data, int low, int high)
> +{
> +	struct brcmstb_thermal_priv *priv = data;
> +
> +	pr_debug("set trips %d <--> %d\n", low, high);

And the last time here.
