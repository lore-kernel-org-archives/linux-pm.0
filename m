From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: w1: document bindings for ds2760
 battery monitor
Date: Wed, 11 Jul 2018 09:02:35 -0600
Message-ID: <20180711150235.GA24824@rob-hp-laptop>
References: <20180706053552.11438-1-daniel@zonque.org>
 <20180706053552.11438-3-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180706053552.11438-3-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: zbr@ioremap.net, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu, sre@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robert.jarzmik@free.fr
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 06, 2018 at 07:35:49AM +0200, Daniel Mack wrote:
> This patch adds the devicetree bindings for Maxim's ds2760 battery
> monitors.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  .../bindings/power/supply/maxim,ds2760.txt    | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt

Reviewed-by: Rob Herring <robh@kernel.org>
