From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 1/2] thermal: armada: Remove support for A375-Z1 SoC
Date: Fri, 7 Nov 2014 23:27:36 +0100
Message-ID: <20141107232736.456b1b79@free-electrons.com>
References: <1415116839-4323-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<1415116839-4323-2-git-send-email-ezequiel.garcia@free-electrons.com>
	<20141107032619.GD3698@titan.lakedaemon.net>
	<545CBDEF.6050502@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:34072 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751740AbaKGW1l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 17:27:41 -0500
In-Reply-To: <545CBDEF.6050502@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Zhang Rui <rui.zhang@intel.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org

Dear Ezequiel Garcia,

On Fri, 07 Nov 2014 09:41:19 -0300, Ezequiel Garcia wrote:

> We can do that if you think it's really useful. However, I think we've
> designed this so *nobody* would actually have to put the z1 compatible
> string. The mvebu quirk (tries) to auto-detect it from the revision
> register and hot fix the compatible string.

Correct.

> Moreover, I'm not at all sure *anyone* would have a Z1 board except
> early developers like us. Am I being too naive here?

I confirm: those early revisions have only been provided to a very
small selection of persons, mainly within Marvell, and only a few
external partners which are all well aware of the early status of such
SoC revisions.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
