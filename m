From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V2 5/6] cpuidle/powerpc: Backend-powerpc idle driver for
 powernv and pseries.
Date: Tue, 6 Aug 2013 18:41:11 -0500
Message-ID: <1375832471.5600.41.camel@snotra.buserror.net>
References: <20130731025840.19448.24468.stgit@deepthi>
	 <20130731025934.19448.16658.stgit@deepthi>
	 <1375830520.5600.23.camel@snotra.buserror.net>
	 <1375831851.12557.74.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:46777 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752352Ab3HFXlR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2013 19:41:17 -0400
In-Reply-To: <1375831851.12557.74.camel@pasglop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, michael@ellerman.id.au, srivatsa.bhat@linux.vnet.ibm.com, preeti@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, rjw@sisk.pl, dongsheng.wang@freescale.com, linux-pm@vger.kernel.org

On Wed, 2013-08-07 at 09:30 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2013-08-06 at 18:08 -0500, Scott Wood wrote:
> > Here's another example.  get_lppaca() will only build on book3s -- and
> > yet we get requests for e500 code to use this file.
> 
> Indeed, Besides there is already accessors afaik for lppaca that compile
> to nothing on E (and if not they would be trivial to add).

I don't see such an accessor, but if there were, what would happen when
the caller goes on to dereference that nothing?

There is an accessor for shared_proc specifically (in the spinlock code)
-- not that it would be much help on booke to just compile away that
check and always select one of the pseries state tables over the other.

-Scott



