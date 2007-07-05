From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 15:28:17 +0200
Message-ID: <200707051528.18766.rjw__48595.0458715253$1183641810$gmane$org@sisk.pl>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<20070705115400.GF3984@ucw.cz>
	<E1I6Q73-0000Xi-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6Q73-0000Xi-00@dorka.pomaz.szeredi.hu>
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
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, 5 July 2007 14:07, Miklos Szeredi wrote:
> > > Actually fuse allows SIGKILL, because it's always fatal, and the
> > > syscall may not be restarted.
> > 
> > I think you want to stick try_to_freeze() at the same places where you
> > do SIGKILL handling. That should solve the 'syslogd is unfreezeable'
> > problem.
> 
> I could, but it would not solve the general problem.  Namely, that the
> presence of fuse imposes a certain ordering in which userspace tasks
> have to be frozen.  And it is not possible to know this ordering.
> 
> And even if the ordering were solved, the freezer would still not work
> if the filesystem is not responding due to external events, such as a
> lost network (this affects NFS, CIFS, whatever just the same as fuse).
> 
> > Plus, it would be nice to find out where suspend/hibernation is
> > triggering fuse activity. We can then decide where to fix it -- in
> > fuse or in suspend parts. You said sys_sync is not implemented... so
> > where is the problem?
> 
> I cannot say without having a sysrq-t of the situation.
> 
> > > > That's very special, and maybe even a FUSE bug. And that is also
> > > > what makes FUSE special w.r.t. s2ram.
> > > 
> > > What makes fuse special is that some file operations are synchronous
> > > and non-restartable.  That's just how the UNIX filesystem API works
> > > and is hardly a bug in fuse.
> > 
> > Well, unix is not plan9, and maybe userland filesystems are impossible
> > in unix. But that is hardly a bug in unix :-).
> 
> I'd rather say, reliable suspend to ram is impossible in the presense
> of userspace filesystems, iff people are too lazy to fix the suspend
> framework and the drivers to work without the freezer.

Well, I don't think it has anything to do with laziness or things like that.
Rather, people have limited time and this requires some knowledge about
drivers you're modifying, so not many people really can do that.

Also, you've already assumed that there's no other solution, but I'm not
convinced about that yet.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
