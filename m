From: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Subject: Re: [PATCH] i2c: Factor out runtime suspend checks from
	PM operations
Date: Tue, 04 Jan 2011 15:07:37 -0800
Message-ID: <4D23A839.6030205__31122.3894627348$1294270523$gmane$org@codeaurora.org>
References: <1293712813-4090-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1293712813-4090-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Mark Brown wrote:
> When devices use dev_pm_ops the I2C API is implementing standard functionality
> for integration with runtime PM and for checking for the presence of a per
> device op. The PM core provides pm_generic_ functions implementing this
> behaviour - use them to reduce coupling with future PM updates.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/i2c/i2c-core.c |   68 ++++++++++++++---------------------------------
>  1 files changed, 20 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 6b4cc56..6793c51 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -196,88 +196,60 @@ static int i2c_device_pm_suspend(struct device *dev)
>  {
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> -	if (pm) {
> -		if (pm_runtime_suspended(dev))
> -			return 0;
> -		else
> -			return pm->suspend ? pm->suspend(dev) : 0;
> -	}
> -
> -	return i2c_legacy_suspend(dev, PMSG_SUSPEND);
> +	if (pm)
> +		return pm_generic_suspend(dev);


pm_generic_suspend() and others needs to be externed in linux/pm_runtime.h?

--
Sent by an employee of the Qualcomm Innovation Center, Inc. The Qualcomm 
Innovation Center, Inc. is a member of the Code Aurora Forum.
