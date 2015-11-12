From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v4 00/10] Better compatible for the rockchip thermal and
 support RK3368 SoCs
Date: Thu, 12 Nov 2015 10:31:20 -0800
Message-ID: <20151112183119.GA5289@localhost.localdomain>
References: <1447044542-30859-1-git-send-email-wxt@rock-chips.com>
 <20151112182950.GB4361@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35475 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbbKLSbY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2015 13:31:24 -0500
Content-Disposition: inline
In-Reply-To: <20151112182950.GB4361@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, lkp@intel.com, devicetree@vger.kernel.org, Jiri Kosina <trivial@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, Olof Johansson <olof@lixom.net>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>

On Thu, Nov 12, 2015 at 10:29:52AM -0800, Eduardo Valentin wrote:
> On Mon, Nov 09, 2015 at 12:48:52PM +0800, Caesar Wang wrote:
> > Thank you all for providing inputs and comments on previous versions of
> > this patchset.
> > Especially thanks to the (Eduardo, Dmitry, Heiko,....).
> > 
> > This series patchs are working for RK3368 on Rockchip platform.
> 
> Do you have any results on existing support? Is the driver still in one
> piece for rk3288?
> 
> I am planing to send your series in next rc cycles. It won't appear in
> linux-next until merge window finishes.

To be more specific, only patches 1-7. DT bindings go via the right
machine tree.

Thanks

> 
> BR,
> 
> Eduardo Valentin
