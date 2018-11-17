From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] power: supply: bq24190_charger: add support for
 bq24196 variant
Date: Sat, 17 Nov 2018 09:44:12 -0600
Message-ID: <20181117154412.GA5215@bogus>
References: <20181113124753.29948-1-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181113124753.29948-1-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mdf@kernel.org, heiko@sntech.de, Heiko Stuebner <heiko.stuebner@bq.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 13 Nov 2018 13:47:53 +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> The bq24196 is another variant of the bq24190 charger ic.
> Its register set is identical to the bq24192 and it even reuses
> the same part number (0x5).
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
> ---
> This should go on top of the bq24192 support patches from Brian Masney /
> Jonathan Marek [0]
> 
> [0] https://patchwork.kernel.org/patch/10663409/
> 
> changes in v2:
> - add missing compatible to dt-binding
> 
>  Documentation/devicetree/bindings/power/supply/bq24190.txt | 1 +
>  drivers/power/supply/bq24190_charger.c                     | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
