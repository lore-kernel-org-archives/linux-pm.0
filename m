From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v4 07/13] ARM: dts: mvebu: Add a new set of registers to
 the PMSU node
Date: Wed, 19 Feb 2014 19:21:01 +0100
Message-ID: <20140219192101.4d92fa01@skate>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
	<1392312816-17657-8-git-send-email-gregory.clement@free-electrons.com>
	<20140219170033.4ca8343b@skate>
	<5304EE99.7000102@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51610 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754189AbaBSSVH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2014 13:21:07 -0500
In-Reply-To: <5304EE99.7000102@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <info@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, devicetree@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Dear Gregory CLEMENT,

On Wed, 19 Feb 2014 18:49:13 +0100, Gregory CLEMENT wrote:

> I agree to use something like:
> 
> armada-370-xp-pmsu@22000 {
> 	compatible = "marvell,armada-xp-pmsu"; /* new compatible string */

But this PMSU is identical on 370, no? So the marvell,armada-xp-pmsu
compatible string is maybe not the most appropriate one?

> 	reg = <0x22000 0x1000>;
> 	};
> 
> 
> and I think the best option would be to introduce a new compatible string
> for this. In the same time we continue to support the old compatible string
> but we print a big warning during the kernel boot that this compatible string
> is deprecated, and we will finally remove it a few release.

How do you support the new features of the L2 stuff with the old
compatible string? By substracting 0x100 to the register base address?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
