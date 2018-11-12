From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH 2/2] opp: ti-opp-supply: Correct the supply in
 _get_optimal_vdd_voltage call
Date: Mon, 12 Nov 2018 15:49:22 -0600
Message-ID: <312975f3-3cbd-3ece-20b6-ceb93421a3c9@ti.com>
References: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
 <1541565263-8296-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541565263-8296-3-git-send-email-j-keerthy@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com
List-Id: linux-pm@vger.kernel.org

On 11/06/2018 10:34 PM, Keerthy wrote:
> _get_optimal_vdd_voltage call provides new_supply_vbb->u_volt
> as the reference voltage while it should be really new_supply_vdd->u_volt.
> 
> Fixes: 9a835fa6e47 ("PM / OPP: Add ti-opp-supply driver")
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---

Acked-by: Dave Gerlach <d-gerlach@ti.com>

Currently all corresponding vbb and vdd values provided by the device tree match
which is why this does not fail, but this was a typo by me and vdd is the
correct value to actually use.

Regards,
Dave

>  drivers/opp/ti-opp-supply.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
> index 29e08a4..3f4fb4d 100644
> --- a/drivers/opp/ti-opp-supply.c
> +++ b/drivers/opp/ti-opp-supply.c
> @@ -288,7 +288,7 @@ static int ti_opp_supply_set_opp(struct dev_pm_set_opp_data *data)
>  	int ret;
>  
>  	vdd_uv = _get_optimal_vdd_voltage(dev, &opp_data,
> -					  new_supply_vbb->u_volt);
> +					  new_supply_vdd->u_volt);
>  
>  	if (new_supply_vdd->u_volt_min < vdd_uv)
>  		new_supply_vdd->u_volt_min = vdd_uv;
> 
