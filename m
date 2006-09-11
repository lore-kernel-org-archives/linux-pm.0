From: Pavel Machek <pavel@ucw.cz>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Mon, 11 Sep 2006 23:06:34 +0200
Message-ID: <20060911210634.GI11901@elf.ucw.cz>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	<450530BD.8090101@gmail.com> <20060911193637.GA11901@elf.ucw.cz>
	<c728abebb17f975089390dd3f87069af@nomadgs.com>
	<20060911200636.GC11901@elf.ucw.cz>
	<20060911200936.GA12433@elf.ucw.cz>
	<6d5d95c88706be8a338f703579cd62b9@nomadgs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <6d5d95c88706be8a338f703579cd62b9@nomadgs.com>
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
Cc: Preece Scott-PREECE <scott.preece@motorola.com>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2006-09-11 13:33:00, Matthew Locke wrote:
> On Sep 11, 2006, at 1:09 PM, Pavel Machek wrote:
> >On Mon 2006-09-11 22:06:36, Pavel Machek wrote:
> >>On Mon 2006-09-11 12:53:27, Matthew Locke wrote:
> >>>On Sep 11, 2006, at 12:36 PM, Pavel Machek wrote:
> >
> >>>btw, if people on this list are not ready to ACK PowerOP, I would =

> >>>like
> >>>to hear why before we go elsewhere.   It looks like all major issues
> >>>have been addressed by our approach and implementation.
> >
> >Oh and I am pretty tired of teaching you 'how to submit a patch', so
> >if I'm quiet, do not take it as an "ACK".
...
> What does your going quiet mean?  You have had some good feedback so I =

> much prefer we reach some sort of understanding.  If your final =

> statement is that PowerOP is not needed and you are never going to like =

> it or ACK It, let us know.  We can agree to disagree.

You got the interfaces wrong. While I believe that something like
powerop can indeed be useful for system-on-chip platforms, I do not
think it should be exposed outside of kernel.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
