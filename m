From: Pavel Machek <pavel@suse.cz>
Subject: Re: bus.suspend_prepare()
Date: Wed, 26 Jul 2006 12:12:01 +0200
Message-ID: <20060726101201.GI1905@elf.ucw.cz>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<Pine.LNX.4.64.0607251127420.29649@g5.osdl.org>
	<200607251217.48960.david-b@pacbell.net>
	<200607260824.15221.ncunningham@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200607260824.15221.ncunningham@linuxmail.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wed 2006-07-26 08:24:11, Nigel Cunningham wrote:
> Hi.
> =

> On Wednesday 26 July 2006 05:17, David Brownell wrote:
> > On Tuesday 25 July 2006 11:29 am, Linus Torvalds wrote:
> > > On Tue, 25 Jul 2006, David Brownell wrote:
> > > > Hmm ... I just noticed that the swsusp code path (PM_SUSPEND_DISK)
> > > > is ignoring the new suspend_prepare() mechanism.
> > > >
> > > > That doesn't seem like a good thing ... Linus, is there a reason you
> > > > did it that way?
> > >
> > > Just because I found that neither interesting nor testable in my
> > > environment.
> >
> > Yeah, testable is an issue.  Maybe a better fix would be to remove
> > the bus.suspend_prepare() operation for now.  Someone with real use
> > cases could easily add a complete working package that includes that
> > mechanism plus some testable code that needs it.
> =

> Not knowing anything about the actual details of the problem, I wonder if =

> these new calls would help with that acpi issue where it tries to allocat=
e =

> memory with GFP_KERNEL during drivers suspend. Would it be helpful

No, ACPI runs its code very early, and it can not be preallocated.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
