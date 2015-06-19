From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 7/7] ARM: shmobile: armadillo800eva dts: Add pinctrl
 and gpio-hog for lcdc0
Date: Fri, 19 Jun 2015 09:27:04 +0900
Message-ID: <20150619002703.GC32130@verge.net.au>
References: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
 <1434530336-15073-8-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434530336-15073-8-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <damm+renesas@opensource.se>, Arnd Bergmann <arnd@arndb.de>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marc Zyngier <marc.zyngier@arm.com>, devel@driverdev.osuosl.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 17, 2015 at 10:38:56AM +0200, Geert Uytterhoeven wrote:
> Configure pinctrl and a GPIO-controller board mux for LCD use.
> This allows the armadillo800eva board staging code to enable lcdc0.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Geert,

As Greg has now taken patches 1 - 6 I have queued this up.
