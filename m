From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 5/6] ARM: mvebu: Add thermal quirk for the Armada 375 DB
 board
Date: Wed, 16 Apr 2014 18:03:15 +0200
Message-ID: <20140416180315.5153c3f7@skate>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<1397657720-10893-6-git-send-email-ezequiel.garcia@free-electrons.com>
	<534EA8C9.7010907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49971 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161730AbaDPQDT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Apr 2014 12:03:19 -0400
In-Reply-To: <534EA8C9.7010907@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>

Dear Sebastian Hesselbarth,

On Wed, 16 Apr 2014 17:59:05 +0200, Sebastian Hesselbarth wrote:

> Are we sure, we want to fixup quirks like this the way below?

We already have an exactly identical quirk for the A0 I2C issue, in the
same file, right above the quirk Ezequiel is adding here. So using the
same strategy for both cases would be nice.

> Alternatively, we can also keep some armada-375-z1.dtsi and one
> for the board including it.

For minor differences such as SoC stepping, I personally prefer to not
have separate Device Trees. We already have many of them, for each
variant of the various SOCs. If we add the different steppings, it's
going to be even more complicated. Also, there will be a new iteration
of the Armada 375 DB with an A0 chip, which does not have the Z1 bug.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
