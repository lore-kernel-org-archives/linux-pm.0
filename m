From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] power: disable hibernation if module loading
	is disabled
Date: Fri, 4 Mar 2011 21:42:09 +0100
Message-ID: <201103042142.09247.rjw__8931.62857178158$1299271430$gmane$org@sisk.pl>
References: <1299255084-4390-1-git-send-email-segoon@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1299255084-4390-1-git-send-email-segoon@openwall.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: Len Brown <len.brown@intel.com>, security@kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, March 04, 2011, Vasiliy Kulikov wrote:
> If /proc/sys/kernel/modules_disabled is set to 1, then nobody (even full
> root) may not read/write arbitrary kernel memory.  In spite of it,
> hibernation allows anyone with an access to either /dev/snapshot or
> /sys/power/ make the full snapshot of the system.  This snapshot may be
> freely changed and uploaded back.
> 
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>

That "everyone" is actually the "full root" (in the case of /sys/power/state)
or someone having CAP_SYS_ADMIN in the /dev/snapshot case, right?

So the changelog is misleading and please fix it.

Second, there's _zero_ relationship between /proc/sys/kernel/modules_disabled
and the hibernation interface, so please find a different way to solve the
problem (if there is any).

Thanks,
Rafael


> ---
>  kernel/power/hibernate.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 1832bd2..1ac9eee 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -328,6 +328,9 @@ int hibernation_snapshot(int platform_mode)
>  {
>  	int error;
>  
> +	if (modules_disabled)
> +		return -EPERM;
> +
>  	error = platform_begin(platform_mode);
>  	if (error)
>  		goto Close;
> @@ -385,6 +388,9 @@ static int resume_target_kernel(bool platform_mode)
>  {
>  	int error;
>  
> +	if (modules_disabled)
> +		return -EPERM;
> +
>  	error = dpm_suspend_noirq(PMSG_QUIESCE);
>  	if (error) {
>  		printk(KERN_ERR "PM: Some devices failed to power down, "
> 
