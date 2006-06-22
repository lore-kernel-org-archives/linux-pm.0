From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 22 Jun 2006 11:30:30 -0700
Message-ID: <200606221130.30614.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<1150952298.3633.20.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606220909220.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606220909220.5498@g5.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thursday 22 June 2006 9:10 am, Linus Torvalds wrote:
> =

> The fact that worries me is that suspend-to-ram DOES NOT WORK FOR PEOPLE. =

> I have never _ever_ met a laptop or machine of mine that "just worked". =

> I've always had to fix something, and people always end up having to do =

> something ridiculous like unlink all modules etc.

And when I've looked at the causes of such problems, they've been
either (a) driver bugs, or (b) ACPI bugs.  As you know, both of
them are hard to debug, especially when the symptom is on resume
paths with no console.  (Oooh, see $SUBJECT, this isn't offtopic!!)


> If that isn't what worries you, you're on the wrong page. =


I'm an equal-opportunity worry wart in this case, since the same
has applied to the swsusp hibernate support.  :)

- Dave
