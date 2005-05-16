From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: A reference implementation of PCI suspend/resume?
Date: Mon, 16 May 2005 16:16:06 -0400
Message-ID: <20050516201606.GA11189@neo.rr.com>
References: <9F77D654ED40B74CA79E5A60B97A087B0310DCD4@sd-exchange.sdesigns.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============026894229676388104=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <9F77D654ED40B74CA79E5A60B97A087B0310DCD4@sd-exchange.sdesigns.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Fabrice Gautier <Fabrice_Gautier@sdesigns.com>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============026894229676388104==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 13, 2005 at 10:06:42PM -0700, Fabrice Gautier wrote:
> Hi,
> 
> > From: Shaohua Li [mailto:shaohua.li@intel.com] 
> > Sent: Wednesday, May 11, 2005 6:25 PM
> > To: linux-pm
> > Subject: [linux-pm] A reference implementation of PCI suspend/resume?
> > 
> > Hi,
> > There are still many PCI drivers don't implement their 
> > .suspend/.resume
> > methods correctly. I felt it would be quite helpful there is 
> > a reference
> > implementation. Here is my thought:
> > 
> > [...snip...]
> > 
> > Currently many drivers don't call
> > free_irq/request_irq/pci_disable_device, which makes unexpected
> > interrupt occur and even break suspend/resume in some systems. 
> 
> I don't understand why not calling free_irq would cause unexpected
> interrupts.

I don't think it would.  However, there are three reasons in favor of
unregister PCI interrupts:

a.) the kernel will complain if the irq isn't handled, revealing a possible
problem with the driver's suspend routine.

b.) You're assuming every device has its own interrupt.  This may not be the
case.  Let's say one device was sharing interrupts with a few other devices.
We don't want it's interrupt handler to mess up things when it tries to read
hardware registers from a physically "off" device, as it may possibly generate
errors.  Almost every interrupt handler assumes the device is "on", as it
should.  Each interrupt handler has to ask its hardware if it generated the
interrupt.

c.) Selective device suspending: obviously we don't want to leave stale
interrupt handlers around.


> 
> The way I understand the PCI spec is: if you suspend a PCI device, its IRQ
> should be disabled. If an IRQ come from this device anyway (in violation of
> the spec) then the driver for this device should handle it so you should NOT
> unregister its irq_handler.

This would be a quirk.

> (How does such a device would handle such a irq is another matter - a device
> specific one I guess)

It would need a special case for handling suspend time interrupts.  This
would vary between situation and brokeness.

> 
> I'm not understanding where your unexpected interrupt is coming from.
> 
> Care to elaborate?

Like I said, another device on the same link is one possible problem.

> 
> Btw: I'm suspending PCI devices not in the context of a full suspend
> situation, maybe that's why I'm missing your point. But your sample
> implementation should work in both cases.

Yes, although I think we need to specify the situation to the driver in case
it needs to do something special, in general, the full and partial device
suspends should be very similar.

Thanks,
Adam

--===============026894229676388104==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============026894229676388104==--
