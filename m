From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 2/2] ARM: mvebu: Remove thermal quirk for A375 Z1
 revision
Date: Sat, 8 Nov 2014 22:38:31 -0500
Message-ID: <20141109033831.GP3698@titan.lakedaemon.net>
References: <1415116839-4323-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1415116839-4323-3-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:64823 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751232AbaKIDip (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 8 Nov 2014 22:38:45 -0500
Content-Disposition: inline
In-Reply-To: <1415116839-4323-3-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org

On Tue, Nov 04, 2014 at 01:00:39PM -0300, Ezequiel Garcia wrote:
> The Armada 375 Z1 SoC revision is no longer supported. This commit
> removes the quirk required to "fix" the reg property and the compatible
> string of the thermal devicetree node.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/board-v7.c | 66 +-----------------------------------------
>  1 file changed, 1 insertion(+), 65 deletions(-)

Applied to mvebu/soc

thx,

Jason.
