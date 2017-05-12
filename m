From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: power: New bindings for ltc3651-charger
Date: Fri, 12 May 2017 15:11:16 -0500
Message-ID: <20170512201116.astoykfqykql5e64@rob-hp-laptop>
References: <1493966315-15893-1-git-send-email-mike.looijmans@topic.nl>
 <20170508171206.ajxjbw5mybvrpwss@rob-hp-laptop>
 <1494308190-3687-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1494308190-3687-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: devicetree@vger.kernel.org, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com
List-Id: linux-pm@vger.kernel.org

On Tue, May 09, 2017 at 07:36:30AM +0200, Mike Looijmans wrote:
> This adds the devicetree bindings documentation for the LTC3651 battery charger.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> v2: Add "lltc," vendor prefix to gpios
>     Expand irq paragraph
> 
>  .../bindings/power/supply/ltc3651-charger.txt      | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt

Acked-by: Rob Herring <robh@kernel.org>
