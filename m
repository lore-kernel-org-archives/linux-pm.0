From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Linux Power Management
Date: Mon, 9 May 2005 09:41:49 -0700
Message-ID: <200505090941.49405.david-b@pacbell.net>
References: <1115094736.28902.167.camel@localhost.localdomain>
	<200505081135.56811.david-b@pacbell.net>
	<20050509094904.GA19790@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============77031278511463519=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050509094904.GA19790@atrey.karlin.mff.cuni.cz>
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
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============77031278511463519==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 09 May 2005 2:49 am, Pavel Machek wrote:
> > > ... However, I don't think this will be common, ...
> > 
> > When you "don't think this will be common" you're basically assuming
> > Linux won't be used on embedded hardware.   Unhealthy assumption!!
> > 
> > It's **really easy** and in fact natural for hardware designers to
> > provide power management relationships that don't directly match
> > the logical bus structure that software likes to use. ...
> 
> Well, people can mess up hardware any way they like, but don't expect
> us to mess up linux to match...

Hardly.  On the other hand, if Linux can't handle such simple
and common hardware models, it's already been messed up.


> If they use GPIO lines on chip that eats so much power that it must be
> power-managed... yes, I'd call that broken hardware.

By virtue of being in the driver model, it _is_ managed no
matter how much power it uses (or doesn't use).  The issue
isn't how much power it uses.  It's the expectation that all
power signals only flow parallel to data and control busses,
as they would on daughtercard based designs.

I'd tend to agree with hardware guys on this one:  this is
such a simple case that only broken _software_ should have
trouble handling it.


> Of course, current pm core *is* inadequate for even simple uses...

Right, and GPIO based power switching is a "simple use".
Luckily the init sequence tweaks I described make Linux
work with it, until selective suspend kicks in.

- Dave

--===============77031278511463519==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============77031278511463519==--
