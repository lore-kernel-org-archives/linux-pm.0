From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] power: vexpress: fix corruption in notifier registration
Date: Mon, 18 Jun 2018 15:56:08 +0100
Message-ID: <20180618145608.GA26780@e107981-ln.cambridge.arm.com>
References: <1529322007-4637-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1529322007-4637-1-git-send-email-sudeep.holla@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Liviu Dudau <liviu.dudau@arm.com>, Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 18, 2018 at 12:40:07PM +0100, Sudeep Holla wrote:
> Vexpress platforms provide two different restart handlers: SYS_REBOOT
> that restart the entire system, while DB_RESET only restarts the
> daughter board containing the CPU. DB_RESET is overridden by SYS_REBOOT
> if it exists.
> 
> notifier_chain_register used in register_restart_handler by design
> allows notifier to be registered once only, however vexpress restart
> notifier can get registered twice.

Nit: I would say "notifier_chain_register() relies on notifiers to be
registered only once to work properly"; put it differently, it allows
notifiers to be registered twice (ie it does nothing to prevent it),
that's why we have this issue.

> When this happen it corrupts list of notifiers, as result some
> notifiers can be not called on proper event, traverse on list can be
> cycled forever, and second unregister can access already freed memory.
> 
> So far, since this was the only restart handler in the system, no issue
> was observed even if the same notifier was registered twice. However
> commit 6c5c0d48b686 ("watchdog: sp805: add restart handler") added
> support for SP805 restart handlers and since the system under test
> contains two vexpress restart and two SP805 watchdog instances, it was
> observed that during the boot traversing the restart handler list looped
> forever as there's a cycle in that list resulting in boot hang.
> 
> This patch fixes the issues by ensuring that the notifier is installed
> only once.
> 
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/power/reset/vexpress-poweroff.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
> index 102f95a09460..cdc68eb06a91 100644
> --- a/drivers/power/reset/vexpress-poweroff.c
> +++ b/drivers/power/reset/vexpress-poweroff.c
> @@ -35,6 +35,7 @@ static void vexpress_reset_do(struct device *dev, const char *what)
>  }
>  
>  static struct device *vexpress_power_off_device;
> +static atomic_t vexpress_restart_nb_refcnt = ATOMIC_INIT(0);
>  
>  static void vexpress_power_off(void)
>  {
> @@ -96,13 +97,16 @@ static const struct of_device_id vexpress_reset_of_match[] = {
>  
>  static int _vexpress_register_restart_handler(struct device *dev)
>  {
> -	int err;
> +	int err = 0;

Nit: I do not not see why you need to initialize err.

>  	vexpress_restart_device = dev;

It is unclear to me how the !vexpress_restart_device sentinel is
used while registering FUNC_RESET. It is unrelated to this patch
but if the registration below fails for FUNC_REBOOT can we end
up in a situation where vexpress_restart_device is initialized
with no restart handler registered ?

By looking at it I am not a big fan of the vexpress_restart_device
global variable it has been there since we merged this code but
its usage is a bit obscure.

Anyway, thanks for having a look and fixing the issue.

Lorenzo

> -	err = register_restart_handler(&vexpress_restart_nb);
> -	if (err) {
> -		dev_err(dev, "cannot register restart handler (err=%d)\n", err);
> -		return err;
> +	if (atomic_inc_return(&vexpress_restart_nb_refcnt) == 1) {
> +		err = register_restart_handler(&vexpress_restart_nb);
> +		if (err) {
> +			dev_err(dev, "cannot register restart handler (err=%d)\n", err);
> +			atomic_dec(&vexpress_restart_nb_refcnt);
> +			return err;
> +		}
>  	}
>  	device_create_file(dev, &dev_attr_active);
>  
> -- 
> 2.7.4
> 
