From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: Hibernation considerations
Date: Tue, 24 Jul 2007 00:10:34 +0200
Message-ID: <200707240010.35639.rjw__46718.6756585308$1185228210$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707231120380.3545-100000@iolanthe.rowland.org>
	<200707240755.01820.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707240755.01820.nigel@nigel.suspend2.net>
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
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: david@lang.hm, Miklos Szeredi <miklos@szeredi.hu>, nigel@suspend2.net, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Monday, 23 July 2007 23:55, Nigel Cunningham wrote:
> Hi.
> 
> On Tuesday 24 July 2007 01:23:15 Alan Stern wrote:
> > On Mon, 23 Jul 2007, Nigel Cunningham wrote:
> > 
> > > Take a step back for a second.
> > > 
> > > The problem we're facing now is that we're getting some userspace threads, 
> > > used in processing I/O, that are functioning as exceptions to the "freeze 
> > > userspace, then freezeable kernel threads" rule. They are only exceptions 
> > > because of that role in processing I/O - because they're de facto kernel 
> > > threads. So, if we orient our thinking more in terms of I/O processing and 
> > > less in terms of the userspace/kernelspace distinction, we'll have a 
> > > solution:
> > > 
> > > 1) Freeze processes that aren't fs related (ie stop them generating I/O).
> > 
> > The problem here is that with things like FUSE, _every_ process is 
> > potentially fs related.  Nothing prevents a FUSE thread from doing IPC 
> > with any other thread.
> 
> Yes, but the fuse thread is going to know what other thread it's doing IPC 
> with, so it can get that thread flagged too.

Yes, but that thread may do IPC with yet another one and so on.

> > > 2) Flush pending I/O.
> > > 3) Freeze filesystems in reverse order of dependency, the primary purpose 
> > > being to stop them generating further I/O on their metadata.
> > > 
> > > Locks that are being held are only being held because work is being done. 
> If 
> > > we progressively focus on threads in terms of their create/process work 
> > > dependencies, we'll see that the problem isn't at all intractable.
> > 
> > As has been mentioned before, keeping track of all that dependency 
> > information would be very fragile and time-consuming.
> 
> I disagree. It's at least going to be less fragile and time-consuming then 
> maintaining new/extra code for kexec.

Well, I think the issue is real, so we need to find a solution (the simpler,
the better) and that need not be related to kexec. ;-)

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
