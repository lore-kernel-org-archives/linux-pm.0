From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: Re: Hibernation considerations
Date: Sat, 21 Jul 2007 12:13:56 -0400
Message-ID: <87lkd9ohtn.fsf__41277.3498370827$1185034489$gmane$org@jbms.ath.cx>
References: <Pine.LNX.4.64.0707171319140.2467@asgard.lang.hm>
	<200707202302.07116.rjw@sisk.pl>
	<E1ICDNw-0008HC-00@dorka.pomaz.szeredi.hu>
	<200707212243.35602.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707212243.35602.nigel@nigel.suspend2.net> (Nigel Cunningham's
	message of "Sat\, 21 Jul 2007 22\:43\:33 +1000")
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
Cc: david@lang.hm, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

It seems that you could still potentially get a failure to freeze if one
FUSE process depends on another, and the one that is frozen second just
happens to be waiting on the one that is frozen first when it is frozen.
I admit that this situation is unlikely, and perhaps acceptable.

A larger concern is that it seems that freezing FUSE processes at all
_will_ generate deadlocks if a non-synchronous or memory-map-supporting
filesystem is loopback mounted from a FUSE filesystem.  In that case, if
you attempt to sync or free memory once FUSE is frozen, you are sure to
get a deadlock.

-- 
Jeremy Maitin-Shepard
