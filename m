From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
Subject: RE: [PATCH 04/17] powerpc: mpic: use IRQCHIP_SKIP_SET_WAKE instead of
 redundant mpic_irq_set_wake
Date: Wed, 23 Sep 2015 05:31:03 +0000
Message-ID: <SN1PR0301MB1616CF7415825908030E0C829D440@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
  <1442850433-5903-5-git-send-email-sudeep.holla@arm.com>
 <1442965805.19102.303.camel@freescale.com>
 <SN1PR0301MB1616AD6C1C410ACB49A5D9279D440@SN1PR0301MB1616.namprd03.prod.outlook.com>
 <alpine.DEB.2.11.1509230545580.5606@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1bn0109.outbound.protection.outlook.com ([157.56.110.109]:56320
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751604AbbIWFbH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2015 01:31:07 -0400
In-Reply-To: <alpine.DEB.2.11.1509230545580.5606@nanos>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Scott Wood <scottwood@freescale.com>, Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Hongtao Jia <hongtao.jia@freescale.com>, Marc Zyngier <marc.zyngier@arm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Thomas Gleixner
> Sent: Wednesday, September 23, 2015 11:49 AM
> To: Wang Dongsheng-B40534
> Cc: Wood Scott-B07421; Sudeep Holla; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; Rafael J. Wysocki; Benjamin Herrenschmidt; Paul
> Mackerras; Michael Ellerman; Jia Hongtao-B38951; Marc Zyngier; linuxppc-
> dev@lists.ozlabs.org
> Subject: RE: [PATCH 04/17] powerpc: mpic: use IRQCHIP_SKIP_SET_WAKE instead of
> redundant mpic_irq_set_wake
> 
> On Wed, 23 Sep 2015, Wang Dongsheng wrote:
> > > On Mon, 2015-09-21 at 16:47 +0100, Sudeep Holla wrote:
> > > > mpic_irq_set_wake return -ENXIO for non FSL MPIC and sets IRQF_NO_SUSPEND
> > > > flag for FSL ones. enable_irq_wake already returns -ENXIO if irq_set_wak
> > > > is not implemented. Also there's no need to set the IRQF_NO_SUSPEND flag
> > > > as it doesn't guarantee wakeup for that interrupt.
> > > >
> >
> > Non-freescale return -ENXIO, is there any issue? If non-freescale
> > platform does not support it, but IPs still use
> > enable/disable_irq_wake, we should return a error number.
> 
> You can just set IRQCHIP_SKIP_SET_WAKE for FSL chips and not for the
> others.
> 
> > @Scott:
> > If set this flag we cannot keep a irq as a wakeup source when system going to
> > SUSPEND or MEM.
> >
> > irq_set_wake() means we can set this irq as a wake source.
> > IRQCHIP_SKIP_SET_WAKE is ignore irq_set_wake() feature.
> 
> Nonsense. IRQCHIP_SKIP_SET_WAKE merily tells the core not to bail on
> !chip->irq_set_wake(), but its still marking the interrupt as wakeup
> source and therefor not masking it on suspend.
> 

Sorry, I just check irq_set_irq_wake() code, right, IRQCHIP_SKIP_SET_WAKE also can
going to irqd_set to mask IRQD_WAKEUP_STATE.

Yes, this flag just skip the irq_set_wake() not this feature.

Regards,
-Dongsheng

