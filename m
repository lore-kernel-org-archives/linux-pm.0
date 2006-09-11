From: Pavel Machek <pavel@ucw.cz>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Tue, 12 Sep 2006 00:50:33 +0200
Message-ID: <20060911225033.GA13474@elf.ucw.cz>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	<450530BD.8090101@gmail.com> <20060911193637.GA11901@elf.ucw.cz>
	<c728abebb17f975089390dd3f87069af@nomadgs.com>
	<20060911200636.GC11901@elf.ucw.cz>
	<20060911200936.GA12433@elf.ucw.cz>
	<6d5d95c88706be8a338f703579cd62b9@nomadgs.com>
	<20060911210634.GI11901@elf.ucw.cz>
	<c63579dda747a35a5ba48ba5495b3d72@nomadgs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <c63579dda747a35a5ba48ba5495b3d72@nomadgs.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matt@nomadgs.com>
Cc: Preece Scott-PREECE <scott.preece@motorola.com>, pm list <linux-pm@lists.osdl.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

> >>What does your going quiet mean?  You have had some good feedback so I
> >>much prefer we reach some sort of understanding.  If your final
> >>statement is that PowerOP is not needed and you are never going to =

> >>like
> >>it or ACK It, let us know.  We can agree to disagree.
> >
> >You got the interfaces wrong. While I believe that something like
> >powerop can indeed be useful for system-on-chip platforms, I do not
> >think it should be exposed outside of kernel.
> =

> =

> Ok.  I don't think its wrong because its designed from understanding =

> the requirements of pm software for embedded mobile devices.   I
>think =

> the embedded folk all agree that the type of interface submitted is =

> required.  I don't understand why you think its wrong.  Just to be =


So you'll have to do lots of explaining. On lkml.

> clear, your previous email made it very clear you don't like the =

> userspace interface but this email says interfaces generically.  =


I meant user<->kernel interface.

> assuming your only objection at this point is the userspace interface.  =

>  We are more than willing to work this out.  The current sysfs =

> interface is surrounded by ifdefs and is optional.  If there is no =

> exposure to userspace, then testing/debuging will be more difficult.

Having interface surrounded by #ifdefs is evil. You can test it
separately, then just remove that code before submission. Or maybe
move it to debugfs.

> Greg, Pavel, Dominik, Dave J and Dave B,
> =

> I would like to get a plan in place for acceptance with the power =

> management guys before we move this to lkml.  =


Documentation/SubmittingPatches says:
#5) Select your CC (e-mail carbon copy) list.
#
#Unless you have a reason NOT to do so, CC
#linux-kernel@vger.kernel.org.

and sorry, but I insist on using proper procedure here. And no, "we
are afraid of being flamed" is not good enough reason not to.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
