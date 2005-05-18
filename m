From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: A reference implementation of PCI suspend/resume?
Date: Tue, 17 May 2005 21:26:06 -0400
Message-ID: <20050518012604.GC11189@neo.rr.com>
References: <9F77D654ED40B74CA79E5A60B97A087B0310DCD4@sd-exchange.sdesigns.com>
	<200505171110.47030.rjw@sisk.pl>
	<200505171135.09928.david-b@pacbell.net>
	<200505172128.10344.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============029554905292598743=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200505172128.10344.rjw@sisk.pl>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============029554905292598743==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 17, 2005 at 09:28:10PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, 17 of May 2005 20:35, David Brownell wrote:
> > On Tuesday 17 May 2005 2:10 am, Rafael J. Wysocki wrote:
> > 
> > > Could you please have a look at http://bugzilla.kernel.org/show_bug.cgi?id=4416
> > 
> > Sorry, I don't have much time for such things; especially for
> > problems that only appear in the MM tree (with so many non-USB
> > changes) ... and which already appear to be board-specific, and
> > tied to ACPI changes.
> 
> Never mind.  :-)
> 
> > > There seems to be a problem with OHCI and EHCI drivers wrt suspend/resume
> > > (swsusp) in the current -mm on that box.
> > 
> > Is that with or without those ACPI fixes?
> 
> Both ...
> 
> Rafael
> 

Have you checked which of these device drivers are calling free_irq() in
their suspend routines.  Also could I see /proc/interrupts (with an offending
combination of drivers loaded) and a list of the hardware you think might be
involved.  Have you been able to find a pair of drivers that will cause this
problem?

Thanks,
Adam

--===============029554905292598743==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============029554905292598743==--
