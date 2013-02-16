From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v5 2/4] ARM: Kirkwood: Add support thermal sensor for
 88F6282 and 88F6283
Date: Sat, 16 Feb 2013 14:10:38 -0500
Message-ID: <20130216191038.GF23237@titan.lakedaemon.net>
References: <1360132527-22860-1-git-send-email-andrew@lunn.ch>
 <1360132527-22860-3-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:54799 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755121Ab3BQBJw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 16 Feb 2013 20:09:52 -0500
Content-Disposition: inline
In-Reply-To: <1360132527-22860-3-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: rui.zhang@intel.com, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

On Wed, Feb 06, 2013 at 07:35:25AM +0100, Andrew Lunn wrote:
> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> 
> Kirkwood 88F6282 and 88F6283 have a thermal sensor.
> This patch adds a DT node and enables the driver in the kernel config.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/kirkwood-6282.dtsi |    6 ++++++
>  arch/arm/configs/kirkwood_defconfig  |    2 ++
>  2 files changed, 8 insertions(+)

Patches 2 and 4 of this series applied to mvebu/dt_deps with a
dependency on thermal/next up to:

74ffa64 Thermal: Dove: Add Themal sensor support for Dove.
7060aa3 thermal: Add support for the thermal sensor on Kirkwood SoCs

thx,

Jason.
