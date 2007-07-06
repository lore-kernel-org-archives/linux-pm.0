From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm] PM: Do not sync filesystems from
	within the freezer
Date: Fri, 6 Jul 2007 12:00:36 +0200
Message-ID: <200707061200.37035.rjw__41813.4253741757$1183715684$gmane$org@sisk.pl>
References: <200707041658.59588.rjw@sisk.pl>
	<200707061914.02972.nigel@nigel.suspend2.net>
	<E1I6kA9-0003Zt-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6kA9-0003Zt-00@dorka.pomaz.szeredi.hu>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mjg59@srcf.ucam.org, nigel@suspend2.net, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Friday, 6 July 2007 11:31, Miklos Szeredi wrote:
> > > > On Fri, 2007-07-06 at 09:13 +0200, Miklos Szeredi wrote:
> > > > > 
> > > > > Another myth, that has been debunked already.  The problem is: how do
> > > > > you define fuse processes?  There's no theoretical or even practial
> > > > > way to do that.
> > > > 
> > > > It could if they told the kernel via some black magic ...
> > > > 
> > > > But that still suck. The freezer sucks :-)
> > > 
> > > Yeah, and it wouldn't work in practice, since the auxilary tasks might
> > > be part of a library which is not even aware of being used by a "fuse
> > > task".
> > 
> > This is why I think the whole concept of filesystems in userspace is broken. 
> > Trying to shift things that need special privilege and special handling to 
> > userspace is just asking for trouble.
> 
> I'm not claiming fuse doesn't introduce problems.  I've been tackling
> those problems for a number of years now.  Suspend/hibernate is just
> the next thing that needs looking at.
> 
> Just blaming either suspend or fuse for these problems is unproductive
> and stupid.

Well, the "stupid" part is a bit offensive, don't you think?

> The problems _are_ solvable if not always simply. 

Agreed.

> > You can say it's the kernel code's fault, but then you have to
> > explain why it's only fuse (yeah ok, and XFS) that have problems.
> 
> I'm not faulting anythig.  My opinion, is that the freezer is not
> needed for suspend, and removing it will not just solve the problems
> with fuse but several others.  It probably needs a lot of work, but
> hey, that's why we are here.
> 
> The patch posted by Rafael, which lets the freezer skip uninterrupible
> tasks is a step in the right direction.

Thanks.

BTW, I think that this is just less radical than the change proposed by Matthew
and it should address the underlying problems.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
