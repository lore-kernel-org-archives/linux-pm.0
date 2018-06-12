From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 10/11] dt-bindings: misc: add bindings for
 cros_ec_throttler
Date: Tue, 12 Jun 2018 13:10:11 -0600
Message-ID: <20180612191011.GA26266@rob-hp-laptop>
References: <20180607181214.30338-1-mka@chromium.org>
 <20180607181214.30338-11-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180607181214.30338-11-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 07, 2018 at 11:12:13AM -0700, Matthias Kaehlcke wrote:
> The cros_ec_throttler monitors events from the Chrome OS Embedded
> Controller to throttle the system if needed, using the mechanisms
> provided by the throttler core.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - patch added to series
> 
>  Documentation/devicetree/bindings/misc/cros_ec_throttler.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/cros_ec_throttler.txt b/Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
> new file mode 100644
> index 000000000000..7316dcc0ef75
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
> @@ -0,0 +1,4 @@
> +* cros_ec_throttler driver

Bindings are for h/w, not drivers.

I continue to fail to see why this needs to be in DT. There are other 
ways to instantiate drivers.

> +
> +Required properties:
> +- compatible: "google,cros-ec-throttler"
> -- 
> 2.18.0.rc1.242.g61856ae69a-goog
> 
