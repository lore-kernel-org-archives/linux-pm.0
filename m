From: David Brownell <david-b@pacbell.net>
Subject: Re: A reference implementation of PCI suspend/resume?
Date: Sun, 15 May 2005 21:53:54 -0700
Message-ID: <200505152153.54651.david-b@pacbell.net>
References: <9F77D654ED40B74CA79E5A60B97A087B0310DCD4@sd-exchange.sdesigns.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============95126491292918591=="
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
To: linux-pm@lists.osdl.org
Cc: Fabrice Gautier <Fabrice_Gautier@sdesigns.com>
List-Id: linux-pm@vger.kernel.org

--===============95126491292918591==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 13 May 2005 10:06 pm, Fabrice Gautier wrote:

> The way I understand the PCI spec is: if you suspend a PCI device, its IRQ
> should be disabled. If an IRQ come from this device anyway (in violation of
> the spec) then the driver for this device should handle it so you should NOT
> unregister its irq_handler.

There's PCI ... and PCI with PM capabilities.  That rule about only
issuing PME transactions while suspended can only apply in the latter
case.  That is, not all PCI devices support the PCI PM rules; drivers
may need to help the hardware.

- Dave



--===============95126491292918591==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============95126491292918591==--
