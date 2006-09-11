From: Pavel Machek <pavel@ucw.cz>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Mon, 11 Sep 2006 21:55:46 +0200
Message-ID: <20060911195546.GB11901@elf.ucw.cz>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	<b0623b9bb79afacc77cddc6e39c96b62@nomadgs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <b0623b9bb79afacc77cddc6e39c96b62@nomadgs.com>
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
Cc: pm list <linux-pm@lists.osdl.org>, Preece Scott-PREECE <scott.preece@motorola.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> I know its confusing having oppoint (from Dave Singleton) and powerop =

> being discussed at the same time.  However, I believe we (PowerOP)
> have =


Yes, it is.

> - PowerOP is only one layer (towards the bottom) in a power management =

> solution.
> - PowerOP does *not* replace cpufreq

PowerOP provides userland interface for changing processor
frequency. That's bad -- duplicate interface.

> - The PowerOP interface was discussed in detail on this list and we =

> haven't heard any negative comments.

Eh? Was I on different list?

> - We are not advocating the integration with sleep states.  We want to =

> get the PowerOP interface accepted and then we can build on it.

Good.

> We have a few more comments from Greg to take care of and  we can add a =

> Documentation/ file. Then I think its time to get the PowerOP patches =

> in the queue for acceptance.    Any comments about this?

Well, you'll only get good interface review when you have
Documentation/ , and it needs to go to lkml before it goes to any
queues.
								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
