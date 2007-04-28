From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFC/PATCH 2/2] kernel: don't update load average
	=?iso-8859-1?q?during=09snapshot/shutdown?=
Date: Sat, 28 Apr 2007 20:07:17 +0200
Message-ID: <200704282007.18681.rjw@sisk.pl>
References: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>
	<46330550.8020005@cs.helsinki.fi> <200704281249.06774.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704281249.06774.rjw@sisk.pl>
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
To: linux-pm@lists.linux-foundation.org
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.osdl.org, nigel@nigel.suspend2.net, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Saturday, 28 April 2007 12:49, Rafael J. Wysocki wrote:
> On Saturday, 28 April 2007 10:26, Pekka Enberg wrote:
> > Nigel Cunningham wrote:
> > > I therefore have to ask: Please. Go away. Hand the maintainership of
> > > hibernation over to Rafael. Work on things you do care about and where
> > > you do want to see a fully functional implementation. But stop being a
> > > hindrance to us making Linux hibernation support everything that it
> > > ought to be.
> > 
> > [snip]
> > 
> > Please. The load average is a problem and no the fix is not to make 
> > kernel/timer.c worse for everybody but to snapshot the load averages 
> > _before_ I/O and restore them after resume.
> 
> I'm having an impression that this problem is suspend2-specific.  With swsusp
> we can have it only if the writing of snapshot fails.
> 
> Namely, with swsusp we have the pre-snapshot value of the load average in the
> image and it should be, so to speak, "normal".  Then, once we've restored the
> image, this "normal" value gets recovered and everything is fine.  If the writing
> of image fails, we can have a "wrong" (i.e. too high) value of the load average
> afterwards, but then this is an error condition anyway.  At least, as a user, I
> can expect some glitches to happen after a failing hibernation.
> 
> With suspend2, in turn, the contents of LRU pages are saved before we create
> the snapshot.  They can be compressed etc. in the process, so the load average
> can grow quite substantially and this "unusual" load average is then
> snapshotted.  Hence, the problem appears after the restore.  I think the
> solution could be to save the post-tasks-freezing load average and restore it
> right before snapshotting, but that's only needed for suspend2.

Well, I was wrong.  We can have this problem too with swsusp if we need to free
much memory before snapshotting the system.

Greetings,
Rafael
