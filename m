From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v4 00/10] Better compatible for the rockchip thermal and support RK3368 SoCs
Date: Thu, 12 Nov 2015 23:14 +0100
Message-ID: <3751572.i2tVkgaN1o@phil>
References: <1447044542-30859-1-git-send-email-wxt@rock-chips.com> <20151112182950.GB4361@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:51441 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917AbbKLWOO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 12 Nov 2015 17:14:14 -0500
In-Reply-To: <20151112182950.GB4361@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Caesar Wang <wxt@rock-chips.com>, linux-rockchip@lists.infradead.org, lkp@intel.com, devicetree@vger.kernel.org, Jiri Kosina <trivial@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, Olof Johansson <olof@lixom.net>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>

Hi Eduardo,

Am Donnerstag, 12. November 2015, 10:29:52 schrieb Eduardo Valentin:
> On Mon, Nov 09, 2015 at 12:48:52PM +0800, Caesar Wang wrote:
> > Thank you all for providing inputs and comments on previous versions of
> > this patchset.
> > Especially thanks to the (Eduardo, Dmitry, Heiko,....).
> > 
> > This series patchs are working for RK3368 on Rockchip platform.
> 
> Do you have any results on existing support? Is the driver still in one
> piece for rk3288?

I've tested this series on a rk3288-veyron-jerry and everything still
runs just fine, so

Tested-by: Heiko Stuebner <heiko@sntech.de>
