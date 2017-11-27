From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 2/3] thermal: armada: add support for AP806
Date: Mon, 27 Nov 2017 11:21:38 -0800
Message-ID: <20171127192136.GA3835@localhost.localdomain>
References: <7102bb32704ac9f70ef3ae61682d50de8af61b57.1511361725.git.baruch@tkos.co.il>
 <320800cce532d6ae1927b36f82b007f04c740a15.1511361725.git.baruch@tkos.co.il>
 <20171123152416.GR31757@n2100.armlinux.org.uk>
 <20171123163510.q34rndd4b4p4da4s@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43838 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbdK0TVm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Nov 2017 14:21:42 -0500
Received: by mail-pf0-f193.google.com with SMTP id r68so11647613pfe.10
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2017 11:21:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171123163510.q34rndd4b4p4da4s@tarshish>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Zhang Rui <rui.zhang@intel.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Miquel Raynal <miquel.raynal@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Thu, Nov 23, 2017 at 06:35:10PM +0200, Baruch Siach wrote:
> Hi Russell,
> 
> On Thu, Nov 23, 2017 at 03:24:17PM +0000, Russell King - ARM Linux wrote:
> > On Wed, Nov 22, 2017 at 04:42:04PM +0200, Baruch Siach wrote:
> > > The AP806 component is integrated in the Armada 8k and 7k lines of processors.

<cut>

> > > +	mdelay(10);
> > 
> > Do you really need to make the CPU busy-wait for 10ms here?  This
> > looks like it's called from a schedulable context, so won't msleep()
> > do?

Yes, that is schedulable context.

> 
> msleep() should be fine as well. I just mindlessly copied this code from the 
> vendor kernel. I'll change that in the next iteration.
> 

Yes please, send next version without CPU spinning delays.


> Thanks for reviewing,
> baruch
> 
> -- 
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
