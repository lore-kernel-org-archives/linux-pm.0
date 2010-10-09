From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] intel_idle: Set dev->power_specified
Date: Sat, 9 Oct 2010 23:01:06 +0200
Message-ID: <20101009230106.5bb84133@endymion.delvare>
References: <20101008174445.353eb83e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101008174445.353eb83e@endymion.delvare>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi again Len,

On Fri, 8 Oct 2010 17:44:45 +0200, Jean Delvare wrote:
> The intel_idle driver defines power consumption for all states, but
> they can't be seen in sysfs because the driver doesn't set
> dev->power_specified, while the idle code expects that.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Len Brown <lenb@kernel.org>
> ---
> This is the simple fix. But in all honesty, I don't get the point of
> dev->power_specified. It should be equally easy to check if the first
> state's .power has a non-zero value, and at least this doesn't require
> any cooperation from the driver. As it stands, I expect that future
> drivers will have the same problem intel_idle had, i.e. they will
> forget to set dev->power_specified and power consumption values
> won't be visible in syfs.

Apparently I couldn't be more right: the acpi/processor_idle driver
also doesn't set dev->power_specified even if power consumption values
are available. Grepping the whole kernel source tree, it appears that
none of the cpuidle drivers sets dev->power_specified, so I'm not sure
if that code path was even tested (at least it works for me...)

Good news is that it means that getting rid of that flag should be
easy, if you agree with that approach.

> 
> Am I missing any obvious problem? If not, I'll be happy to provide an
> alternative patch dropping dev->power_specified altogether.
> 
>  drivers/idle/intel_idle.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-2.6.36-rc7.orig/drivers/idle/intel_idle.c	2010-10-07 08:53:05.000000000 +0200
> +++ linux-2.6.36-rc7/drivers/idle/intel_idle.c	2010-10-08 16:16:41.000000000 +0200
> @@ -369,6 +369,7 @@ static int intel_idle_cpuidle_devices_in
>  			dev->state_count += 1;
>  		}
>  
> +		dev->power_specified = 1;
>  		dev->cpu = i;
>  		if (cpuidle_register_device(dev)) {
>  			pr_debug(PREFIX "cpuidle_register_device %d failed!\n",

-- 
Jean Delvare
