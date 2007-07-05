From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 02:02:35 +0200
Message-ID: <20070705000235.GD2719__38129.7340071343$1183593815$gmane$org@elf.ucw.cz>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707030944.18702.oliver@neukum.org>
	<E1I5fug-0003ZS-00@dorka.pomaz.szeredi.hu>
	<200707031307.41366.oliver@neukum.org>
	<E1I5gSu-0003f4-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <E1I5gSu-0003f4-00@dorka.pomaz.szeredi.hu>
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

Hi!

> > > I don't claim to know anything about how STR or hibernate works, but
> > > neither seem to have any problem with I/O on the fuse device "racing"
> > > with them.
> > 
> > The problem is not with fuse. The problem is generic in nature.
> > 
> > If you remove the freezer, user space remains active until the last CPU
> > goes into suspend. It can do syscalls. Or do you know a clean way to exempt
> > only the tasks fuse might use?
> 
> You are talking about hibernate, right?  Suspending (to ram) is
> instantaneous, in that _after_ suspend no CPU is active obviously.

No, suspend to ram is not instantaneous.

We may have 16 cpus, and we may have 250 disks that need to be spun
down. That takes time, and is really not atomic operation.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
