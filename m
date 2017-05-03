From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Enable cpufreq governors
Date: Wed, 3 May 2017 22:12:15 +0800
Message-ID: <20170503141213.GJ18578@dragon>
References: <c401883fec8db20878c7593d879e9e128cacc495.1493736306.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751176AbdECOMn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 May 2017 10:12:43 -0400
Content-Disposition: inline
In-Reply-To: <c401883fec8db20878c7593d879e9e128cacc495.1493736306.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Dong Aisheng <aisheng.dong@freescale.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org

On Tue, May 02, 2017 at 05:46:00PM +0300, Leonard Crestez wrote:
> Enable more common cpufreq governors in imx defconfig because this is
> very useful for testing. In particular you can't use cpufreq-set -f
> $FREQ without explicitly defining CONFIG_CPU_FREQ_GOV_USERSPACE=y.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
