From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC][PATCH -mm] PM: Do not sync filesystems from
	within the freezer
Date: Fri, 06 Jul 2007 11:05:53 +0200
Message-ID: <E1I6jlB-0003TC-00__16809.3734923334$1183712905$gmane$org@dorka.pomaz.szeredi.hu>
References: <200707041658.59588.rjw@sisk.pl>
	<20070705220046.GC3881@elf.ucw.cz> <200707060902.55090.rjw@sisk.pl>
	<200707061707.23316.nigel@nigel.suspend2.net>
	<E1I6i0N-0003CY-00@dorka.pomaz.szeredi.hu>
	<1183712394.3388.128.camel@localhost.localdomain>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1183712394.3388.128.camel@localhost.localdomain> (message from
	Benjamin Herrenschmidt on Fri, 06 Jul 2007 18:59:54 +1000)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: benh@kernel.crashing.org
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, nigel@suspend2.net, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

> On Fri, 2007-07-06 at 09:13 +0200, Miklos Szeredi wrote:
> > 
> > Another myth, that has been debunked already.  The problem is: how do
> > you define fuse processes?  There's no theoretical or even practial
> > way to do that.
> 
> It could if they told the kernel via some black magic ...
> 
> But that still suck. The freezer sucks :-)

Yeah, and it wouldn't work in practice, since the auxilary tasks might
be part of a library which is not even aware of being used by a "fuse
task".

Miklos
