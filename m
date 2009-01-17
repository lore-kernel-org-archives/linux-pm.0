From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 084/123] USB: fix up suspend and resume for
 PCI host controllers
Date: Sun, 18 Jan 2009 08:23:52 +1100
Message-ID: <1232227432.23611.33.camel__10164.8373216905$1232227611$gmane$org@pasglop>
References: <Pine.LNX.4.44L0.0901161805450.4593-100000@iolanthe.rowland.org>
	<1232167552.23611.20.camel@pasglop>  <200901171421.12389.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901171421.12389.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 2009-01-17 at 14:21 +0100, Rafael J. Wysocki wrote:
> On Saturday 17 January 2009, Benjamin Herrenschmidt wrote:
> > 
> > > Not exactly.  Just try this patch:
> > > 
> > > 	http://marc.info/?l=linux-kernel&m=123184641714487&w=2
> > > 
> > > with vanilla 2.6.29-rc1 or rc2.
> > 
> > Out of curiosity, while pci_disable_device() before save_state() ?
> 
> Because on resume we call pci_restore_state() before pci_(re)enable_device().

But that doesn't sound correct to me.

In some cases, pci_enable_device() is hooked by the architecture to
effectively turn on the device, ie, enable clocks or power, etc... I've
seen embedded stuff like that and some PowerMac devices do that too
(though not those USB ones in that specific case).

I think nothing should happen before pci_enable_device()

Ben.
