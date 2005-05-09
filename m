From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [RFC] Linux Power Management
Date: Mon, 9 May 2005 10:35:38 +0200
Message-ID: <20050509083538.GB5718@atrey.karlin.mff.cuni.cz>
References: <1115094736.28902.167.camel@localhost.localdomain>
	<20050505041214.GA21223@neo.rr.com>
	<20050505093830.GA3260@elf.ucw.cz>
	<200505081139.24099.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============87740595701231761=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200505081139.24099.david-b@pacbell.net>
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

--===============87740595701231761==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > I was wondering, however, what do you have in mind for adding to pm_message_t?
> > > Also, are you going to use "PMSG_HALT" and/or "PMSG_REBOOT"?
> > 
> > If I added PMSG_REBOOT, I'd have to modify all the drivers to support
> > it. Incompatible change, bad.
> 
> You're going to have to do that to support PMSG_FREEZE already... as
> you note.  What was your _previous_ plan for getting FREEZE to behave,
> then?  Given what's happened so far, I have to conclude you never
> really expected (or wanted) something that suspend() parameter to
> be used for anything except the magic number "3".  (Which is used
> for both FREEZE and SUSPEND now...)
> 
> If you really had believed incompatible changes were bad, you'd
> not have chosen the approach you did for pm_message_t.  You would
> have instead just formalized the existing model, using the existing
> enum (used inside pmcore, except by swsusp) for a "strong" type
> that sparse would check.

PMSG_REBOOT is not good enough reason to go through all the
drivers. PMSG_FREEZE can be used, instead.

> > We already have something close enough, PMSG_FREEZE. That means that
> > drivers will do right thing by default. If someone really needs to
> > tell between normal freeze and reboot, we can add a flag; but I'm not
> > 100% convinced it is neccessary.
> 
> So what's your current rationale for FREEZE then?  The original
> motivation was to have a "quiesced" state for drivers, distinct
> from a full fledged SUSPEND, to avoid pointless suspend/resume
> cycles in the middle of swsusp.

It still holds. PMSG_FREEZE is quiesced state, usefull for at least
swsusp and reboot.

> What you're arguing here is effectively that the parameter to
> all suspend methods can never change.  Ergo it's useless, and
> we might as well just have removed it in the first place!!!

No, I'm not argument that parameter to suspend methods can never
change. It will change in 2.6.12. It will have 3 values, PMSG_FREEZE
and PMSG_SUSPEND (and PMSG_ON, if you want to store state somewhere).

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============87740595701231761==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============87740595701231761==--
