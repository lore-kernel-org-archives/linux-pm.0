From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] [RFC] firewire: Add ohci1394 PCI runtime
	power management support
Date: Wed, 13 Jan 2010 22:29:57 +0100
Message-ID: <201001132229.57231.rjw__32398.5976669521$1263418295$gmane$org@sisk.pl>
References: <1263336982-15424-1-git-send-email-mjg@redhat.com>
	<4B4D1A2F.4020103@s5r6.in-berlin.de>
	<20100113143312.GA21292@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100113143312.GA21292@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Wednesday 13 January 2010, Matthew Garrett wrote:
> On Wed, Jan 13, 2010 at 01:56:15AM +0100, Stefan Richter wrote:
> > Matthew Garrett wrote:
> > > For sanity purposes, the code ensures that the phy is recent enough to
> > > implement the required functionality. It also ensures that all ports have
> > > the interrupt enabled - a VIA chip I've tested appears to only allow
> > > int_enable to be set on one port at a time, which is inadequate for the
> > > purposes of this code.
> > 
> > This adds more extensive use of the link--PHY interface than we ever
> > had, and FireWire stacks in other popular OSs may not have used these
> > features yet too.  We will most certainly discover further errata
> > besides the one that you already found.
> 
> I don't doubt it. There's almost certainly serious dragons here on some 
> hardware.
> 
> > > This depends on the PCI runtime PM code, which is not yet upstream. I'm
> > > sending this out now for sanity checking.
> > 
> > Is there a convenient source where I can get the infrastructure, so that
> > I could start testing with the few cards that I have?
> 
> Rafael posted the latest set to linux-acpi on the 27th of December. I 
> don't think there's a set online yet.

In fact, I posted an update last Sunday (Jan 10), that should be included into
the PCI linux-next branch shortly.

The latest patches are here:
http://patchwork.kernel.org/patch/72020/
http://patchwork.kernel.org/patch/72026/
http://patchwork.kernel.org/patch/72019/
http://patchwork.kernel.org/patch/72015/
http://patchwork.kernel.org/patch/72030/
http://patchwork.kernel.org/patch/72021/
http://patchwork.kernel.org/patch/72029/
http://patchwork.kernel.org/patch/72028/
http://patchwork.kernel.org/patch/72027/

Rafael
