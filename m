From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] base: Change power/wakeup output from "" to
	"unsupported" if wakeup feature isn't supported by a device
Date: Fri, 04 Jan 2008 08:31:01 -0800
Message-ID: <20080104163101.EDC02115203__2176.45439920506$1199464440$gmane$org@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <1199441414.19185.9.camel@yangyi-dev.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1199441414.19185.9.camel@yangyi-dev.bj.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: yi.y.yang@intel.com, pavel@ucw.cz, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> This patch changes empty output to "unsupported" in order that a user knows
> wakeup feature isn't supported by this device when he/she
> 'cat /sys/devices/.../power/wakeup', please consider to apply, thanks.

I don't much like this patch.  Not just for the technical reasons
mentioned in my previous note ... but also because it doesn't update
the documention at the top, which clearly states that "\n" is
returned for "temporary or permanent inability to issue wakeup".
And then it gives the example I gave before ...

Though I suppose a patch that changes the *entire* userspace interface,
(which includes its documentation, and all out-of-tree users) would have
shown more clearly why it wasn't a good idea.  ;)


> --- a/drivers/base/power/sysfs.c	2008-01-04 16:50:54.000000000 +0800
> +++ b/drivers/base/power/sysfs.c	2008-01-04 17:14:42.000000000 +0800
> @@ -49,7 +49,7 @@ wake_show(struct device * dev, struct de
>  {
>  	return sprintf(buf, "%s\n", device_can_wakeup(dev)
>  		? (device_may_wakeup(dev) ? enabled : disabled)
> -		: "");
> +		: "unsupported");
>  }
>  
>  static ssize_t
>
>
