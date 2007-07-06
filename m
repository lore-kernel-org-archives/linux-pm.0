From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 06 Jul 2007 11:09:43 +0200
Message-ID: <E1I6jot-0003U1-00@dorka.pomaz.szeredi.hu>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707060940.23248.rjw@sisk.pl>
	<E1I6iPL-0003Hj-00@dorka.pomaz.szeredi.hu>
	<200707060951.47555.oliver@neukum.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707060951.47555.oliver@neukum.org> (message from Oliver
	Neukum on Fri, 6 Jul 2007 09:51:47 +0200)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: oliver@neukum.org
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, nigel@suspend2.net, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > > Moreover, if FUSE implements syncing, then the sync from within the freezer
> > > will almost certainly deadlock.
> > 
> > Rafael, think positively: by the time fuse implements sync(), the
> > freezer will be long gone ;)
> 
> Now you are entering really dangerous territory.
> If you can implement a meaningfull sync method, you must have dirty
> pages in the page cache. That means you are in the page freeing path
> of the vm. Then we are in real trouble. Don't even think about it.

VM induced deadlocks are real nasty.  I have thought about them a lot
already.  Suspend shouldn't introduce any big surprises.

Miklos
