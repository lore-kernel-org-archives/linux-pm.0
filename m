From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 07/15] PM QoS: add a global notification
	mechanism for the device constraints
Date: Tue, 16 Aug 2011 23:44:01 +0200
Message-ID: <201108162344.02059.rjw__29392.7104947672$1313531075$gmane$org@sisk.pl>
References: <1313502198-9298-1-git-send-email-j-pihet@ti.com>
	<1313502198-9298-8-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1313502198-9298-8-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: jean.pihet@newoldbits.com
Cc: markgross@thegnar.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday, August 16, 2011, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Add a global notification chain that gets called upon changes to the
> aggregated constraint value for any device.
> The notification callbacks are passing the full constraint request data
> in order for the callees to have access to it. The current use is for the
> platform low-level code to access the target device of the constraint.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  drivers/base/power/qos.c |   84 ++++++++++++++++++++++++++++++++++++----------
>  include/linux/pm_qos.h   |   11 ++++++
>  kernel/power/qos.c       |    2 +-
>  3 files changed, 78 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index 304d68d..b52b3e8 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -8,6 +8,12 @@
>   *
>   * This QoS design is best effort based. Dependents register their QoS needs.
>   * Watchers register to keep track of the current QoS needs of the system.
> + * Watchers can register different types of notification callbacks:
> + *  . a per-device notification callback using the dev_pm_qos_*_notifier API.
> + *    The notification chain data is stored in the per-device constraint
> + *    data struct.
> + *  . a system-wide notification callback using the dev_pm_qos_*_global_notifier
> + *    API. The notification chain data is stored in a static variable.
>   *
>   * Note about the per-device constraint data struct allocation:
>   * . The per-device constraints data struct ptr is tored into the device
> @@ -36,8 +42,32 @@
>  
>  
>  static DEFINE_MUTEX(dev_pm_qos_mtx);
> +static BLOCKING_NOTIFIER_HEAD(dev_pm_notifiers);
>  static void dev_pm_qos_constraints_allocate(struct device *dev);
>  
> +/*
> + * Update the constraints list using the PM QoS core code and
> + * if needed call the per-device and the global notification callbacks
> + */

Well, if you add kerneldoc comments, please make them follow the standard,
even if that's a static function.

> +static int _apply_constraint(struct dev_pm_qos_request *req,

The initial underscore looks odd and is not really necessary.  Please drop it.

The rest of the patch looks fine.

Thanks,
Rafael
