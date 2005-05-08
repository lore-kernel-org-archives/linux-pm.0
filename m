From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: [RFC] Linux Power Management
Date: Sun, 8 May 2005 11:39:23 -0700
Message-ID: <200505081139.24099.david-b@pacbell.net>
References: <1115094736.28902.167.camel@localhost.localdomain>
	<20050505041214.GA21223@neo.rr.com>
	<20050505093830.GA3260@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============81183912837421568=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050505093830.GA3260@elf.ucw.cz>
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

--===============81183912837421568==
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thursday 05 May 2005 2:38 am, Pavel Machek wrote:
> > > No. It took 2+ years to add at at least system power states. You want
> > > to build on that, not scratch it and start over.

But Pavel, since you started to push all those pm_message_t patches,
you've effectively REMOVED the entire visibility of system power states
to drivers ... they no longer have any information they can use to choose
the right device power state based on the upcoming system state.

This whole pm_message_t thing was pretty darn close to a "start over".
(Though that wasn't the original goal.)

Before those patches, pretty much everything **EXCEPT SWSUSP** (I had
to examine the whole kernel tree, and study how the PM framework had
evolved since 2.4...) was good about the integer suspend() parameter being
an ACPI S-number for the target system state.  And there were drivers
that used that information ... the primary problem was that those numbers
weren't documented as such, so confusion came when swsusp created its
own new/incompatible theory about what the integers meant.  (Rather than
adopting and/or formalizing the pre-existing model, with its enums.)

What you've done with those patches is (a) force all drivers and subsystems
to change, while (b) removing even the possibility for drivers to choose
target device states based on knowledge of the target system state, and
(c) breaking the drivers that DID choose states intelligently.

In short, the problem is that you _removed_ the previous driver-visible
notion of system power.  Now here you're complaining about Adam noticing
that the status quo ante was really a better direction.  Basically giving
him the same treatment you've given me for making that same point.  Forgive
me if I remain un-persuaded.



> > I was wondering, however, what do you have in mind for adding to pm_message_t?
> > Also, are you going to use "PMSG_HALT" and/or "PMSG_REBOOT"?
> 
> If I added PMSG_REBOOT, I'd have to modify all the drivers to support
> it. Incompatible change, bad.

You're going to have to do that to support PMSG_FREEZE already... as
you note.  What was your _previous_ plan for getting FREEZE to behave,
then?  Given what's happened so far, I have to conclude you never
really expected (or wanted) something that suspend() parameter to
be used for anything except the magic number "3".  (Which is used
for both FREEZE and SUSPEND now...)

If you really had believed incompatible changes were bad, you'd
not have chosen the approach you did for pm_message_t.  You would
have instead just formalized the existing model, using the existing
enum (used inside pmcore, except by swsusp) for a "strong" type
that sparse would check.


> We already have something close enough, PMSG_FREEZE. That means that
> drivers will do right thing by default. If someone really needs to
> tell between normal freeze and reboot, we can add a flag; but I'm not
> 100% convinced it is neccessary.

So what's your current rationale for FREEZE then?  The original
motivation was to have a "quiesced" state for drivers, distinct
from a full fledged SUSPEND, to avoid pointless suspend/resume
cycles in the middle of swsusp.


What you're arguing here is effectively that the parameter to
all suspend methods can never change.  Ergo it's useless, and
we might as well just have removed it in the first place!!!

Of course, one flaw in that argument is that there _are_ in fact
different system power states, and some drivers do need to choose
device states accordingly...

- Dave

--===============81183912837421568==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============81183912837421568==--
