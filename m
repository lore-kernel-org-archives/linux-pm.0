From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: freeze_processes questions
Date: Wed, 6 Apr 2005 15:20:42 -0700
Message-ID: <200504061520.42917.david-b@pacbell.net>
References: <200504051120.44496.rjw@sisk.pl>
	<200504061434.34050.david-b@pacbell.net>
	<1112825000.3757.77.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============67372910054225255=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1112825000.3757.77.camel@desktop.cunningham.myip.net.au>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ncunningham@cyclades.com
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============67372910054225255==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 06 April 2005 3:03 pm, Nigel Cunningham wrote:
> Hi David.
> 
> On Thu, 2005-04-07 at 07:34, David Brownell wrote:
> > On Tuesday 05 April 2005 4:10 pm, Nigel Cunningham wrote:
> > > 
> > > In this way, I handle kseriod and anything else uninterruptible without
> > > any problems.
> > 
> > This may be off-topic for this thread ... but does anyone
> > have system wakeup from PS/2 keyboard/mouse working?
> 
> Never tried it, I'm afraid. My keyboard has 'Power', 'Sleep' and 'Wake'
> buttons, but they seem to be directly connected to /dev/null.
> 
> There's a /proc/acpi entry that controls the enabling wake events. Have
> you tried fiddling with it?

That's what didn't work.  (Combined with entering S1 then trying
to use the relevant buttons ... or for that matter, any buttons.)

- Dave


> Regards,
> 
> Nigel
> 
> > Last time I tried to use it, it didn't work.  Not clear where
> > the problem was, but I suspect it was a case of ACPI support
> > not having anything to hook up to in the driver.
> > 
> > Hence the (potential) relevance on this thread:  the current
> > approach to suspend/resume in serio drivers needing updating,
> > which may interact with how kseriod is used.
> > 
> > - Dave
> > 
> >   
> -- 
> Nigel Cunningham
> Software Engineer, Canberra, Australia
> http://www.cyclades.com
> Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574
> 
> Maintainer of Suspend2 Kernel Patches http://suspend2.net
> 
> 

--===============67372910054225255==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============67372910054225255==--
