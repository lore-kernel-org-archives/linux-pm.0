From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] pm: Add runtime PM statistics
Date: Sun, 11 Jul 2010 23:26:07 +0200
Message-ID: <201007112326.07541.rjw__5281.45729699663$1278883772$gmane$org@sisk.pl>
References: <20100710095254.5ab7291c@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100710095254.5ab7291c@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, July 10, 2010, Arjan van de Ven wrote:
> From: Arjan van de Ven <arjan@linux.intel.com>
> Subject: [PATCH v2] pm: Add runtime PM statistics
> 
> In order for PowerTOP to be able to report how well the new runtime PM is working
> for the various drivers, the kernel needs to export some basic statistics in sysfs.
> 
> This patch adds two sysfs files in the runtime PM domain that expose the
> total time a device has been active, and the time a device has been suspended.
> 
> With this PowerTOP can compute the activity percentage
> 
> Active %age = 100 * (delta active) / (delta active + delta suspended)
> 
> and present the information to the user.
> 
> I've written the PowerTOP code (slated for version 1.12) already, and the output looks
> like this:
> 
> Runtime Device Power Management statistics
> Active  Device name
>  10.0%	06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8101E/RTL8102E PCI Express Fast Ethernet controller 
> 
> 
> 
> [version 2: fix stat update bugs noticed by Alan Stern]
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index b0ec0e9..b78c401 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
...
>  
> +static ssize_t rtpm_active_time_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	int ret;
> +	spin_lock_irq(&dev->power.lock);
> +	update_pm_runtime_accounting(dev);
> +	ret = sprintf(buf, "%i\n", jiffies_to_msecs(dev->power.active_jiffies));
> +	spin_unlock_irq(&dev->power.lock);
> +	return ret;
> +}
> +
> +static ssize_t rtpm_suspended_time_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	int ret;
> +	spin_lock_irq(&dev->power.lock);
> +	update_pm_runtime_accounting(dev);
> +	ret = sprintf(buf, "%i\n",
> +		jiffies_to_msecs(dev->power.suspended_jiffies));
> +	spin_unlock_irq(&dev->power.lock);
> +	return ret;
> +}
> +
>  static DEVICE_ATTR(runtime_usage, 0444, rtpm_usagecount_show, NULL);
>  static DEVICE_ATTR(runtime_active_kids, 0444, rtpm_children_show, NULL);
>  static DEVICE_ATTR(runtime_status, 0444, rtpm_status_show, NULL);
> +static DEVICE_ATTR(runtime_active_time, 0444, rtpm_active_time_show, NULL);
> +static DEVICE_ATTR(runtime_suspended_time, 0444, rtpm_suspended_time_show, NULL);
>  static DEVICE_ATTR(runtime_enabled, 0444, rtpm_enabled_show, NULL);

On a second thought, "active_time" and "suspended_time" should be sufficient
(ie. the "runtime_" prefix is not really necessary).

Rafael
