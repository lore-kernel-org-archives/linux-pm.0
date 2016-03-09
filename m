From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V2 3/6] thermal: Add
 devm_thermal_zone_of_sensor_register() in managed devices list
Date: Wed, 9 Mar 2016 11:31:33 -0800
Message-ID: <20160309193132.GD2422@localhost.localdomain>
References: <1457529010-6538-1-git-send-email-ldewangan@nvidia.com>
 <1457529010-6538-4-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457529010-6538-4-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: rui.zhang@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, rklein@nvidia.com
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 09, 2016 at 06:40:07PM +0530, Laxman Dewangan wrote:
> The interface thermal_zone_of_sensor_register() and
> thermal_zone_of_sensor_unregister() gained their devm_
> wrappers. Add these APIs in the list of managed devices.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>


This should probably go via the documentation tree.


> 
> ---
> Changes from V1:
> - No change.
> 
>  Documentation/driver-model/devres.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
> index 5930d9a..dd7ce58 100644
> --- a/Documentation/driver-model/devres.txt
> +++ b/Documentation/driver-model/devres.txt
> @@ -342,6 +342,10 @@ SLAVE DMA ENGINE
>  SPI
>    devm_spi_register_master()
>  
> +THERMAL
> + devm_thermal_zone_of_sensor_register()
> + devm_thermal_zone_of_sensor_unregister()
> +
>  WATCHDOG
>    devm_watchdog_register_device()
>    devm_watchdog_unregister_device()
> -- 
> 2.1.4
> 
