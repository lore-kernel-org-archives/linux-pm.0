From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: Hibernation considerations
Date: Mon, 23 Jul 2007 14:08:30 +0200
Message-ID: <200707231408.32051.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0707221116060.15224-100000@netrider.rowland.org>
	<200707230842.22121.nigel@nigel.suspend2.net>
	<E1ICv5g-0003oN-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1ICv5g-0003oN-00@dorka.pomaz.szeredi.hu>
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
Cc: david@lang.hm, nigel@suspend2.net, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, jbms@cmu.edu
List-Id: linux-pm@vger.kernel.org

On Monday, 23 July 2007 12:24, Miklos Szeredi wrote:
> > > The only thing to do is what Rafael has been working on: unfreeze
> > > things, hope the tasks sort themselves out, and try again.
> > 
> > That's what I'm questioning. Is there a more reliable way and we've
> > just given up too quickly?
> 
> There obviously _are_ more reliable ways.  A trivial one seems to be
> to just not require user tasks to finish syscalls.
> 
> Yeah, stopping user processes outside the kernel is convenient, but
> there's no fundamental reason why it is the only place where those
> tasks can be stopped.

The reason is that we want them to "park" in safe places, ie. where there
are no locks held etc.  Thus, these safe places need to be chosen somehow
and since they are not marked throughout the code, we choose the obvious
one. :-)

> And there are very fundamental reasons to _not_ require this.  Not
> just in the fuse case, but in any case where a syscall requires
> another user task to run before it can be finished (e.g. NFS over
> OpenVPN).

Yeah.  Mark the safe places for us and we'll use them.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
