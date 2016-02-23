From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] devicetree: Add UCS1002 USB Port Power Controller
 binding
Date: Tue, 23 Feb 2016 16:54:38 -0600
Message-ID: <20160223225437.GA9367@rob-hp-laptop>
References: <1456212425-5937-1-git-send-email-enric.balletbo@collabora.com>
 <1456212425-5937-2-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456212425-5937-2-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Martyn Welch <martyn.welch@collabora.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 23, 2016 at 08:27:04AM +0100, Enric Balletbo i Serra wrote:
> The UCS1002-2 provides a USB port power switch for precise control of up
> to 2.5 amperes continuous current.
> 
> You can add support to your board with current binding.
> 
> Example:
> 
>     ucs1002: ucs1002@57 {
>              compatible = "microchip,ucs1002";
>              reg = <0x57>;
>     };
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Changes since v2:
>  - Rename microchip,current-limit to microchip,limit-microamps (Rob Herring)
> Changes since v1:
>  - Fix units, are microamps (Rob Herring)
>  - Remove microchip,pin-ignore as is implied by absence of gpio properties (Rob
>    Herring)
>  - Group control gpios instead of use separate gpios. All control gpios must be
>    set together (Enric Balletbo)
> 
>  .../devicetree/bindings/power/ucs1002.txt          | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/ucs1002.txt

Acked-by: Rob Herring <robh@kernel.org>
