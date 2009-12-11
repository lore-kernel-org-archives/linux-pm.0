From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] PM: Fix kernel-doc notation
Date: Fri, 11 Dec 2009 12:02:59 -0800
Message-ID: <20091211120259.82de239d.randy.dunlap__12312.7513252713$1260561953$gmane$org@oracle.com>
References: <1258877637.4495.45.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1258877637.4495.45.camel@ht.satnam>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 22 Nov 2009 13:43:57 +0530 Jaswinder Singh Rajput wrote:

> 
> Fix the following htmldocs warnings:
> 
>   Warning(drivers/base/power/main.c:249): No description found for parameter 'master'
>   Warning(drivers/base/power/main.c:249): Excess function parameter 'slave' description in 'device_pm_wait_for_slaves'
>   Warning(drivers/base/power/main.c:292): No description found for parameter 'master'
>   Warning(drivers/base/power/main.c:292): Excess function parameter 'slave' description in 'device_pm_check_slaves'
> 
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Randy Dunlap <randy.dunlap@oracle.com>

What tree was this for?
I guess it's not needed now, I can't find these functions..

Thanks.

> ---
>  drivers/base/power/main.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index e8d1ea6..5f13084 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -243,7 +243,7 @@ static void device_pm_wait_for_masters(struct device *slave)
>  
>  /**
>   * device_pm_wait_for_slaves - Wait for all slaves of given device.
> - * @slave: Device to wait for the slaves of.
> + * @master: Device to wait for the slaves of.
>   */
>  static void device_pm_wait_for_slaves(struct device *master)
>  {
> @@ -286,7 +286,7 @@ static int device_pm_check_masters(struct device *slave)
>  
>  /**
>   * device_pm_check_slaves - Check power.op_complete for slaves of a device.
> - * @slave: Device to check the slaves of.
> + * @master: Device to check the slaves of.
>   */
>  static int device_pm_check_slaves(struct device *master)
>  {
> -- 

---
~Randy
