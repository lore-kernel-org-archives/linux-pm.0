From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 3/3] PM: New suspend and hibernation
	callbacks for PCI bus type
Date: Wed, 19 Mar 2008 14:24:48 +0100
Message-ID: <200803191424.49443.rjw@sisk.pl>
References: <200803170020.55473.rjw@sisk.pl> <200803170025.16149.rjw@sisk.pl>
	<20080319005508.GD8298@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080319005508.GD8298@kroah.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 19 of March 2008, Greg KH wrote:
> On Mon, Mar 17, 2008 at 12:25:15AM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Implement new suspend and hibernation callbacks for the PCI busi type.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  drivers/pci/pci-driver.c |  497 ++++++++++++++++++++++++++++++++++++++++++-----
> >  include/linux/pci.h      |    2 
> >  2 files changed, 453 insertions(+), 46 deletions(-)
> 
> Hm, that's a lot of code added.  What additional functionality did we
> just get?

The possibility to handle suspend/hibernation in a more flexible way, provided
that the drivers define the new callbacks.

> Are we going to have to create a noirq version for every driver and bus
> type now?

No, we aren't.  The PCI and platform bus types already have the noirq callbacks
implemented (they are called _late and _early, but that's the same
essentially).

Thanks,
Rafael
