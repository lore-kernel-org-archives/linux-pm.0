From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: Hibernation considerations
Date: Mon, 23 Jul 2007 16:01:05 +0200
Message-ID: <E1ICyTB-00056Q-00@dorka.pomaz.szeredi.hu>
References: <Pine.LNX.4.44L0.0707221116060.15224-100000@netrider.rowland.org>
	<200707231431.30372.oliver@neukum.org>
	<E1ICxdo-0004w2-00@dorka.pomaz.szeredi.hu>
	<200707231601.09541.rjw@sisk.pl>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707231601.09541.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: david@lang.hm, miklos@szeredi.hu, nigel@suspend2.net, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, jbms@cmu.edu
List-Id: linux-pm@vger.kernel.org

> Alan has recently proposed to introduce "suspend locks" to be acquired during
> a suspend/hibernation and such that we can leave uninterruptible tasks that
> don't hold any of them.

Sounds sane.  A global rwsem could be acquired for read by drivers,
and for write by suspend/hibernate.  Just need to add it to all
drivers that have PM, but that shouldn't need a heroic effort.

Miklos
