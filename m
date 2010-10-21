From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] apds9802als: add runtime PM support
Date: Thu, 21 Oct 2010 14:34:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010211418520.1718-100000__15024.2946380333$1287689108$gmane$org@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hong Liu <hong.liu@intel.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Alan Cox <alan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 15 Oct 2010, Alan Cox wrote:

> From: Hong Liu <hong.liu@intel.com>
> 
> 
>     Update the driver for the needed runtime power features. Remove the old
>     user controlled power functions.
> 
>     Signed-off-by: Hong Liu <hong.liu@intel.com>
>     Signed-off-by: Alan Cox <alan@linux.intel.com>

> diff --git a/drivers/misc/apds9802als.c b/drivers/misc/apds9802als.c
> index fbe4960..15f9436 100644
> --- a/drivers/misc/apds9802als.c
> +++ b/drivers/misc/apds9802als.c

> @@ -265,13 +274,34 @@ static int apds9802als_suspend(struct i2c_client *client, pm_message_t mesg)
>  
>  static int apds9802als_resume(struct i2c_client *client)
>  {
> -	struct als_data *data = i2c_get_clientdata(client);
> +	als_set_default_config(client);
> +
> +	pm_runtime_get(&client->dev);
> +	pm_runtime_put(&client->dev);
> +	return 0;
> +}

This almost certainly does not do what you think.

pm_runtime_get() will increment the device's usage count and queue an 
asynchronous resume request.  However, since the PM workqueue is frozen 
during system sleep transitions, the device will remain suspended.

The pm_runtime_put() will decrement the usage count again, but since
there is already an async resume on the queue it will not queue an
async suspend.  The final result will be that when tasks are unfrozen,
the device will finally be resumed -- long after it should have been.

It looks like what you want to do here is simply call
apds9802als_runtime_resume() directly.  And according to the advice in
Documentation/power/runtime_pm.txt section 6, you should also call

	pm_runtime_disable(dev);
	pm_runtime_set_active(dev);
	pm_runtime_enable(dev);

You probably also do not want the asynchronous calls to 
pm_runtime_get() and pm_runtime_put() in apds9802als_probe().  A more 
common sequence is:

	pm_runtime_set_active(dev);
	pm_runtime_enable(dev);

Alan Stern
