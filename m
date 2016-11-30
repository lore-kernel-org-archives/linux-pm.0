From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: power: add bindings for sbs-charger
Date: Wed, 30 Nov 2016 14:45:16 -0600
Message-ID: <20161130204516.zbuvty5mtr7lvcly@rob-hp-laptop>
References: <1479990823-25841-1-git-send-email-nicolas.saenz@prodys.net>
 <1479990823-25841-3-git-send-email-nicolas.saenz@prodys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479990823-25841-3-git-send-email-nicolas.saenz@prodys.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
Cc: sre@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 24, 2016 at 01:33:43PM +0100, Nicolas Saenz Julienne wrote:
> Adds device tree documentation for SBS charger compilant devices as defined
> here: http://sbs-forum.org/specs/sbc110.pdf
> 
> Signed-off-by: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
> ---
> v2 -> v3:
> - add part number as compatible
> 
>  .../bindings/power/supply/sbs_sbs-charger.txt      | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt

Acked-by: Rob Herring <robh@kernel.org>
