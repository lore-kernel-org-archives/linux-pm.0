From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] v2 pm: clk: fix a missing check of clk_prepare
Date: Wed, 16 Jan 2019 13:00:54 +0100
Message-ID: <1699761.45DYuq6sLL@aspire.rjw.lan>
References: <20190105195845.5453-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105195845.5453-1-pakki001@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Pakki <pakki001@umn.edu>
Cc: kjlu@umn.edu, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, January 5, 2019 8:58:45 PM CET Aditya Pakki wrote:
> clk_prepare() could fail, so let's check its status, and if it fails,
> issue an error message and change the clock_entry_status to
> PCE_STATUS_ERROR
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/base/power/clock_ops.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index 5a42ae4078c2..732764becafe 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -65,10 +65,15 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
>  	if (IS_ERR(ce->clk)) {
>  		ce->status = PCE_STATUS_ERROR;
>  	} else {
> -		clk_prepare(ce->clk);
> -		ce->status = PCE_STATUS_ACQUIRED;
> -		dev_dbg(dev, "Clock %pC con_id %s managed by runtime PM.\n",
> -			ce->clk, ce->con_id);
> +		if (clk_prepare(ce->clk)) {
> +			ce->status = PCE_STATUS_ERROR;
> +			dev_err(dev, "clk_prepare failed\n");
> +		} else {
> +			ce->status = PCE_STATUS_ACQUIRED;
> +			dev_dbg(dev,
> +				"Clock %pC con_id %s managed by runtime PM.\n",
> +				ce->clk, ce->con_id);
> +		}
>  	}
>  }
>  
> 

Applied (with some minor modifications), thanks!
