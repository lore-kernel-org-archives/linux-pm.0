From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/5] pm: domains: quieten down generic pm domains
Date: Mon, 05 May 2014 00:36:25 +0200
Message-ID: <1412882.XTDX0QPJ6V@vostro.rjw.lan>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk> <10021780.rnCkCYmgZH@vostro.rjw.lan> <CAPDyKFpKnhcttY-BWDEG=XTYsKHro0t5G7YBao-+F=o3ez3grA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65294 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753842AbaEDWTu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 4 May 2014 18:19:50 -0400
In-Reply-To: <CAPDyKFpKnhcttY-BWDEG=XTYsKHro0t5G7YBao-+F=o3ez3grA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>

On Friday, May 02, 2014 11:24:45 AM Ulf Hansson wrote:
> On 1 May 2014 01:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Sunday, April 27, 2014 02:28:50 PM Russell King wrote:
> >> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >
> > Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> >
> > Since you need this one and [2/5] for the rest of the patchset, please feel
> > free to take them through your tree if that's convenient.
> 
> Unless it complicates things for Russell, I would prefer if this could
> go via Rafael's tree.
> 
> I have a quite big patchset for the PM domain, it would help me if I
> have a single point to base my work upon.

No problem for me, but I'm not sure about what Russell things.

> Additionally, you have Tomasz Figa patchset below to consider for the
> PM domain code.
> 
> [PATCH v3 0/3] Generic Device Tree based power domain look-up

This one seems to have been under discussion recently, however.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
