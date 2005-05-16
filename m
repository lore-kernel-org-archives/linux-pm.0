From: Fabrice Gautier <Fabrice_Gautier@sdesigns.com>
Subject: RE: A reference implementation of PCI suspend/resume?
Date: Mon, 16 May 2005 12:02:07 -0700
Message-ID: <9F77D654ED40B74CA79E5A60B97A087B0310DD26@sd-exchange.sdesigns.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============26668227590841775=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
Cc: Fabrice Gautier <Fabrice_Gautier@sdesigns.com>
List-Id: linux-pm@vger.kernel.org

--===============26668227590841775==
Content-Type: text/plain

> From: David Brownell [mailto:david-b@pacbell.net] 
> Sent: Sunday, May 15, 2005 9:54 PM
> To: linux-pm@lists.osdl.org
> Cc: Fabrice Gautier; Shaohua Li
> Subject: Re: [linux-pm] A reference implementation of PCI 
> suspend/resume?
> 
> On Friday 13 May 2005 10:06 pm, Fabrice Gautier wrote:
> 
> > The way I understand the PCI spec is: if you suspend a PCI 
> > device, its IRQ should be disabled. If an IRQ come from
> > this device anyway (in violation of
> > the spec) then the driver for this device should handle it 
> > so you should NOT unregister its irq_handler.
> 
> There's PCI ... and PCI with PM capabilities.  That rule about only
> issuing PME transactions while suspended can only apply in the latter
> case.  That is, not all PCI devices support the PCI PM rules; drivers
> may need to help the hardware.

You mean, you support some kind of power management on PCI devices without
PM capabilities ? How are you even sure that the pci_set_power_state will
work in those kind of devices.
 
In any case, anyway it works I would say this is very much device specific
and not really part of a reference implementation. This is supposed to be a
reference implementation for "PCI PM compliant" devices right ?

-- Fabrice

--===============26668227590841775==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============26668227590841775==--
