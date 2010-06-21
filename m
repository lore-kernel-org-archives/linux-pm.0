From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC][PATCH] PM: Avoid losing wakeup events during
	suspend
Date: Sun, 20 Jun 2010 23:02:40 -0700 (PDT)
Message-ID: <357982.4867.qm__33271.142448257$1277100243$gmane$org@web180304.mail.gq1.yahoo.com>
References: <799617.66764.qm@web180304.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <799617.66764.qm@web180304.mail.gq1.yahoo.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org, Alan Stern <stern@rowland.harvard.edu>
Cc: Neil Brown <neilb@suse.de>, linux-pm@lists.linux-foundation.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mark gross <640e9920@gmail.com>
List-Id: linux-pm@vger.kernel.org



--- On Sun, 6/20/10, David Brownell <david-b@pacbell.net> wrote:

... in a sort of "aren't we asking the
wrong questions??" manner ... =



I suspect that
looking at the problem in terms of how to
coordinate subsystems (an abstraction which
is at best very ad-hoc today!) we would
end up with a cleaner model, which doesn't
bother so many folk the ay wakelocks or
even suspend blockers seem to bother them...


> From: David Brownell <david-b@pacbell.net>
> Subject: Re: [linux-pm] [RFC][PATCH] PM: Avoid losing wakeup events durin=
g suspend
> To: markgross@thegnar.org, "Alan Stern" <stern@rowland.harvard.edu>
> Cc: "Neil Brown" <neilb@suse.de>, linux-pm@lists.linux-foundation.org, "D=
mitry Torokhov" <dmitry.torokhov@gmail.com>, "Linux Kernel Mailing List" <l=
inux-kernel@vger.kernel.org>, "mark gross" <640e9920@gmail.com>
> Date: Sunday, June 20, 2010, 9:04 PM
> =

> > > > Indeed, the same problem arises if the
> event
> > isn't delivered to
> > > > userspace until after userspace is frozen.
> =

> Can we put this more directly:=A0 the problem is
> that the *SYSTEM ISN'T FULLY SUSPENDED* when the
> hardware wake event triggers?=A0 (Where "*SYSTEM*
> includes userspace not just kernel.=A0 In fact the
> overall system is built from many subsystems,
> some in the kernel and some in userspace.
> =

> At the risk of being prematurely general:=A0 I'd
> point out that these subsystems probably have
> sequencing requirements.=A0 kernel-then-user is
> a degenerate case, and surely oversimplified.
> There are other examples, e.g. between kernel
> subsystems...=A0 Like needing to suspend a PMIC
> before the bus it uses, where that bus uses
> a task to manage request/response protocols.
> (Think I2C or SPI.)
> =

> This is like the __init/__exit sequencing mess...
> =

> In terms of userspace event delivery, I'd say
> it's a bug in the event mechanism if taking the
> next step in suspension drops any event.=A0 It
> should be queued, not lost...=A0 As a rule the
> hardware queuing works (transparently)...
> =

> > Of course, the underlying
> > > > issue here is that the kernel has no direct
> way
> > to know when userspace
> > > > has finished processing an event.
> =

> =

> Again said more directly:=A0 there's no current
> mechanism to coordinate subsystems.=A0 Userspace
> can't communicate "I'm ready" to kernel, and
> vice versa.=A0 (a few decades ago, APM could do
> that ... we dropped such mechanisms though, and
> I'm fairly sure APM's implementation was holey.)
> =

> =

> =

> =

> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
> =
