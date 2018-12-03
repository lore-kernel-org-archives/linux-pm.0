From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] power: reset: gpio-poweroff: add ability to specific
 active and inactive delays
Date: Mon, 3 Dec 2018 17:49:23 -0600
Message-ID: <20181203234923.GA29934@bogus>
References: <20181111214538.32477-1-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181111214538.32477-1-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mdf@kernel.org, heiko@sntech.de, Heiko Stuebner <heiko.stuebner@bq.com>
List-Id: linux-pm@vger.kernel.org

On Sun, 11 Nov 2018 22:45:38 +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> Similar to gpio-reset allow to specify active and inactive delays
> while keeping the 100ms defaults that were used previously all the time.
> 
> The dt-properties are named the same as in gpio-reset but get an "-ms"
> suffix as properties should contain such a suffix specifying its unit.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
> ---
>  .../devicetree/bindings/power/reset/gpio-poweroff.txt  |  2 ++
>  drivers/power/reset/gpio-poweroff.c                    | 10 ++++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
