From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 00/16] Marvell EBU thermal sensor consolidation
Date: Thu, 21 Mar 2013 14:36:23 +0100
Message-ID: <20130321133623.GB5627@lunn.ch>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130321064501.GK21478@lunn.ch>
 <20130321123556.GC22714@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:50280 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757114Ab3CUNgh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Mar 2013 09:36:37 -0400
Content-Disposition: inline
In-Reply-To: <20130321123556.GC22714@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Jason Cooper <jason@lakedaemon.net>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>

> Why do you think it has two sensors?

The register set i've seen talks of a junction temperate and a
"thermal manager current temperature". The thermal manager temperature
went up as i loaded the CPU and dropped down again as it was idle and
cooled. I've no idea if these are two different sensors, or one is an
averaged value of the other, etc. I would hope the datasheet gives a
description.....

     Andrew
