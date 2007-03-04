From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/3] swsusp: Do not use page flags (was: Re:
	Remove page flags for software suspend)
Date: Sun, 4 Mar 2007 14:50:01 +0100
Message-ID: <200703041450.02178.rjw@sisk.pl>
References: <Pine.LNX.4.64.0702160212150.21862@schroedinger.engr.sgi.com>
	<45E6EEC5.4060902@yahoo.com.au> <200703011633.54625.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200703011633.54625.rjw@sisk.pl>
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
To: Nick Piggin <nickpiggin@yahoo.com.au>, Pavel Machek <pavel@ucw.cz>
Cc: linux-mm@kvack.org, Johannes Berg <johannes@sipsolutions.net>, Christoph Lameter <clameter@engr.sgi.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 1 March 2007 16:33, Rafael J. Wysocki wrote:
> On Thursday, 1 March 2007 16:18, Nick Piggin wrote:
> > Rafael J. Wysocki wrote:
> > > On Wednesday, 28 February 2007 16:25, Christoph Lameter wrote:
> > > =

> > >>On Wed, 28 Feb 2007, Pavel Machek wrote:
> > >>
> > >>
> > >>>I... actually do not like that patch. It adds code... at little or no
> > >>>benefit.
> > >>
> > >>We are looking into saving page flags since we are running out. The t=
wo =

> > >>page flags used by software suspend are rarely needed and should be t=
aken =

> > >>out of the flags. If you can do it a different way then please do.
> > > =

> > > =

> > > As I have already said for a couple of times, I think we can and I'm =
going to
> > > do it, but right now I'm a bit busy with other things that I consider=
 as more
> > > urgent.
> > =

> > I need one bit for lockless pagecache ;)
> > =

> > Anyway, I guess if you want something done you have to do it yourself.
> > =

> > This patch still needs work (and I don't know if it even works, because
> > I can't make swsusp resume even on a vanilla kernel). But this is my
> > WIP for removing swsusp page flags.
> > =

> > This patch adds a simple extent based nosave region tracker, and
> > rearranges some of the snapshot code to be a bit simpler and more
> > amenable to having dynamically allocated flags (they aren't actually
> > dynamically allocated in this patch, however).
> =

> Thanks for the patch.
> =

> Probably I'd like to do some things in a different way, I'll think about =
that
> later today.
> =

> I hope I'll have a working patch that removes the "offending" page flags =
after
> the weekend.

Okay, the next three messages contain patches that should do the trick.

They have been tested on x86_64, but not very thoroughly.

Greetings,
Rafael
