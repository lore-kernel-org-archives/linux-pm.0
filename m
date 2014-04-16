From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 5/6] ARM: mvebu: Add thermal quirk for the Armada 375 DB
 board
Date: Wed, 16 Apr 2014 18:08:24 +0200
Message-ID: <20140416160824.GA14842@lunn.ch>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1397657720-10893-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <534EA8C9.7010907@gmail.com>
 <20140416180315.5153c3f7@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:56881 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161730AbaDPQKv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Apr 2014 12:10:51 -0400
Content-Disposition: inline
In-Reply-To: <20140416180315.5153c3f7@skate>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>

> For minor differences such as SoC stepping, I personally prefer to not
> have separate Device Trees. We already have many of them, for each
> variant of the various SOCs. If we add the different steppings, it's
> going to be even more complicated. Also, there will be a new iteration
> of the Armada 375 DB with an A0 chip, which does not have the Z1 bug.

How many Z1 are there out and about? Would it be simpler to just
disable thermal on Z1? If only development boards have Z1, this could
be reasonable.

	Andrew
