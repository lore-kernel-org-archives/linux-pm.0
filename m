From: David Brownell <david-b@pacbell.net>
Subject: Re: bus.suspend_prepare()
Date: Tue, 25 Jul 2006 12:17:47 -0700
Message-ID: <200607251217.48960.david-b@pacbell.net>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200607251117.32105.david-b@pacbell.net>
	<Pine.LNX.4.64.0607251127420.29649@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607251127420.29649@g5.osdl.org>
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
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Tuesday 25 July 2006 11:29 am, Linus Torvalds wrote:
> =

> On Tue, 25 Jul 2006, David Brownell wrote:
> >
> > Hmm ... I just noticed that the swsusp code path (PM_SUSPEND_DISK)
> > is ignoring the new suspend_prepare() mechanism.
> > =

> > That doesn't seem like a good thing ... Linus, is there a reason you
> > did it that way?
> =

> Just because I found that neither interesting nor testable in my =

> environment.

Yeah, testable is an issue.  Maybe a better fix would be to remove
the bus.suspend_prepare() operation for now.  Someone with real use
cases could easily add a complete working package that includes that
mechanism plus some testable code that needs it.


> >		  Why is there no sibling resume_complete()?  ISTR
> > that Ben was the advocate of a suspend_prepare(), but the use cases
> > for this call are unclear to me ...
> =

> Havign a resume_complete() would be nice for a number of things, like =

> reloading firmware etc (which usually requires not just the device being =

> back and fully working, but more importantly, requires user space to be =

> alive again).

I thought the idea there was that suspend_prepare() would preload that
firmware into memory, so it could just be written in bus.resume() ... not
that anyone worked through that completely, including the obvious issues
like firmware images which wouldn't fit in available memory.

The symmetry of a resume_complete() after class.resume() is obvious, but the
usage is still unclear to me.  Consider a network driver, where we'd expect
class suspend/resume eventually does the netif_device_{detach,attach}().

Those need to be done AFTER the firmware gets reloaded/restarted.  So either
the class suspend/resume is unhelpful, or the prepare/complete stuff is ...

As I said:  "unclear".

- Dave
