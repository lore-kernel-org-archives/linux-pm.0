From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3] xen: Use PM/Hibernate events for
	save/restore/chkpt
Date: Wed, 23 Feb 2011 19:38:47 +0100
Message-ID: <20110223183847.GA1555__21793.5486849912$1298486528$gmane$org@ucw.cz>
References: <1298157158-5421-1-git-send-email-rshriram@cs.ubc.ca>
	<20110220074931.GA28485@elf.ucw.cz>
	<1298282702.16356.7578.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1298282702.16356.7578.camel@zakaz.uk.xensource.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ian Campbell <Ian.Campbell@eu.citrix.com>
Cc: Shriram Rajagopalan <rshriram@cs.ubc.ca>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > The following set of patches modify this implementation to use Hibernate style
> > > control flow (freeze/restore for save/restore and freeze/thaw for checkpoint,
> > > which is merely a cancelled save akin to failed swsusp() ).
> > > 
> > > These patches are against Ian Campbell's PVHVM tree at
> > > git://xenbits.xen.org/people/ianc/linux-2.6.git for-stefano/pvhvm
> > > 
> > > at commit 8a8d1bc753c4e2dda5f2890292d60c67d6ebb573
> > > kernel version: 2.6.38-rc4
> > 
> > Series looks ok to me...
> 
> Thanks Pavel, may we take that as an Acked-by?

ok.

> For my part the Xen side is:
> Acked-by: Ian Campbell <ian.campbell@citrix.com>
> 
> The changes to drivers/xen/manage.c depend on some other cleanups made
> on the Xen side (in linux-next soon if not already via Stefano's tree)
> so how would you like to handle them? I could point you to a suitable to
> apply the pm.h bits to or we could carry them in the Xen tree if you are
> happy with them.

Rafael maintains pm tree these days... Rafael?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
