From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 5/6] ARM: mvebu: Add thermal quirk for the Armada 375 DB
 board
Date: Wed, 16 Apr 2014 18:34:47 +0200
Message-ID: <20140416163447.GB14842@lunn.ch>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1397657720-10893-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <534EA8C9.7010907@gmail.com>
 <20140416180315.5153c3f7@skate>
 <20140416160824.GA14842@lunn.ch>
 <20140416181938.6e8f8f4b@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:56908 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbaDPQhJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Apr 2014 12:37:09 -0400
Content-Disposition: inline
In-Reply-To: <20140416181938.6e8f8f4b@skate>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>

> So, I would like to see the Z1 stepping supported for now, and have the
> freedom to remove its support later once we are all ready to switch to
> A0.

Hi Thomas

Sounds like a good plan. Try to keep all the mess to support Z1 in one
place so that it can be easily taken out once people have A0.

       Andrew
