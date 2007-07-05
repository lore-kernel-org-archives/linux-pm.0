From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: removing refrigerator does not help with s2ram vs. fuse deadlocks
	(was Re: Re: [PATCH] Remove process freezer from
	suspend to RAM pathway)
Date: Thu, 5 Jul 2007 17:27:35 +0200
Message-ID: <200707051727.36715.rjw__4724.16447378254$1183648891$gmane$org@sisk.pl>
References: <18059.6726.218205.104212@cargo.ozlabs.ibm.com>
	<200707051704.48137.rjw@sisk.pl>
	<20070705150301.GB23647@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070705150301.GB23647@srcf.ucam.org>
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
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 5 July 2007 17:03, Matthew Garrett wrote:
> On Thu, Jul 05, 2007 at 05:04:47PM +0200, Rafael J. Wysocki wrote:
> > On Thursday, 5 July 2007 16:39, Matthew Garrett wrote:
> > > Why?
> > 
> > You have processes that don't react to signals, because some other user land
> > task is misbehaving.  I'd call that ugly at the very least.
> 
> It already happens with, say, NFS. Don't think about it in terms of a 
> userland task misbehaving - think of it in terms of a resource becoming 
> unavailable.

I think there's a difference between a userland task playing the role of a
resource and a "real" external resource the kernel doesn't control.

IMO, userland tasks should not have the power to affect each other as though
they were parts of the kernel.

Greetings,
Rafael
 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
