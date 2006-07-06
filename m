From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: memcpy() in swsusp (was: Re: [PATCH 2/2] Fix console
	handling during suspend/resume)
Date: Thu, 6 Jul 2006 16:26:53 +0200
Message-ID: <200607061626.53761.rjw@sisk.pl>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200607061522.32674.rjw@sisk.pl>
	<200607060719.44915.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607060719.44915.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 06 July 2006 16:19, David Brownell wrote:
> =

> > > > > I have seen that before: Atomic snapshot used fpu copy in some wr=
ong
> > > > > variants. Symptom was exactly that -- elevated preempt count --
> > > > > because fpu copy routine elevated it, then copied the task struct.
> > > > >
> > > > > But I thought we solved that problem...?
> > > >
> > > > We did. We don't use memcpy for precisely that reason. 3DNOW memcpy=
 was one
> > > > of the problem children. This would be a different creature though,
> > > > wouldn't it?
> > > =

> > > Hmm. Aparently we had a parting of ways on this at some point. Memcpy=
 is being =

> > > used by swsusp, and it has been used since before 2.6.12-rc1. (This i=
s when =

> > > doing the atomic copy, not resuming).
> =

> And it could well be that's when this bug appeared.  It's on an Athlon,
> so that theory checks out as well as possible short of a patch.
> =

> =

> > Do you mean the one in copy_data_pages()?  Indeed, that may be a proble=
m if
> > the MMU-based memcpy is used.
> > =

> > Pavel, should we fix this?
> =

> Of course it needs fixing ... it's a bug, also a regression.
> =

> My question is where to fix... swsusp_arch_resume() seems most
> correct, albeit messy.  There's unfortunately no exact parallel
> on the resume side to where the bug was inserted.  Those of us
> who avoid hacking asm code might prefer restore_processor_state().

Well, I meant replacing the memcpy() in copy_data_pages with an open coded
copying loop.  That should be enough to fix the problem.

Rafael
