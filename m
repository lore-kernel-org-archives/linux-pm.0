From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Thu, 20 Aug 2009 11:24:50 +0800
Message-ID: <20090820032450.GD26357__12807.0742277943$1250738838$gmane$org@sli10-desk.sh.intel.com>
References: <1250666651.23178.116.camel@sli10-desk.sh.intel.com>
	<20090819115210.GC12216@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090819115210.GC12216@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 19, 2009 at 07:52:10PM +0800, Matthew Garrett wrote:
> On Wed, Aug 19, 2009 at 03:24:11PM +0800, Shaohua Li wrote:
> 
> > Usually driver should does nothing in the op as bus can handle it. But in some
> > cases, like pci bus, UHCI controller doesn't use standard PME registers for
> > wakeup, instead of using special approach. In this case, UHCI controller driver
> > should implement this op.
> 
> I'm not averse to the general concept, but I'm not entirely sold on it 
> being necessary. All the hardware I'm aware of will send non-PME events 
> as a notification on a specific device. Under what circumstances will we 
> get a wakeup GPE for a non-PME device without knowing which device 
> should be woken?
Below code is gotten from a laptop (samsung-x10), the PCIB is the PCI bridge.
We can't guarantee the device which gets a wakeup event notification is really
the device which invokes the wakeup event.

	Device (PCIB)
        {
                Name (_ADR, 0x001E0000)
                Device (CDB0)
		{
		    Name (_ADR, 0x00030000)
		}
		 Device (CDB1)
                {
                    Name (_ADR, 0x00030001)

		}
	}


        Method (_L0B, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.PCIB, 0x02)
            Notify (\_SB.PWRB, 0x02)
            Store (0x01, \_SB.PCI0.PCIB.CDB0.PMES)
            Store (0x01, \_SB.PCI0.PCIB.CDB1.PMES)
        }

Thanks,
Shaohua
