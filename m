From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v3 2/4] ARM: Kirkwood: Add support thermal sensor for
 88F6282 and 88F6283
Date: Mon, 4 Feb 2013 09:19:43 -0500
Message-ID: <20130204141943.GL14746@titan.lakedaemon.net>
References: <1359815749-27705-1-git-send-email-andrew@lunn.ch>
 <1359815749-27705-3-git-send-email-andrew@lunn.ch>
 <1359947693.2250.50.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:10576 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752229Ab3BDOTt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Feb 2013 09:19:49 -0500
Content-Disposition: inline
In-Reply-To: <1359947693.2250.50.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

On Mon, Feb 04, 2013 at 11:14:53AM +0800, Zhang Rui wrote:
> On Sat, 2013-02-02 at 15:35 +0100, Andrew Lunn wrote:
> > From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > 
> > Kirkwood 88F6282 and 88F6283 have a thermal sensor.
> > This patch adds a DT node and enables the driver in the kernel config.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> I can take this one but I need ACK from ARM experts first.

If you don't mind, I prefer to take patches 2 and 4.  If you could take
1 and 3 and let me know what tree/branch you place them in, then I'll
depend on them when I push them up.

thx,

Jason.
