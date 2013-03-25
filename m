From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 00/14] Marvell EBU thermal sensor consolidation
Date: Mon, 25 Mar 2013 10:29:24 -0600
Message-ID: <20130325162924.GA16690@obsidianresearch.com>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130325093001.GH5627@lunn.ch>
 <20130325104513.GC2502@localhost>
 <CABJ1b_S9c=tFT17=HycmuRbW1g4y8AvWJpmwMRJwvQ214Yb3fw@mail.gmail.com>
 <20130325123928.GD2502@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:39879 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758617Ab3CYQ3a (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Mar 2013 12:29:30 -0400
Content-Disposition: inline
In-Reply-To: <20130325123928.GD2502@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>

On Mon, Mar 25, 2013 at 09:39:30AM -0300, Ezequiel Garcia wrote:

> Could you test the Dove formula fixes and provide a Tested-by?
> However little the patches maybe, it still makes me nervous
> to send untested patches.

FWIW, I reviewed and confirmed your new calculation based on the
Kirkwood doc's I have.

Jason
