From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: malicious filesystems (was Re: Re: [PATCH] Remove
	process freezer from suspend to RAM pathway)
Date: Mon, 09 Jul 2007 11:28:39 +0200
Message-ID: <E1I7pXr-0001Qn-00@dorka.pomaz.szeredi.hu>
References: <200707050858.03638.oliver@neukum.org>
	<200707082008.57879.rjw@sisk.pl>
	<E1I7clo-0000JY-00@dorka.pomaz.szeredi.hu>
	<200707082307.15616.rjw@sisk.pl>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707082307.15616.rjw@sisk.pl>
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
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> Please have a look at the documentation update at the bottom of this patch:
> 
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc7/patches/15-freezer-make-kernel-threads-nonfreezable-by-default.patch
> 
> It says what the freezer is for in the first place. :-)

Thanks, good description.

> > Yes, we need to make sure, that nothing is scheduled during (and
> > possibly after) taking the snapshot.  But AFAICS that could be
> > achieved by unplugging all but one CPU.
> 
> Actually, we want things to get scheduled, because we need some of them to
> save the image (to make things more difficult, we don't know what will be
> needed to save the image in advance ;-)).

Well, kexecing a new kernel (as being pursued in one of the
subthreads) to do the saving should take care of that.

In that case the "we need suspend to be invisible to userspace" as a
reason to use the freezer would also be moot, since if you don't
schedule userspace after offlining the CPUs, it can't notice this.

Miklos
