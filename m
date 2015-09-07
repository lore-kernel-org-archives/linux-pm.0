From: Yao Yuan <yao.yuan@freescale.com>
Subject: RE: [PATCH v2] dmaengine: fsl-edma: add PM suspend/resume support
Date: Mon, 7 Sep 2015 07:41:53 +0000
Message-ID: <BLUPR03MB134EC0560527216B7D729EE83540@BLUPR03MB134.namprd03.prod.outlook.com>
References: <1437469005-3162-1-git-send-email-yao.yuan@freescale.com>
 <CADRPPNQJi_x+mdQV=DEVuhCL_p6VOWcPiV3jzioeRdWgSW2w3g@mail.gmail.com>
 <CY1PR0301MB15628DD5CFCE2B65BF4FECB2837C0@CY1PR0301MB1562.namprd03.prod.outlook.com>
 <CADRPPNS_wzX+mwT0L-H=ZP9w8gH9W4O9KUqnGYiAc39S5v4qLA@mail.gmail.com>
 <CY1PR0301MB1562103588FB0C6BEFDDBF3C83790@CY1PR0301MB1562.namprd03.prod.outlook.com>
 <55D183D1.9020401@nigelcunningham.com.au>
 <CY1PR0301MB1562FBE9818C1973651D2B7183790@CY1PR0301MB1562.namprd03.prod.outlook.com>
 <CADRPPNRaDaUBD1JG_QHrEQ5pKP9Ap1hV+bBdUnC-V32Nzr2qQw@mail.gmail.com>
 <20150820040801.GS13546@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bl2on0107.outbound.protection.outlook.com ([65.55.169.107]:10709
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751224AbbIGHl5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 03:41:57 -0400
In-Reply-To: <20150820040801.GS13546@localhost>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Li Leo <LeoLi@freescale.com>
Cc: Nigel Cunningham <nigel@nigelcunningham.com.au>, "stefan@agner.ch" <stefan@agner.ch>, Arnd Bergmann <arnd@arndb.de>, Dan Williams <dan.j.williams@intel.com>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, Aug 20, 2015 at 12:08:00PM +0800, Vinod Koul wrote:
> On Mon, Aug 17, 2015 at 02:10:46PM -0500, Li Yang wrote:
> > >> Think of it from the end user perspective. Would you like your
> > >> laptop (or
> > >> whatever) to refuse to suspend because of this condition? The user
> > >> may well expect that closing the lid on their laptop will reliably
> > >> lead to it suspending to ram. Returning a failure here could result
> > >> in a loss of data if the condition is not detected and the machine
> subsequently runs out of power.
> > >>
> > >
> > > Yes, the user may well expect that closing the lid on their laptop will reliably
> lead to it suspending to ram.
> > > So the client(the user of the DMA) must  to PAUSE or terminate the DMA
> transmission.
> > >
> > > We need to rely on client doing the right thing here.
> > > The DMA should not make a decision instead of client.
> > > If the DMA is not idle in DMA suspend, it should be the client's issue.
> > > We don't know what the client really want to do, so just return the non-
> success value.
> >
> > The problem here is that neither the client nor the DMA controller
> > driver should easily decide to stop the suspend entrance and rollback.
> > I don't think the non-idle situation is serious enough to cause a
> > rollback.  You should do whatever can be done with the DMA
> > controller(such as stop the controller and leave whatever to be done
> > to the wake up) and continue with the suspend.
> 
> Ideally yes client should suspend first and dmaengine driver then being idle
> when suspend is invoked. But we know we are in idle world!
> So, driver should ensure it suspends the active channels and then goes to
> suspend and restores that on resume
> 

Hi Vinod, 
Hi Leo,

Is there any other discussions?

I think we can have the following solutions for DMA driver:
1, Force terminate the active channels in its suspend and then return.
2, DMA have to wait until the active channels idle.
3, Don't care about the active channels and direct return.
4, Return BUS BUSY error and stop PM progress.


I prefer the last one, because I think client should make sure the channel is idle. 

But also the first one should be works.

Can we have a conclusion and suggestion for which one is better?

Thanks.


