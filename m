From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 05 Jul 2007 16:14:51 +0200
Message-ID: <E1I6S6d-0000tl-00__13627.2111245946$1183645039$gmane$org@dorka.pomaz.szeredi.hu>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707051531.37532.rjw@sisk.pl>
	<E1I6RjE-0000pP-00@dorka.pomaz.szeredi.hu>
	<200707051614.19300.rjw@sisk.pl>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707051614.19300.rjw@sisk.pl>
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


> > I guess I know your answer.  But it ain't gonna work.  Suspend code
> > really doesn't belong in VFS, and I'm pretty sure the maintainers of
> > that little piece of code would agree with me on this.
> 
> Surprise, surprise.  Not that I'm scared of the VFS maintainers, though. ;-)

Probably you haven't had a close encounter with them yet.  They are
pretty much the _most_ dangerous people in kernel land ;)

Miklos
