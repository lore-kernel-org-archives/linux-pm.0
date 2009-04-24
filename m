From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [RFC Add no_suspend attribute V2] Let the driver
 know if	it's in	use
Date: Fri, 24 Apr 2009 10:31:36 -0700
Message-ID: <49F1F778.9050706@oracle.com>
References: <20090424172435.GA18448@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090424172435.GA18448@gandalf.sssup.it>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Cc: len.brown@intel.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Michael Trimarchi wrote:
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 69b4ddb..baae309 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -65,6 +65,45 @@ void device_pm_unlock(void)
>  }
>  
>  /**
> + *	device_set_no_suspend_enable - Mark the device as used by userspace
> + *	application
> + */
> +void device_set_no_suspend_enable(struct device *dev, bool enable)
> +{

Small nit:  "/**" means "this is kernel-doc notation", but the kernel-doc
notation is not correct, so please either (a) make it correct (preferred)
or (b) don't use "/**" there.

For (a), it should look more like:

/**
 * device_set_no_suspend_enable - mark the device as used by userspace application
 * @dev: the target device
 * @enable: true if the device should be marked as "no_suspend"

Please correct these as needed, especially the @enable flag.  It seems
a bit like a double negative, unfortunately.

Thanks.

-- 
~Randy
