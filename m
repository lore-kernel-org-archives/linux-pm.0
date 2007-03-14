From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH/RFC] PCI prepare/activate instead of enable
 to avoid IRQ storm and rogue DMA access
Date: Wed, 14 Mar 2007 13:04:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0703141302480.7723-100000@iolanthe.rowland.org>
References: <20070314152302.GB15600@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070314152302.GB15600@htj.dyndns.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, linux-ide@vger.kernel.org, tglx@linutronix.de, michal.k.k.piotrowski@gmail.com, Jeff Garzik <jeff@garzik.org>, linux-pm@lists.osdl.org, linux-pci@atrey.karlin.mff.cuni.cz, gregkh@suse.de, shemminger@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 15 Mar 2007, Tejun Heo wrote:

> Hello, all.
> =

> This patch started off from the following thread.
> =

>   http://thread.gmane.org/gmane.linux.ide/16899
> =

> The problem is that a PCI device can be in any arbitrary when it gets
> enabled and the device has to be enabled for its driver to
> initialize/reset it.  The most common case this causes headache is as
> follows.
> =

> Let's assume there's a device which shares its INTX IRQ line with
> another device and the other one is already initialized.  During boot,
> due to BIOS's fault, bad hardware design or sheer bad luck, the device
> has got a pending IRQ.  When its driver enables the device, the
> pending IRQ hits INTX.  The IRQ line has been enabled by the other
> driver sharing the IRQ but IRQ handler for this device hasn't been
> registered yet.  So, screaming interrupts.  IRQ subsystem shuts up the
> IRQ line in an attempt to save the machine from complete lockup and
> both devices end up dead.

In several cases this problem has indeed come up and been fixed by adding
a PCI quirk routine to turn off the device's pending IRQ.

Alan Stern
