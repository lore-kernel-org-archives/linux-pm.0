From: David Brownell <david-b@pacbell.net>
Subject: Re: A reference implementation of PCI suspend/resume?
Date: Mon, 16 May 2005 12:39:53 -0700
Message-ID: <200505161239.54238.david-b@pacbell.net>
References: <9F77D654ED40B74CA79E5A60B97A087B0310DD26@sd-exchange.sdesigns.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============79107320781417467=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <9F77D654ED40B74CA79E5A60B97A087B0310DD26@sd-exchange.sdesigns.com>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============79107320781417467==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 16 May 2005 12:02 pm, Fabrice Gautier wrote:
> > 
> > There's PCI ... and PCI with PM capabilities.  That rule about only
> > issuing PME transactions while suspended can only apply in the latter
> > case.  That is, not all PCI devices support the PCI PM rules; drivers
> > may need to help the hardware.
> 
> You mean, you support some kind of power management on PCI devices without
> PM capabilities ? How are you even sure that the pci_set_power_state will
> work in those kind of devices.

Linux must certainly support suspend() and resume() methods for such
devices.  In terms of PCI PM terminology, they will either stay in
the PCI_D0 state during suspend, or go into PCI_D3cold ... and in
the latter case, the device driver's resume() is going to have to
know how to reinit from a reset state.  (They already have code to
init from that state, so it should be no problem.)

By definition, pci_set_power_state() will be a NOP.  There might
be firmware that knows how to switch power on/off, or maybe not;
that would be board-specific.


> In any case, anyway it works I would say this is very much device specific
> and not really part of a reference implementation. This is supposed to be a
> reference implementation for "PCI PM compliant" devices right ?

It was supposed to be a reference implementation, yes.  But if it was
only for one subset of PCI devices, I didn't notice any suggestion of
that before now.  The "works for small subset" implementation wouldn't
be anywhere near as useful.

- Dave




--===============79107320781417467==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============79107320781417467==--
