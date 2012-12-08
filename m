From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] thermal: Add support for thermal sensor for
	Kirkwood SoC
Date: Sat, 8 Dec 2012 00:11:52 +0000
Message-ID: <20121208001152.GA14363@n2100.arm.linux.org.uk>
References: <1354922151-3250-1-git-send-email-iwamatsu@nigauri.org> <20121208010708.260209f5@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56460 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636Ab2LHAO7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Dec 2012 19:14:59 -0500
Content-Disposition: inline
In-Reply-To: <20121208010708.260209f5@skate>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, rui.zhang@intel.com, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Sat, Dec 08, 2012 at 01:07:08AM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> On Sat,  8 Dec 2012 08:15:50 +0900, Nobuhiro Iwamatsu wrote:
> > +static const struct of_device_id kirkwood_thermal_id_table[] = {
> > +	{ .compatible = "marvel,thermal-kirkwood" },
> 
> marvel -> marvell
> 
> Also, I think it should be marvell,kirkwood-thermal, since most other
> DT compatible strings that we have for Marvell SoCs are
> marvell,<soc>-<function>.
> 
> Also, the Device Tree binding documentation is missing (even though it
> is admittedly going to be a very short documentation).

Is this in any way compatible with the thermal monitoring found on
Dove (510) stuff?  If so, should it have the SoC prefix in there,
or should it be "armada-thermal" for the SoC family?
