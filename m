From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Subject: Re: [PATCH 4/7] bus: arm-cci: add missing of_node_put after calling
 of_parse_phandle
Date: Fri, 1 Jul 2016 11:29:58 +0100
Message-ID: <57764626.4060800@arm.com>
References: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
 <1467366121-14120-5-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467366121-14120-5-git-send-email-peter.chen@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Chen <peter.chen@nxp.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On 01/07/16 10:41, Peter Chen wrote:
> of_node_put needs to be called when the device node which is got
> from of_parse_phandle has finished using.
>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>

Thanks for the fix.

> ---
>   drivers/bus/arm-cci.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index a49b283..e7b0b8c 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -1912,9 +1912,12 @@ static int __cci_ace_get_port(struct device_node *dn, int type)
>   	cci_portn = of_parse_phandle(dn, "cci-control-port", 0);
>   	for (i = 0; i < nb_cci_ports; i++) {
>   		ace_match = ports[i].type == type;
> -		if (ace_match && cci_portn == ports[i].dn)
> +		if (ace_match && cci_portn == ports[i].dn) {
> +			of_node_put(cci_portn);
>   			return i;
> +		}
>   	}
> +	of_node_put(cci_portn);

nit: Could we please do some thing like this ?
		if (ace_match && cci_portn == ports[i].dn)
			break;
	}

	of_node_put(cci_portn);
	return (i < nb_cci_ports) ? i : -ENODEV ;

Either way,

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
