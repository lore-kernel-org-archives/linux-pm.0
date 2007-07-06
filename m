From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 06 Jul 2007 11:33:44 +0200
Message-ID: <E1I6kC8-0003af-00@dorka.pomaz.szeredi.hu>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707060951.47555.oliver@neukum.org>
	<E1I6jot-0003U1-00@dorka.pomaz.szeredi.hu>
	<200707061916.17590.nigel@nigel.suspend2.net>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707061916.17590.nigel@nigel.suspend2.net> (message from Nigel
	Cunningham on Fri, 6 Jul 2007 19:16:16 +1000)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: nigel@nigel.suspend2.net
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, nigel@suspend2.net, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > VM induced deadlocks are real nasty.  I have thought about them a lot
> > already.  Suspend shouldn't introduce any big surprises.
> 
> Suspend isn't introducing the surprises. Fuse is. It creates the potential 
> deadlocks simply by existing (this isn't suspend or hibernate specific).

Yes.  And fuse is not going away any time soon.  Get over it ;)

Miklos
