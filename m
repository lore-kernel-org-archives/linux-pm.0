From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/3] thermal: imx: add necessary clk operation
Date: Thu, 19 Dec 2013 14:59:17 +0800
Message-ID: <20131219065915.GB6691@S2101-09.ap.freescale.net>
References: <1387477045-19037-1-git-send-email-b20788@freescale.com>
 <1387477045-19037-2-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1387477045-19037-2-git-send-email-b20788@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Anson Huang <b20788@freescale.com>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, eduardo.valentin@ti.com, kernel@pengutronix.de, rui.zhang@intel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 19, 2013 at 01:17:24PM -0500, Anson Huang wrote:
> @@ -427,6 +429,13 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(data->thermal_clk)) {
> +		ret = IS_ERR(data->thermal_clk);
> +		dev_err(&pdev->dev, "failed to get thermal clk!\n");
> +		return ret;
> +	}
> +

So when the new kernel runs on a board with an old DTB installed,
thermal driver will be broken.

Shawn
