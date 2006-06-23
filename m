From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 09:43:35 -0700
Message-ID: <200606230943.36320.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606222235210.18690-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606222235210.18690-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday 22 June 2006 7:41 pm, Alan Stern wrote:
> =

> > That applies only during system sleep state transitions.
> =

> Well yes, of course.  We were talking about system sleep, not runtime PM.
> =

> >  If you
> > try to invoke selective suspend (only part of the driver model tree
> > rather than the whole thing), all such ordering is ignored.  And
> > for USB, selective suspend is a fundamental mechanism for reducing
> > systems' runtime power usage.
> =

> Ben never suggested device creation or removal should be prevented during =

> selective suspend, and you never mentioned encountering any deadlocks =

> because of it.  So why do you bring it up?

Because the PM framework needs to handle both problems, and the
models need to recognize that fact.  We already have too many bugs
due to assumptions that are only correct in specific contexts.

Bringing up such issues is a precursor to getting them the right
kind of attention.  Contrariwise, ignoring those issues worsens them.

- Dave
