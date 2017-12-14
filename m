From: Miquel RAYNAL <miquel.raynal@free-electrons.com>
Subject: Re: [PATCH v3 09/11] thermal: armada: Wait sensors validity before
 exiting the init callback
Date: Thu, 14 Dec 2017 12:27:33 +0100
Message-ID: <20171214122733.5c9264c0@xps13>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
        <20171214103011.24713-10-miquel.raynal@free-electrons.com>
        <87ind9o8o0.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:59600 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbdLNL1p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Dec 2017 06:27:45 -0500
In-Reply-To: <87ind9o8o0.fsf@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devicetree@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, linux-arm-kernel@lists.infradead.org

On Thu, 14 Dec 2017 12:23:11 +0100
Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Miquel,
>  
>  On jeu., déc. 14 2017, Miquel Raynal
> <miquel.raynal@free-electrons.com> wrote:
> 
> > The thermal core will check for sensors validity right after the
> > initialization callback has returned. As the initialization routine
> > make a reset, the sensors are not ready immediately and the core
> > spawns an error in the dmesg. Avoid this annoying situation by
> > polling on the validity bit before exiting from these routines.
> > This also avoid the use of blind sleeps.  
> 
> You only modified the armada 380 and ap806 init function. Does it
> means that this feature is not supported on the other variant?

I can't tell for other boards, It does not seem they actually need it
so I did not hacked their init callback. Should I? IMOH, if there is
not problem, there is no fix to add neither.

Miquèl
