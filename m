From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] dmaengine: fsl-edma: add PM suspend/resume support
Date: Thu, 20 Aug 2015 09:38:01 +0530
Message-ID: <20150820040801.GS13546@localhost>
References: <1437469005-3162-1-git-send-email-yao.yuan@freescale.com>
 <CADRPPNQJi_x+mdQV=DEVuhCL_p6VOWcPiV3jzioeRdWgSW2w3g@mail.gmail.com>
 <CY1PR0301MB15628DD5CFCE2B65BF4FECB2837C0@CY1PR0301MB1562.namprd03.prod.outlook.com>
 <CADRPPNS_wzX+mwT0L-H=ZP9w8gH9W4O9KUqnGYiAc39S5v4qLA@mail.gmail.com>
 <CY1PR0301MB1562103588FB0C6BEFDDBF3C83790@CY1PR0301MB1562.namprd03.prod.outlook.com>
 <55D183D1.9020401@nigelcunningham.com.au>
 <CY1PR0301MB1562FBE9818C1973651D2B7183790@CY1PR0301MB1562.namprd03.prod.outlook.com>
 <CADRPPNRaDaUBD1JG_QHrEQ5pKP9Ap1hV+bBdUnC-V32Nzr2qQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADRPPNRaDaUBD1JG_QHrEQ5pKP9Ap1hV+bBdUnC-V32Nzr2qQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Li Yang <leoli@freescale.com>
Cc: Yao Yuan <yao.yuan@freescale.com>, Nigel Cunningham <nigel@nigelcunningham.com.au>, "stefan@agner.ch" <stefan@agner.ch>, Arnd Bergmann <arnd@arndb.de>, Dan Williams <dan.j.williams@intel.com>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 17, 2015 at 02:10:46PM -0500, Li Yang wrote:
> >> Think of it from the end user perspective. Would you like your laptop (or
> >> whatever) to refuse to suspend because of this condition? The user may well
> >> expect that closing the lid on their laptop will reliably lead to it suspending to
> >> ram. Returning a failure here could result in a loss of data if the condition is not
> >> detected and the machine subsequently runs out of power.
> >>
> >
> > Yes, the user may well expect that closing the lid on their laptop will reliably lead to it suspending to ram.
> > So the client(the user of the DMA) must  to PAUSE or terminate the DMA transmission.
> >
> > We need to rely on client doing the right thing here.
> > The DMA should not make a decision instead of client.
> > If the DMA is not idle in DMA suspend, it should be the client's issue.
> > We don't know what the client really want to do, so just return the non-success value.
> 
> The problem here is that neither the client nor the DMA controller
> driver should easily decide to stop the suspend entrance and rollback.
> I don't think the non-idle situation is serious enough to cause a
> rollback.  You should do whatever can be done with the DMA
> controller(such as stop the controller and leave whatever to be done
> to the wake up) and continue with the suspend.

Ideally yes client should suspend first and dmaengine driver then being idle
when suspend is invoked. But we know we are in idle world!
So, driver should ensure it suspends the active channels and then goes to
suspend and restores that on resume

-- 
~Vinod
