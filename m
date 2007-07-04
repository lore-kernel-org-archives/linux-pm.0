From: Paul Mackerras <paulus@samba.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 18:02:59 +1000
Message-ID: <18059.21555.317415.928416@cargo.ozlabs.ibm.com>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031307.41366.oliver@neukum.org>
	<1183463053.10386.112.camel@localhost.localdomain>
	<200707031355.51028.oliver@neukum.org>
	<18058.56956.595143.15424@cargo.ozlabs.ibm.com>
	<E1I5ysv-0005xf-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I5ysv-0005xf-00@dorka.pomaz.szeredi.hu>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org
List-Id: linux-pm@vger.kernel.org

Miklos Szeredi writes:

> That's weird, I never had a suspend problem due to a fuse mount,
> though I have them all the time.  And I suspect, that even the sync()

Well, I don't either, because we don't freeze processes on
powerbooks.  But I have heard that other people have problems with
suspending with a fuse filesystem mounted.  Maybe the difference is
whether or not the filesystem is writable?

> thing that suspend does is not the real cause, because sync() actually
> does nothing in fuse filesystems.

It's not the filesystem sync method, as I understand it, it's that if
there are dirty pages in the page cache for files on the fuse
filesystem, the system will initiate a write-out on them and wait for
it to finish.  But if the fuse userspace is frozen, the write-out will
never complete.

Paul.
