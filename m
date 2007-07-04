From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 12:26:33 +0200
Message-ID: <200707041226.34799.rjw__32827.8221343227$1183544384$gmane$org@sisk.pl>
References: <20070703042916.GA17240@srcf.ucam.org>
	<18059.21555.317415.928416@cargo.ozlabs.ibm.com>
	<E1I60CR-00066n-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I60CR-00066n-00@dorka.pomaz.szeredi.hu>
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

On Wednesday, 4 July 2007 10:26, Miklos Szeredi wrote:
> > > That's weird, I never had a suspend problem due to a fuse mount,
> > > though I have them all the time.  And I suspect, that even the sync()
> > 
> > Well, I don't either, because we don't freeze processes on
> > powerbooks.  But I have heard that other people have problems with
> > suspending with a fuse filesystem mounted.  Maybe the difference is
> > whether or not the filesystem is writable?
> > 
> > > thing that suspend does is not the real cause, because sync() actually
> > > does nothing in fuse filesystems.
> > 
> > It's not the filesystem sync method, as I understand it, it's that if
> > there are dirty pages in the page cache for files on the fuse
> > filesystem,
> 
> Currently fuse doesn't produce dirty pages.  Normal writes are done
> synchronously, and writable mmap is not supported.  So sync() should
> really be a no-op for fuse.
> 
> > the system will initiate a write-out on them and wait for it to
> > finish.  But if the fuse userspace is frozen, the write-out will
> > never complete.
> 
> Maybe there is some other fs operation being done, possibly not
> directly, but by waiting for a kernel thread, that does that.

We're going to limit the freezing of kernel threads to the ones that explicitly
want to be frozen, so if that's the case, then I think it'll be fixed soon.

> It would be nice, if someone who can reproduce the deadlock could
> debug it.

Agreed.

> Does sysrq still work during suspend? 

Yes, it should work.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
