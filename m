From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Sleep problems with kernels >= 2.6.21 on powerpc
Date: Wed, 5 Sep 2007 12:44:11 -0700
Message-ID: <20070905124411.bc15f48c.akpm__42018.5712552213$1189021640$gmane$org@linux-foundation.org>
References: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>
	<6bffcb0e0708261621q25316becqce7b3ae2176f45a8@mail.gmail.com>
	<20070827065246.GA21220@ime.usp.br> <46D279E8.10001@edge.ping.de>
	<46D72BC6.3020809@edge.ping.de>
	<20070905100754.57ab4e3e.akpm@linux-foundation.org>
	<46DEEBBE.4070201@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46DEEBBE.4070201@s5r6.in-berlin.de>
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
Cc: michal.k.k.piotrowski@gmail.com, rbrito@gmail.com, krh@redhat.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org, linux-pm@lists.linux-foundation.org, rael@edge.ping.de
List-Id: linux-pm@vger.kernel.org

> On Wed, 05 Sep 2007 19:47:42 +0200 Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> Andrew Morton wrote:
> >>> Trying to free already-free IRQ 40
> >>> pci_set_power_state(): 0002:20:0e.0: state=3, current state=5
> >>> firewire_ohci: pci_set_power_state failed with -22<3>pci_device_suspend(): pci_suspend+0x0/0x9c [firewire_ohci]() returns -22
> > 
> > I grepped the whole tree for firewire_ohci and came up blank.  What is it?
> 
> drivers/firewire/fw-ohci.c -> fw-ohci.o -> firewire-ohci.o ->
> firewire-ohci.ko

argh.  It's not the first time that the module system's weird
replace-dash-with-underscore thing has fooled me.

> > But yes, a failed pci_set_power_state() will hurt.  Perhaps this is
> > a result of some recently-added return-value checking fix but as I
> > cannot find the dang code I cannot tell.
> 
> The old ohci1394.c used to ignore pci_set_power_state's return value.
> In the pre 2.6.19-rc1 commit ea6104c22468239083857fa07425c312b1ecb424, I
> added a fail-on-error.  This was toned down to a printk-on-err by pre
> 2.6.19-rc4 commit 346f5c7ee7fa4ebee0e4c96415a7e59716bfa1d0.

OK.

> This was because of Benjamin Herrenschmidt's regression report:
> http://lkml.org/lkml/2006/10/24/13

It's not clear _why_ pci_set_power_state() is failing.

> A trivial post -rc1 compatible fix is coming in a minute.

neato, thanks.
