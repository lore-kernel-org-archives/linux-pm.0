From: Rhyland Klein <rklein@nvidia.com>
Subject: Re: [PATCH 2/2] dt-bindings: power: sbs-battery: re-document
 "ti,bq20z75"
Date: Fri, 1 Jun 2018 12:14:04 -0400
Message-ID: <22411469-af79-604f-c56a-1680359b1629@nvidia.com>
References: <20180601003252.42810-1-briannorris@chromium.org>
 <20180601003252.42810-2-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180601003252.42810-2-briannorris@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Alexandru Stan <amstan@chromium.org>, Guenter Roeck <linux@roeck-us.net>, Doug Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

On 5/31/2018 8:32 PM, Brian Norris wrote:
> This compatible property was documented before the driver was renamed to
> "SBS" (see commit e57f1b68c406 ("devicetree-bindings: Propagate
> bq20z75->sbs rename to dt bindings")). The driver has continued to
> support this property as an alternative to "sbs,sbs-battery", and
> because we've noticed there are some lingering TI specifics (in the
> manufacturer-specific portion of the SBS spec), we'd like to start using
> this property again to differentiate.
> 
> Cc: Rhyland Klein <rklein@nvidia.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  .../devicetree/bindings/power/supply/sbs_sbs-battery.txt        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> index c40e8926facf..a7a9c3366f82 100644
> --- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> @@ -2,7 +2,7 @@ SBS sbs-battery
>  ~~~~~~~~~~
>  
>  Required properties :
> - - compatible : "sbs,sbs-battery"
> + - compatible : "sbs,sbs-battery" or "ti,bq20z75"
>  
>  Optional properties :
>   - sbs,i2c-retry-count : The number of times to retry i2c transactions on i2c
> 

Acked-by: Rhyland Klein <rklein@nvidia.com>

-- 
nvpublic
