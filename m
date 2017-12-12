From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 6/7] cpufreq: Add DVFS support for Armada 37xx
Date: Tue, 12 Dec 2017 12:54:26 +0530
Message-ID: <20171212072426.GK25177@vireshk-i7>
References: <20171207135616.23670-1-gregory.clement@free-electrons.com>
 <20171207135616.23670-7-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171207135616.23670-7-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hua Jing <jinghua-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Neta Zur Hershkovits <neta-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Evan Wang <xswang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Andre Heider <a.heider-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 07-12-17, 14:56, Gregory CLEMENT wrote:
> +/* Power management in North Bridge register set */
> +#define ARMADA_37XX_NB_L0L1	0x18
> +#define ARMADA_37XX_NB_L2L3	0x1C
> +#define	ARMADA_37XX_NB_TBG_DIV_OFF	13
> +#define	ARMADA_37XX_NB_TBG_DIV_MASK	0x7
> +#define	 ARMADA_37XX_NB_CLK_SEL_OFF	11
> +#define	 ARMADA_37XX_NB_CLK_SEL_MASK	0x1
> +#define	 ARMADA_37XX_NB_CLK_SEL_TBG      0x1
> +#define	 ARMADA_37XX_NB_TBG_SEL_OFF	9
> +#define	 ARMADA_37XX_NB_TBG_SEL_MASK	0x3
> +#define	 ARMADA_37XX_NB_VDD_SEL_OFF	6
> +#define	 ARMADA_37XX_NB_VDD_SEL_MASK	0x3
> +#define	 ARMADA_37XX_NB_CONFIG_SHIFT	16
> +#define ARMADA_37XX_NB_DYN_MOD	0x24
> +#define	 ARMADA_37XX_NB_CLK_SEL_EN	BIT(26)
> +#define	 ARMADA_37XX_NB_TBG_EN		BIT(28)
> +#define	 ARMADA_37XX_NB_DIV_EN		BIT(29)
> +#define	 ARMADA_37XX_NB_VDD_EN		BIT(30)
> +#define	 ARMADA_37XX_NB_DFS_EN		BIT(31)
> +#define ARMADA_37XX_NB_CPU_LOAD	0x30
> +#define	 ARMADA_37XX_NB_CPU_LOAD_MASK	0x3
> +#define	 ARMADA_37XX_DVFS_LOAD_0		0
> +#define	 ARMADA_37XX_DVFS_LOAD_1		1
> +#define	 ARMADA_37XX_DVFS_LOAD_2		2
> +#define	 ARMADA_37XX_DVFS_LOAD_3		3

I thought you agreed to using space instead of tab after #define ?

Looks fine otherwise. You can add below after fixing above tab/space thing:

Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
