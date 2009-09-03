From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/4] PCI/ACPI PM: Propagate wake-up enable
	upstream
Date: Fri, 4 Sep 2009 00:02:02 +0200
Message-ID: <200909040002.02562.rjw__34693.844713229$1252015861$gmane$org@sisk.pl>
References: <200908300041.14541.rjw@sisk.pl> <200909012103.19761.rjw@sisk.pl>
	<200909020041.57754.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909020041.57754.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 02 September 2009, Rafael J. Wysocki wrote:
> On Tuesday 01 September 2009, Rafael J. Wysocki wrote:
> > On Tuesday 01 September 2009, Matthew Garrett wrote:
> > > On Mon, Aug 31, 2009 at 11:24:20PM +0200, Rafael J. Wysocki wrote:
> > > 
> > > > Updated patch is appended, but there's a problem with it.  Namely, when the
> > > > root bridge GPE is shared with other devices, those devices are also enabled
> > > > to wake up and they may be kind of "interesting" (on one of my test boxes they
> > > > include the ethernet and audio adapters).  I'm not sure what to do about that.
> > > 
> > > Perhaps only enable it if a child device is enabled?
> > 
> > Well, the problem is that we have to enable the devices that share the GPE to
> > wake up together, but the child device we _really_ want to wake-up need not
> > be any of them.
> > 
> > Also, the child device may be enabled to wake up after we've run the "glue"
> > code.
> > 
> > Well, perhaps it's better to rework pci_enable_wake() so that it, if the device
> > doesn't have an ACPI handle and is not PCIe, it will go and enable the root
> > bridge to wake up as well?
> > 
> > I wonder what about the bridges between the desired wake-up device and the
> > root bridge.  I guess they also should be enabled to wake-up, so that they can
> > forward the PME# in case the system is designed this way.
> 
> Below is a prototype of what I was thinking of, although I'm not sure if that's
> enough.
> 
> Comments welcome.

Hm, no comments. :-(

In the meantime I spent some time on this problem and prepared the following
series of patches.

The last one has to be tested on the system it was invented for, but that's
going to take some time.

Comments welcome.

Rafael
