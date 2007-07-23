From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: Hibernation considerations
Date: Mon, 23 Jul 2007 12:24:36 +0200
Message-ID: <E1ICv5g-0003oN-00@dorka.pomaz.szeredi.hu>
References: <Pine.LNX.4.44L0.0707221116060.15224-100000@netrider.rowland.org>
	<200707230842.22121.nigel@nigel.suspend2.net>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707230842.22121.nigel@nigel.suspend2.net> (message from Nigel
	Cunningham on Mon, 23 Jul 2007 08:42:17 +1000)
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
Cc: david@lang.hm, miklos@szeredi.hu, nigel@suspend2.net, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, jbms@cmu.edu
List-Id: linux-pm@vger.kernel.org

> > The only thing to do is what Rafael has been working on: unfreeze
> > things, hope the tasks sort themselves out, and try again.
> 
> That's what I'm questioning. Is there a more reliable way and we've
> just given up too quickly?

There obviously _are_ more reliable ways.  A trivial one seems to be
to just not require user tasks to finish syscalls.

Yeah, stopping user processes outside the kernel is convenient, but
there's no fundamental reason why it is the only place where those
tasks can be stopped.

And there are very fundamental reasons to _not_ require this.  Not
just in the fuse case, but in any case where a syscall requires
another user task to run before it can be finished (e.g. NFS over
OpenVPN).

Miklos
