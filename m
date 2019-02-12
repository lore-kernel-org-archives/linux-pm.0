From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] driver core: Fixes related to device links
Date: Tue, 12 Feb 2019 15:09:24 +0100
Message-ID: <20190212140924.GA14444@kroah.com>
References: <5510642.nRbR3bcduN@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5510642.nRbR3bcduN@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 12, 2019 at 01:01:13PM +0100, Rafael J. Wysocki wrote:
> Hi Greg at al,
> 
> These fix two issues on top of the recent device links material in
> driver-core/driver-core-next.  
> 
> The first one fixes a race condition that may trigger when
> __pm_runtime_set_status() is used incorrectly (that is, when it is
> called with PM-runtime enabled for the target device and working).
> 
> The second one fixes a supplier PM-runtime usage counter imbalance
> resulting from adding and removing (e.g. in the error code path) a
> stateless device link to it from within the consumer driver's probe
> callback.
> 
> Please refer to the patch changelogs for details.

Looks good, all now queued up, thanks.

greg k-h
