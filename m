From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 6 Jul 2007 09:51:47 +0200
Message-ID: <200707060951.47555.oliver@neukum.org>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707060940.23248.rjw@sisk.pl>
	<E1I6iPL-0003Hj-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6iPL-0003Hj-00@dorka.pomaz.szeredi.hu>
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
Cc: mjg59@srcf.ucam.org, nigel@suspend2.net, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Freitag, 6. Juli 2007 schrieb Miklos Szeredi:
> > > You're missing the point. I'm arguing that a sync from within the freezer 
> > > should guarantee that there is no data loss.
> > 
> > Well, it should, but it doesn't ...
> > 
> > Moreover, if FUSE implements syncing, then the sync from within the freezer
> > will almost certainly deadlock.
> 
> Rafael, think positively: by the time fuse implements sync(), the
> freezer will be long gone ;)

Now you are entering really dangerous territory.
If you can implement a meaningfull sync method, you must have dirty
pages in the page cache. That means you are in the page freeing path
of the vm. Then we are in real trouble. Don't even think about it.

As far as suspend/hibernate is concerned, get yourself on the new
notifying chain and revert to synchronous operations when notified.

	Regards
		Oliver
