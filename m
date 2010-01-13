From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] [RFC] firewire: Add ohci1394 PCI runtime
 power	management support
Date: Wed, 13 Jan 2010 19:45:43 +0100
Message-ID: <4B4E14D7.5080801__46871.0367721089$1263408413$gmane$org@s5r6.in-berlin.de>
References: <1263336982-15424-1-git-send-email-mjg@redhat.com>
	<4B4D1A2F.4020103@s5r6.in-berlin.de>
	<20100113143312.GA21292@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100113143312.GA21292@srcf.ucam.org>
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
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Matthew Garrett wrote:
> On Wed, Jan 13, 2010 at 01:56:15AM +0100, Stefan Richter wrote:
>> Matthew Garrett wrote:
>>> +	for (i = 0; i < OHCI_LOOP_COUNT; i++) {
>>> +		*val = reg_read(ohci, OHCI1394_PhyControl);
>>> +		if (*val & OHCI1394_PhyControl_ReadDone)
>>> +			break;
>>> +		mdelay(1);
>>> +	}
>> Gone is the msleep, here comes the mdelay.  I suspect all that can be
>> implemented in a non-atomic context, can't it?  I.e. tasklet ->
>> worklet...  May possibly require to convert the bus reset tasklet to a
>> worklet too, which may have a few benefits on its own right.
> 
> Yeah, that might well be a bonus. The phy accesses should only be at 
> startup or in response to a bus reset or cable connection state change, 
> so I wouldn't have thought that there'd be any noticable performance 
> impact. I'll look at changing it in a followup patch.

Bus resets may happen for various reasons.  Ongoing isochronous
transmissions are supposed to continue after a bus reset and self
identification phase as seamlessly as possible.  Especially with an eye
on audio streams, new latency sources should be avoided.  (People who
are into studio audio or live audio will avoid causes for bus resets
during sessions though.)

>> Furthermore, these polling loops --- at least the ones after a
>> reg_write(..., OHCI1394_PhyControl_Read(..)) --- could then be replaced
>> by an interrupt driven mechanism.  (Except in those usages of
>> ohci_update_phy_reg() when we do not have interrupts enabled.)
> 
> Oh, ok - I hadn't realised there was an interrupt to indicate that.

Might turn out too awkward though due to the interrupts off situation in
ohci_enable().

[...]
>>> +		  OHCI1394_PhyControl_Write(addr, r));
>>> +
>>> +	for (i = 0; i < OHCI_LOOP_COUNT; i++) {
>>> +		r = reg_read(ohci, OHCI1394_PhyControl);
>>> +		if (!(r & OHCI1394_PhyControl_WriteDone))
>>> +			break;
>>> +	}
>> Forgot an mdelay?
> 
> I wondered about that, but there wasn't one in the ieee1394 code. 
> Presumably the register reads take long enough that it settles within 
> the loop count?

Hmm, drivers/ieee1394/ohci1394.c::get_phy_reg and set_phy_reg both have
an mdelay in their poll loops.  I don't see other OHCI1394_PhyControl
accesses.

[...]
>> [BTW, some cards may actually have a second PHY hardwired to the PHY
>> which is attached to the link.  For example, Mac Pro have a second PHY
>> for the front panel ports.  But your approach is unable to figure that
>> out either.  And it doesn't matter because battery powered devices do
>> not have more than one PHY per link.]
> 
> Hrm. That's potentially a problem. Will this always show up as a 
> connection being present on the first PHY?

Yes.  It is indistinguishable from an externally plugged-in hub or
repeater, or some kinds of external node whose link is powered down.

> If so it'll just effectively 
> disable the power management, which isn't ideal but at least doesn't 
> break anything.

Yep.

>>> +
>>> +	if (ohci_read_phy_reg(card, 2, &val))
>>> +		return -EBUSY;
>> Since its caller does not check for error return,
>> ohci_configure_wakeup() can just return void.
> 
> Hm. Should probably actually check the return value instead.

Should it?  I understood that this just enables or disables runtime PM
capability for this ohci instance, without a need for further error
handling.
-- 
Stefan Richter
-=====-==-=- ---= -==-=
http://arcgraph.de/sr/
