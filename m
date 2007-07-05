From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 05 Jul 2007 22:46:09 +0200
Message-ID: <E1I6YDJ-0001sj-00@dorka.pomaz.szeredi.hu>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707052138.56920.oliver@neukum.org>
	<E1I6XFM-0001ek-00@dorka.pomaz.szeredi.hu>
	<200707052234.30021.oliver@neukum.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707052234.30021.oliver@neukum.org> (message from Oliver
	Neukum on Thu, 5 Jul 2007 22:34:29 +0200)
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
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > Yes, fuse could handle being frozen there.  However that would only
> > solve part of the problem: an operation waiting for a reply could be
> > holding a VFS mutex and some other task may be blocked on that mutex.
> > 
> > How would you solve freezing those tasks?
> 
> OK, you made me reach for literatur on theoretical computer science.
> 
> IMHO the range of actions a fuse server is inherently limited.
> You must never ever block on a lock one of your clients is holding. In
> this case the limitation is not influenced by the freezer.

Obviously.  But I wasn't about the server trying to acquire a lock
held by a client.  I was talking about a client trying to acquire a
lock held by _another_ client.

If this coincides with the server (or some other task which the server
is depending on) being frozen before the clients, the freezer has a
problem.

> The freezer introduces a further limitation in that the server can freeze
> before the client, which must not be. You can prevent that by freezing
> the servers last.
> 
> In principle you might have dependencies between servers and you won't
> catch that, true. You won't catch servers blocking on IPC, but you are
> balancing on the edge of deadlock with fuse anyway.

Huh?

Miklos
