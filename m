From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 05 Jul 2007 13:54:19 +0200
Message-ID: <E1I6Pud-0000V1-00@dorka.pomaz.szeredi.hu>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707051202.59375.oliver@neukum.org>
	<E1I6OLf-0000JP-00@dorka.pomaz.szeredi.hu>
	<200707051340.41901.rjw@sisk.pl>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707051340.41901.rjw@sisk.pl>
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

> > Limiting what a userspace filesystem can do would defeat the whole
> > purpose of the bloody thing.  This is not negotiable ;)
> 
> Which doesn't change the fact that FUSE _is_ special, because it adds
> dependencies between processed that were not present before.

OK, fuse is special.  So is the userspace driver framework (UIO)
proposed by Greg KH and co.  Now what can be done about these?

 - making them not-special is not an option due to the established
   interfaces, which don't allow restartability.

 - fixing the freezer is pretty much impossible because the
   dependencies between the tasks cannot be known.

 - removing the freezer and fixing the drivers seems workable, we
   already have a prototype in the form of the powermac architecture.

It seems pretty clear cut.  Whining about how much problems this will
cause won't get us nearer to a solution.

Miklos
