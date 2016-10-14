From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: Re: [PATCH 2/3] thermal: tango: Fix module autoload
Date: Fri, 14 Oct 2016 17:27:30 +0200
Message-ID: <5800F962.8040605@sigmadesigns.com>
References: <1476455702-21748-1-git-send-email-javier@osg.samsung.com>
 <1476455702-21748-3-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1476455702-21748-3-git-send-email-javier@osg.samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 14/10/2016 16:35, Javier Martinez Canillas wrote:

> If the driver is built as a module, autoload won't work because the module
> alias information is not filled. So user-space can't match the registered
> device with the corresponding module.
> 
> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
> 
> Before this patch:
> 
> $ modinfo drivers/thermal/tango_thermal.ko | grep alias
> $
> 
> After this patch:
> 
> $ modinfo drivers/thermal/tango_thermal.ko | grep alias
> alias:          of:N*T*Csigma,smp8758-thermalC*
> alias:          of:N*T*Csigma,smp8758-thermal
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  drivers/thermal/tango_thermal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/tango_thermal.c b/drivers/thermal/tango_thermal.c
> index 201304aeafeb..4e67795cb6ce 100644
> --- a/drivers/thermal/tango_thermal.c
> +++ b/drivers/thermal/tango_thermal.c
> @@ -107,6 +107,7 @@ static const struct of_device_id tango_sensor_ids[] = {
>  	},
>  	{ /* sentinel */ }
>  };
> +MODULE_DEVICE_TABLE(of, tango_sensor_ids);

Thanks for fixing it :-)

Acked-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Regards.
