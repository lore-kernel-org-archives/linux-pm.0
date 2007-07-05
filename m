From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 14:39:36 +0200
Message-ID: <200707051439.37737.rjw__11165.7625450336$1183638868$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707041139100.25704-100000@netrider.rowland.org>
	<200707042336.58466.rjw@sisk.pl>
	<E1I6Mq2-0008WB-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6Mq2-0008WB-00@dorka.pomaz.szeredi.hu>
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
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, 5 July 2007 10:37, Miklos Szeredi wrote:
> > > Pro-freezers say:
> > > 
> > >   - don't remove the freezer, otherwise we'll have to deal with
> > >     numerous problems in drivers
> > 
> > And these problems will generally be difficult to reproduce reliably
> > and debug.
> 
> I see exactly the opposite.
> 
> With the freezer I can have very rarely occuring failures, due to
> freeze ordering effects.

The "freezer ordering effects" only affect uninterruptible tasks.
 
> And without the freezer I have a 100% reproducable problem, that is
> not hard to fix according to Alan Stern.  OK, I don't know what the
> next problem would be, but the powermac experience shows, that it's
> not nearly as bad as you and Oliver try to make it out.

The powermac need not be a good example due to the different code ordering
(it's run on one CPU only, which makes the probability of triggering a race
be quite low).

> > > Can this be fixed?
> > > 
> > > It seems to be a fundamental problem with the freezer: while it does
> > > make sure that user processes are not calling into drivers during
> > > suspend, it also disallows perfectly harmless non-driver calls as
> > > well.
> > 
> > The problem is that when the freezer was designed (I didn't do that, BTW),
> > there was no FUSE and similar things, so it's not prepared to cope with
> > such interdependencies between user space tasks.
> > 
> > We had an analogous problem with vfork() and it was solved by using the
> > PF_FREEZER_SKIP flag.  Perhaps we can do similar thing with FUSE.
> 
> It cannot be just worked around in fuse, as a task might be sleeping
> on a number of VFS mutexes as well (i_mutex, s_vfs_rename_mutex, etc).
> It would be a gigantic hack, possible at all.

Well, obviously FUSE and the freezer don't play well together, but that's FUSE
who's late in the game (the freezer was here before). ;-)

If you give me some time, I'll see what can be done.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
