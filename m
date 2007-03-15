From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH/RFC] PCI prepare/activate instead of enable
 to avoid IRQ storm and rogue DMA access
Date: Thu, 15 Mar 2007 14:47:42 +0900
Message-ID: <45F8DDFE.4080504@gmail.com>
References: <20070314152302.GB15600@htj.dyndns.org>
	<20070314215605.GA7194@flint.arm.linux.org.uk>
	<45F87863.9040408@garzik.org>
	<20070314225818.GB7194@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070314225818.GB7194@flint.arm.linux.org.uk>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, michal.k.k.piotrowski@gmail.com, linux-ide@vger.kernel.org, tglx@linutronix.de, shemminger@linux-foundation.org, mlord@pobox.com, linux-pm@lists.osdl.org
Cc: Andi Kleen <ak@suse.de>
List-Id: linux-pm@vger.kernel.org

[cc'ing Andi, Hi!]

Hello,

Russell King wrote:
> On Wed, Mar 14, 2007 at 06:34:11PM -0400, Jeff Garzik wrote:
>> Russell King wrote:
>>> pci_enable_device() doesn't deal with this; in most PCI setups I've
>>> seen, there is no control at PCI level over whether a device generates
>>> an interrupt on the bus.  Certainly the memory and io command enables
>> PCI grew an interrupt enable while you weren't looking: =

>> PCI_COMMAND_INTX_DISABLE
> =

> That's fine for devices which conform to the later PCI specs, but not
> all do.
> =

>> It was added in PCI 2.3 I think.
> =

> Correct.
> =

>> Older PCI devices certainly do not have this standardized bit.
> =

> No PCI device that I have has that bit - including the raid card I
> bought last year...

Many recent ATA and network controllers do and most new ones will
probably do.

> In any case, relying on such a new control bit to implement this kind
> of functionality would result in a very hit and miss result; Linux
> tends to get used on things other than the bleeding edge of hardware
> technology.

I don't think INTX_DISABLE is on the bleeding edge of hardware
technology and many common cases will benefit from using it (just think
about the number of newish notebook users).  The problem with
INTX_DISABLE is that there doesn't seem to be any way to tell whether
writing to that bit is safe or not.

You are right in that turning off IRQ mechanisms in pci_enable_device()
doesn't fix all the problems as PCI-wise it only enables IO and memory
address space access, but to some extent it does because in the arch
code, it enables the IRQ line and the physical IRQ line might not be
shared even if the final IRQ number is shared (Andi, am I correct)?

Anyways, I think the proper solution is to make sure all generic IRQ
controls including INTX turned off early in the boot during PCI
subsystem initialization (ie. do the disable part of
pcim_prepare_device() early in the boot before any IRQ line is
requested) and let each driver enable after initialization as necessary
and do similar things during resume.  Note that drivers still need to be
modified to signify when the device is initialized enough to enable IRQ,
and bus mastering.

We can also arch-dep IRQ enabling to the activation time.  That will
give us more protection even when INTX_DISABLE is not available.

Thanks.

-- =

tejun
