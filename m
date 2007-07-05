From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 05 Jul 2007 15:50:40 +0200
Message-ID: <E1I6RjE-0000pP-00__35912.5889758163$1183643501$gmane$org@dorka.pomaz.szeredi.hu>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707051358.26963.rjw@sisk.pl>
	<E1I6QOA-0000bq-00@dorka.pomaz.szeredi.hu>
	<200707051531.37532.rjw@sisk.pl>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707051531.37532.rjw@sisk.pl>
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

> > > Don't you think, however, that it can be modified a little to play well,
> > > for example, with the freezer?
> > 
> > I could stick a couple of try_to_freeze()s into fuse, and that would
> > make suspend failure less likely.  But making problems less easy to
> > reproduce is not a good thing.
> 
> So, how about eliminating them?

That can't be done just within fuse, a process might be sleeping on a
VFS mutex.  Do we want to hack VFS as well?

I guess I know your answer.  But it ain't gonna work.  Suspend code
really doesn't belong in VFS, and I'm pretty sure the maintainers of
that little piece of code would agree with me on this.

Miklos
