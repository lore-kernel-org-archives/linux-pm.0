From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC][PATCH -mm] PM: Do not sync filesystems from
	within the freezer
Date: Fri, 06 Jul 2007 09:13:27 +0200
Message-ID: <E1I6i0N-0003CY-00@dorka.pomaz.szeredi.hu>
References: <200707041658.59588.rjw@sisk.pl> <20070705220046.GC3881@elf.ucw.cz>
	<200707060902.55090.rjw@sisk.pl>
	<200707061707.23316.nigel@nigel.suspend2.net>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707061707.23316.nigel@nigel.suspend2.net> (message from Nigel
	Cunningham on Fri, 6 Jul 2007 17:07:20 +1000)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, nigel@suspend2.net, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

> To get more serious and practical though, I think the solution is to
> fuzz the userspace/kernelspace distinction. What we really want to
> do is freeze things that submit I/O, then sync, then freeze anything
> that processes I/O and needs to be frozen. In effect, redefine fuse
> processes as freezeable kernel threads.

Another myth, that has been debunked already.  The problem is: how do
you define fuse processes?  There's no theoretical or even practial
way to do that.

Miklos
