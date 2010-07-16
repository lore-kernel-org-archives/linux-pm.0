From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Fri, 16 Jul 2010 14:18:00 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6127BF3__34506.7106107765$1279270159$gmane$org@dbde02.ent.ti.com>
References: <20100714132255.GB3103@ucw.cz>
	<20100715.083450.193689911.Hiroshi.DOYU@nokia.com>
	<20100715084118.GB26212@n2100.arm.linux.org.uk>
	<20100715.120807.39160135.Hiroshi.DOYU@nokia.com>
	<20100716075243.GB16124@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100716075243.GB16124@n2100.arm.linux.org.uk>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "Yoshiya.Hirase@nokia.com" <Yoshiya.Hirase@nokia.com>, "Reddy,
	Teerth" <teerth@ti.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hiroshi,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Russell King - ARM Linux
> Sent: Friday, July 16, 2010 1:23 PM
> To: Hiroshi DOYU
> Cc: linux-arm-kernel@lists.infradead.org; pavel@ucw.cz;
> khilman@deeprootsystems.com; Reddy, Teerth; linux-pm@lists.linux-
> foundation.org; Yoshiya.Hirase@nokia.com; linux-omap@vger.kernel.org
> Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
> 
> On Thu, Jul 15, 2010 at 12:08:07PM +0300, Hiroshi DOYU wrote:
> > From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
> > Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
> > Date: Thu, 15 Jul 2010 10:41:18 +0200
> >
> > > On Thu, Jul 15, 2010 at 08:34:50AM +0300, Hiroshi DOYU wrote:
> > >> Russell, would it be possible to put this into your next merge queue?
> > >
> > > I think it needs quite a bit of rework - I certainly don't like all
> > > those CP15 register accesses there - that's asking for lots of ifdefs
> > > to spring up as more CPUs are supported.
> > >
> > > Eg, what about ensuring that state such as iWMMXt on PXA CPUs is
> > > properly restored?
> >
> > Right. This arch specific part can be something like
> > "suspend-v[3-7].S" to accomodate those differences
> 
> It's not quite that simple - things like iWMMXt aren't part of the ARM
> arch specs.
> 
> > > We already have code which knows what needs to be saved across a
> > > power-off transition - its what we use for our normal suspend/resume
> > > functionality, so we should look at re-using that code for hibernate
> > > as well.  We really don't want to be maintaining two sets of code
> > > doing the same thing.
> >
> > Could you explain which code you're refering for the existing one?
> 
> The code which handles saving state for the existing suspend/resume
> support.  This code already saves the necessary state from CP15 and
> any other state which needs to be saved prior to putting the system
> into low power mode.
> 
> Every machine class which supports suspend today has their own chunk
> of code which does this, normally called something like sleep.S
> 
When this getting developed in TI, we had one more concern about handling
the trustzone part for the CP15 resgiters.
This patch will hang on restoration on some devices implementing trustzone.

Regards,
Santosh
