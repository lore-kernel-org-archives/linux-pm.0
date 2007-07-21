From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: Hibernation considerations
Date: Sat, 21 Jul 2007 21:20:03 +0200
Message-ID: <200707212120.04645.rjw__49423.0043063455$1185045190$gmane$org@sisk.pl>
References: <Pine.LNX.4.64.0707171319140.2467@asgard.lang.hm>
	<87lkd9ohtn.fsf@jbms.ath.cx>
	<E1ICJRG-0000OG-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1ICJRG-0000OG-00@dorka.pomaz.szeredi.hu>
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
Cc: david@lang.hm, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, jbms@cmu.edu
List-Id: linux-pm@vger.kernel.org

On Saturday, 21 July 2007 20:12, Miklos Szeredi wrote:
> > It seems that you could still potentially get a failure to freeze if one
> > FUSE process depends on another, and the one that is frozen second just
> > happens to be waiting on the one that is frozen first when it is frozen.
> > I admit that this situation is unlikely, and perhaps acceptable.
> 
> It isn't all that unlikely.  There's sshfs for example, that depends
> on a separate ssh process for transport.
> 
> Oh, there are also userspace network transports, like tun/tap,
> nfqueue, etc.  They could block any network filesystem (not just fuse)
> if frozen first, making the freezer fail.
> 
> Hmm, wonder why this isn't affecting people with VPNs?  Probably
> network mounts over VPN are rare, and ever rarer to have fs activity
> on them during suspend.
> 
> Anyway, I think it's long overdue to stop thinking about how to "fix"
> fuse, and concentrate on fixing the underlying problem instead ;)

To conclude this branch of the thread, I have a patch in the works that may
help a bit with unfreezable FUSE filesystems and it only affects the freezer.
I'll post it when 2.6.23-rc1 is out, because it's on top of some other patches
that need to go first.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
