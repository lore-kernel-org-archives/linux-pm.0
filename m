From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/7] max8903: adds documentation for device tree
 bindings.
Date: Tue, 28 Jun 2016 15:55:13 -0500
Message-ID: <20160628205513.GE3737@rob-hp-laptop>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466735172-13372-2-git-send-email-chris@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466735172-13372-2-git-send-email-chris@cpdesign.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>
Cc: k.kozlowski@samsung.com, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 24, 2016 at 12:26:06PM +1000, Chris Lapa wrote:
> From: Chris Lapa <chris@lapa.com.au>
> 
> Signed-off-by: Chris Lapa <chris@lapa.com.au>
> ---
>  .../devicetree/bindings/power/max8903-charger.txt  | 25 +++++++++++++++
>  arch/arm/boot/dts/dairytest-servo.dtsi             | 36 ++++++++++++++++++++++

Binding looks fine, but this dtsi is unrelated changed.

>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/max8903-charger.txt
>  create mode 100644 arch/arm/boot/dts/dairytest-servo.dtsi
