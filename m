From: David Brownell <david-b@pacbell.net>
Subject: Re: A reference implementation of PCI suspend/resume?
Date: Mon, 16 May 2005 17:26:42 -0700
Message-ID: <200505161726.42479.david-b@pacbell.net>
References: <9F77D654ED40B74CA79E5A60B97A087B0310DCD4@sd-exchange.sdesigns.com>
	<20050516201606.GA11189@neo.rr.com>
	<20050516151937.63b37fbb@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============10769431391186268=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050516151937.63b37fbb@cosmic.amd.com>
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
List-Id: linux-pm@vger.kernel.org

--===============10769431391186268==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 16 May 2005 2:19 pm, Jordan Crouse wrote:
> On Mon, 16 May 2005 16:16:06 -0400
> "Adam Belay" <ambx1@neo.rr.com> wrote:
> 
> > b.) You're assuming every device has its own interrupt.  This may not
> > be the case.  Let's say one device was sharing interrupts with a few
> > other devices...
> 
> I ran into this very problem a while back on 2.4. On my platform, the
> EHCI and OCHI host controllers share an interrupt.  ...
> 
> Now, granted that particular scenario is a corner case, and the PCI
> hardware should have been configured better, but it shows that you
> can't assume that any given interrupt handler will only be called with
> active hardware underneath.

Very true, and that's part of why drivers/usb/core/hcd-pci.c frees
IRQs during suspend, and reclaims them later.

AFAICT that code is the most generic PCI suspend/resume code now
available ... since it's got to work with dozens of different
implementations of EHCI, OHCI, and UHCI; with widely varying
BIOS versions and bugs; and where not all controllers support
the PCI PM extensions.

Note the wierdnesses there ... cases where the PCI API calls are
wierdly asymmetric, and where "swsusp" can really bork things
by entering bizarre "resume" paths.

- Dave

--===============10769431391186268==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============10769431391186268==--
