From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] PM / AVS: rockchip-io: add io selectors and supplies for rk3328
Date: Tue, 21 Feb 2017 16:06:53 +0100
Message-ID: <43787071.1WOyg3ntUU@phil>
References: <1487556485-18871-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487556485-18871-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: khilman@kernel.org, nm@ti.com, huangtao@rock-chips.com, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Montag, 20. Februar 2017, 10:08:05 CET schrieb David Wu:
> From: "david.wu" <david.wu@rock-chips.com>
> 
> This adds the necessary data for handling io voltage domains on the rk3328.
> As interesting tidbit, the rk3328 only contains one iodomain area in the
> regular General Register Files (GRF).
> 
> Signed-off-by: david.wu <david.wu@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Only issue might be, that you didn't include Rafael (rjw@rjwysocki.net) and 
most of the time io-domain patches go to him directly with an Ack from Kevin, 
as there are normally not enough power/avs patches to warant a pull :-) 


Heiko
