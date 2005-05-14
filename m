From: Fabrice Gautier <Fabrice_Gautier@sdesigns.com>
Subject: RE: A reference implementation of PCI suspend/resume?
Date: Fri, 13 May 2005 22:06:42 -0700
Message-ID: <9F77D654ED40B74CA79E5A60B97A087B0310DCD4@sd-exchange.sdesigns.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============10820098379592236=="
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
To: Shaohua Li <shaohua.li@intel.com>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============10820098379592236==
Content-Type: text/plain

Hi,

> From: Shaohua Li [mailto:shaohua.li@intel.com] 
> Sent: Wednesday, May 11, 2005 6:25 PM
> To: linux-pm
> Subject: [linux-pm] A reference implementation of PCI suspend/resume?
> 
> Hi,
> There are still many PCI drivers don't implement their 
> .suspend/.resume
> methods correctly. I felt it would be quite helpful there is 
> a reference
> implementation. Here is my thought:
> 
> [...snip...]
> 
> Currently many drivers don't call
> free_irq/request_irq/pci_disable_device, which makes unexpected
> interrupt occur and even break suspend/resume in some systems. 

I don't understand why not calling free_irq would cause unexpected
interrupts.

The way I understand the PCI spec is: if you suspend a PCI device, its IRQ
should be disabled. If an IRQ come from this device anyway (in violation of
the spec) then the driver for this device should handle it so you should NOT
unregister its irq_handler.
(How does such a device would handle such a irq is another matter - a device
specific one I guess)

I'm not understanding where your unexpected interrupt is coming from.

Care to elaborate?

Btw: I'm suspending PCI devices not in the context of a full suspend
situation, maybe that's why I'm missing your point. But your sample
implementation should work in both cases.

  Thanks

-- Fabrice


--===============10820098379592236==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============10820098379592236==--
