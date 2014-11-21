From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 1/2] thermal: armada: Remove support for A375-Z1 SoC
Date: Fri, 21 Nov 2014 23:31:39 +0100
Message-ID: <20141121233139.3a117e1c@free-electrons.com>
References: <1415116839-4323-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<1415116839-4323-2-git-send-email-ezequiel.garcia@free-electrons.com>
	<20141120193804.GA7252@developer>
	<20141121201858.GB22670@titan.lakedaemon.net>
	<20141121225122.1165b466@free-electrons.com>
	<20141121220503.GJ22670@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:59138 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752478AbaKUWbn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Nov 2014 17:31:43 -0500
In-Reply-To: <20141121220503.GJ22670@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Eduardo Valentin <edubezval@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org

Hello,

On Fri, 21 Nov 2014 17:05:03 -0500, Jason Cooper wrote:

> > So the suggestion would be to not document the DT bindings at all,
> > until we reach a "stable" hardware that is distributed externally?
> 
> No, I think it's better to document.  However, we should also document
> the fact that the binding is for an early version of the SoC and subject
> to incompatible change once the production version of the SoC is
> released.  ie, an un-stable binding.

Sounds good.

> > I don't mind adjusting how DT bindings are documented for such early
> > SoCs stepping. But I really believe it's important to have a way to
> > handle this situation nicely: we've been asking for years SoC vendors
> > to start upstreaming their code early. Now that they start to do it, we
> > shouldn't complain and instead adapt to this situation :-)
> 
> Does the above proposal meet your expectations?

Absolutely!

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
