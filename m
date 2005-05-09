From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC] Linux Power Management
Date: Mon, 9 May 2005 21:30:39 +0200
Message-ID: <20050509193039.GD3085@elf.ucw.cz>
References: <1115094736.28902.167.camel@localhost.localdomain>
	<200505081135.56811.david-b@pacbell.net>
	<20050509094904.GA19790@atrey.karlin.mff.cuni.cz>
	<200505090941.49405.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============25382070415079255=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200505090941.49405.david-b@pacbell.net>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============25382070415079255==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > If they use GPIO lines on chip that eats so much power that it must be
> > power-managed... yes, I'd call that broken hardware.
> 
> By virtue of being in the driver model, it _is_ managed no
> matter how much power it uses (or doesn't use).  The issue
> isn't how much power it uses.  It's the expectation that all
> power signals only flow parallel to data and control busses,
> as they would on daughtercard based designs.
> 
> I'd tend to agree with hardware guys on this one:  this is
> such a simple case that only broken _software_ should have
> trouble handling it.
> 
> 
> > Of course, current pm core *is* inadequate for even simple uses...
> 
> Right, and GPIO based power switching is a "simple use".
> Luckily the init sequence tweaks I described make Linux
> work with it, until selective suspend kicks in.

Well, GPIO power switching should be very easy to handle ... as long
as path between CPU and GPIO-based-power-switches takes little
power. When we don't have to power-manage the path between CPU and
GPIO-based-power-switches, we are fine...
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============25382070415079255==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============25382070415079255==--
