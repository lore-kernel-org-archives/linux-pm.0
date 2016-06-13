From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] PCI / PM: enforce type casting for pci_power_t
Date: Mon, 13 Jun 2016 16:19:33 +0300
Message-ID: <1465823973.30123.15.camel@linux.intel.com>
References: <1465321713-146178-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20160611001956.GH16462@localhost>
 <1465818054.30123.10.camel@linux.intel.com>
	 <20160613131346.GA11051@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:26914 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423115AbcFMNSO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Jun 2016 09:18:14 -0400
In-Reply-To: <20160613131346.GA11051@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Mon, 2016-06-13 at 08:13 -0500, Bjorn Helgaas wrote:
> On Mon, Jun 13, 2016 at 02:40:54PM +0300, Andy Shevchenko wrote:
> > On Fri, 2016-06-10 at 19:19 -0500, Bjorn Helgaas wrote:
> > > On Tue, Jun 07, 2016 at 08:48:33PM +0300, Andy Shevchenko wrote:
> > > > When cast pci_power_t type of variables a static analizer tool
> > > > complains on
> > > > that.
> > > >=20
> > > > 	include/linux/pci.h:119:37: warning: cast from
> > > > restricted
> > > > pci_power_t
> > > >=20
> > > > Enforce type casting to make static analizer happy.
> > > >=20
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.c=
o
> > > > m>
> > >=20
> > > Applied to pci/pm for v4.8, thanks, Andy.
> >=20
> > Thanks.
> >=20
> > By the way, what was the main point to use __bitwise annotation to
> > this
> > type in the first place?
>=20
> I don't know.=C2=A0=C2=A0It looks like pci_power_t was the first use =
of
> __bitwise in
> pci.h, added by e8191db240d2 ("[PATCH] PCI: Cleanup PCI power
> states").
> That changelog mentions type-safety, but I must admit that doesn't
> make it
> obvious to me.

I'm asking since any code which is using this type (all direct
assignments or comparisons) brings a static analyzer complain.
You may check by yourself with (my usual command to build kernel)

% make C=3D1 CF=3D-D__CHECK_ENDIAN__ W=3D1 -j64

--=C2=A0
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
