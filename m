From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: A reference implementation of PCI suspend/resume?
Date: Tue, 17 May 2005 11:10:46 +0200
Message-ID: <200505171110.47030.rjw@sisk.pl>
References: <9F77D654ED40B74CA79E5A60B97A087B0310DCD4@sd-exchange.sdesigns.com>
	<20050516151937.63b37fbb@cosmic.amd.com>
	<200505161726.42479.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============89825189572565645=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200505161726.42479.david-b@pacbell.net>
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
Cc: David Brownell <david-b@pacbell.net>
List-Id: linux-pm@vger.kernel.org

--===============89825189572565645==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Tuesday, 17 of May 2005 02:26, David Brownell wrote:
> On Monday 16 May 2005 2:19 pm, Jordan Crouse wrote:
> > On Mon, 16 May 2005 16:16:06 -0400
> > "Adam Belay" <ambx1@neo.rr.com> wrote:
> > 
> > > b.) You're assuming every device has its own interrupt.  This may not
> > > be the case.  Let's say one device was sharing interrupts with a few
> > > other devices...
> > 
> > I ran into this very problem a while back on 2.4. On my platform, the
> > EHCI and OCHI host controllers share an interrupt.  ...
> > 
> > Now, granted that particular scenario is a corner case, and the PCI
> > hardware should have been configured better, but it shows that you
> > can't assume that any given interrupt handler will only be called with
> > active hardware underneath.
> 
> Very true, and that's part of why drivers/usb/core/hcd-pci.c frees
> IRQs during suspend, and reclaims them later.
> 
> AFAICT that code is the most generic PCI suspend/resume code now
> available ... since it's got to work with dozens of different
> implementations of EHCI, OHCI, and UHCI; with widely varying
> BIOS versions and bugs; and where not all controllers support
> the PCI PM extensions.
> 
> Note the wierdnesses there ... cases where the PCI API calls are
> wierdly asymmetric, and where "swsusp" can really bork things
> by entering bizarre "resume" paths.

Could you please have a look at http://bugzilla.kernel.org/show_bug.cgi?id=4416

There seems to be a problem with OHCI and EHCI drivers wrt suspend/resume
(swsusp) in the current -mm on that box.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============89825189572565645==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============89825189572565645==--
