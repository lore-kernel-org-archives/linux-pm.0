From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH/RFC 5/6] staging: board: Add support for devices with
 complex dependencies
Date: Fri, 3 Apr 2015 15:57:27 +0300
Message-ID: <20150403125727.GT10964@mwanda>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
 <1428064923-24950-6-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1428064923-24950-6-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devel@driverdev.osuosl.org, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-pm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-sh@vger.kernel.org, Magnus Damm <damm+renesas@opensource.se>, linux-kernel@vger.kernel.org, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 03, 2015 at 02:42:02PM +0200, Geert Uytterhoeven wrote:
> +int __init board_staging_register_clock(const struct board_staging_clk *bsc)
> +{
> +	struct clk *clk;
> +	int error;
> +
> +	pr_debug("Registering clock %s for con_id %s dev_id %s\n", bsc->clk,
> +		 bsc->con_id, bsc->dev_id);
> +	clk = clk_get(NULL, bsc->clk);
> +	if (IS_ERR(clk)) {
> +		error = PTR_ERR(clk);
> +		pr_err("Failed to get clock %s (%d)\n", bsc->clk, error);
> +		return error;
> +	}
> +
> +	error = clk_register_clkdev(clk, bsc->con_id, bsc->dev_id);
> +	if (error)
> +		pr_err("Failed to register clock %s (%d)\n", bsc->clk, error);
> +		return error;

Missing curly braces.  Also it's weird that don't we need a clk_put()
on the error patch as well as the success path?

> +
> +	clk_put(clk);
> +	return 0;
> +}


regards,
dan carpenter
