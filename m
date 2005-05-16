From: Shaohua Li <shaohua.li@intel.com>
Subject: RE: A reference implementation of PCI suspend/resume?
Date: Mon, 16 May 2005 16:55:34 +0800
Message-ID: <1116233734.7314.7.camel@linux-hp.sh.intel.com>
References: <9F77D654ED40B74CA79E5A60B97A087B0310DCD4@sd-exchange.sdesigns.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============32385206120670684=="
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

--===============32385206120670684==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-05-13 at 22:06 -0700, Fabrice Gautier wrote:
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
> 
> The way I understand the PCI spec is: if you suspend a PCI device, its IRQ
> should be disabled. If an IRQ come from this device anyway (in violation of
> the spec) then the driver for this device should handle it so you should NOT
> unregister its irq_handler.
> (How does such a device would handle such a irq is another matter - a device
> specific one I guess)
> 
> I'm not understanding where your unexpected interrupt is coming from.
> 
> Care to elaborate?
I actually don't know the exact reason but we did notice disabling a
device isn't sufficient (an 'irq nobody card' is reported after a device
is disabled). I think we should not trust device.
Another point is resume is just like boot. At boot time, PIC/IOAPIC/irq
router are disabled by default. They are enabled only when a device
really starts using them. suspend/resume should be the same manner.

Thanks,
Shaohua


--===============32385206120670684==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============32385206120670684==--
