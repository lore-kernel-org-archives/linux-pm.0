From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/2] dt-bindings: power: sbs-battery: re-document
 "ti,bq20z75"
Date: Fri, 1 Jun 2018 10:35:00 -0700
Message-ID: <20180601173500.GB22509@roeck-us.net>
References: <20180601172400.50737-1-briannorris@chromium.org>
 <20180601172400.50737-2-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180601172400.50737-2-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Rhyland Klein <rklein@nvidia.com>, Alexandru Stan <amstan@chromium.org>, Doug Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 01, 2018 at 10:24:00AM -0700, Brian Norris wrote:
> This compatible property was documented before the driver was renamed to
> "SBS" (see commit e57f1b68c406 ("devicetree-bindings: Propagate
> bq20z75->sbs rename to dt bindings")). The driver has continued to
> support this property as an alternative to "sbs,sbs-battery", and
> because we've noticed there are some lingering TI specifics (in the
> manufacturer-specific portion of the SBS spec), we'd like to start using
> this property again to differentiate.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Acked-by: Rhyland Klein <rklein@nvidia.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2: add Rhyland's Acked-by
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
> -- 
> 2.17.0.921.gf22659ad46-goog
> 
