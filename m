From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 2/5] thermal: rockchip_thermal: simplify getting .driver_data
Date: Fri, 02 Nov 2018 13:25:32 +0100
Message-ID: <2099094.tBqgur4jcY@phil>
References: <20181021200053.2194-1-wsa+renesas@sang-engineering.com> <20181021200053.2194-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021200053.2194-3-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Am Sonntag, 21. Oktober 2018, 22:00:49 CET schrieb Wolfram Sang:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
