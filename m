From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 6/9] drivers: remove useless comment from
 base/arch_topology.c
Date: Mon, 10 Apr 2017 14:51:03 +0100
Message-ID: <20170410135103.GR17774@n2100.armlinux.org.uk>
References: <20170327131825.32134-1-juri.lelli@arm.com>
 <20170327131825.32134-7-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36328 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbdDJNvS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 09:51:18 -0400
Content-Disposition: inline
In-Reply-To: <20170327131825.32134-7-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org

On Mon, Mar 27, 2017 at 02:18:22PM +0100, Juri Lelli wrote:
> Printing out an error message when we failed to get the cpu device is
> not helping anyone. Remove it.

(1) the subject line talks about removing a "comment" but you're
    actually removing an error printk
(2) I don't think it's "not helping anyone", although the description
    above doesn't say _why_ - it's reporting the lack of a missing CPU
    device that we expect to be present.  If it's not present, then
    we're not going to end up with the cpu capacity attribute, and the
    error message answers the "why is that sysfs file missing" question.

I think a better commit message is needed for this change.

> 
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  drivers/base/arch_topology.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index c33482121b7d..b24d9a2af2c5 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -81,11 +81,9 @@ static int register_cpu_capacity_sysctl(void)
>  
>  	for_each_possible_cpu(i) {
>  		cpu = get_cpu_device(i);
> -		if (!cpu) {
> -			pr_err("%s: too early to get CPU%d device!\n",
> -			       __func__, i);
> +		if (!cpu)
>  			continue;
> -		}
> +
>  		device_create_file(cpu, &dev_attr_cpu_capacity);
>  	}
>  
> -- 
> 2.10.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
