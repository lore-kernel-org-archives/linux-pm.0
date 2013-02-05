From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 3/4] Thermal: Dove: Add Themal sensor support for Dove.
Date: Tue, 5 Feb 2013 18:32:21 +0100
Message-ID: <20130205173221.GB20212@lunn.ch>
References: <1359946148.2250.47.camel@rzhang1-mobl4>
 <1360005560-21945-1-git-send-email-andrew@lunn.ch>
 <1360005560-21945-4-git-send-email-andrew@lunn.ch>
 <20130205170908.GA2525@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:52463 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754785Ab3BERcj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Feb 2013 12:32:39 -0500
Content-Disposition: inline
In-Reply-To: <20130205170908.GA2525@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, jason@lakedaemon.net, rui.zhang@intel.com, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

On Tue, Feb 05, 2013 at 02:09:09PM -0300, Ezequiel Garcia wrote:
> Hi Andrew,
> 
> Nice work!
> 
> Do you also intend to work
> on thermal support for Armada family?

Hi Ezequiel

I don't have enough information about Armada 370/XP to write a driver
for them. Once a datasheet becomes available i will have a go.

Thanks for the comment about kzalloc(). I will remove the dev_err()
call.

    Andrew
