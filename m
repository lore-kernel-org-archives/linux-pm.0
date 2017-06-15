From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 1/2] ARM: imx_v6_v7_defconfig: Set
 THERMAL_WRITABLE_TRIPS=y for testing
Date: Thu, 15 Jun 2017 09:35:30 +0800
Message-ID: <20170615013528.GD30112@dragon>
References: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752101AbdFOBgP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Jun 2017 21:36:15 -0400
Content-Disposition: inline
In-Reply-To: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

On Thu, Jun 08, 2017 at 07:26:57PM +0300, Leonard Crestez wrote:
> Setting trip points is supported by the imx thermal driver and it is
> useful to be able to test this without adjusting config.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
