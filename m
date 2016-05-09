From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/6] docs: Document BCM23550 bindings
Date: Mon, 9 May 2016 14:41:15 -0500
Message-ID: <20160509194115.GA11594@rob-hp-laptop>
References: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
 <1462481334-8943-4-git-send-email-chris.brand@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462481334-8943-4-git-send-email-chris.brand@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Brand <chris.brand@broadcom.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Russell King <linux@arm.linux.org.uk>, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Raymond Ngun <raymond.ngun@broadcom.com>, Markus Mayer <markus.mayer@broadcom.com>
List-Id: linux-pm@vger.kernel.org

On Thu, May 05, 2016 at 01:48:51PM -0700, Chris Brand wrote:
> Add binding document for Broadcom BCM23550 SoC.
> 
> BCM23550 has a Cluster Dormant Control IP block that holds cores
> in an idle state. Introduce a new CPU enable method in which the CDC is
> accessed to bring the core online.
> 
> Signed-off-by: Chris Brand <chris.brand@broadcom.com>
> ---
>  .../bindings/arm/bcm/brcm,bcm23550-cpu-method.txt  | 36 ++++++++++++++++++++++
>  .../devicetree/bindings/arm/bcm/brcm,bcm23550.txt  | 15 +++++++++
>  Documentation/devicetree/bindings/arm/cpus.txt     |  1 +
>  3 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt
> new file mode 100644
> index 000000000000..b1b16872bbca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt
> @@ -0,0 +1,36 @@
> +Broadcom Kona Family CPU Enable Method
> +--------------------------------------
> +This binding defines the enable method used for starting secondary
> +CPUs in the following Broadcom SoCs:
> +  BCM23550
> +
> +The enable method is specified by defining the following required
> +properties in the "cpu" device tree node:
> +  - enable-method = "brcm,bcm23550-cpu-method";

"-cpu-method" is a bit redundant. brcm,bc23550 is probably sufficient.

> +  - secondary-boot-reg = <...>;
> +
> +The secondary-boot-reg property is a u32 value that specifies the
> +physical address of the register used to request the ROM holding pen
> +code release a secondary CPU.  The value written to the register is
> +formed by encoding the target CPU id into the low bits of the
> +physical start address it should jump to.
