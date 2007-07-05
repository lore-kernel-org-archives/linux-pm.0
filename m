From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: removing refrigerator does not help with s2ram vs. fuse deadlocks
	(was Re: Re: [PATCH] Remove process freezer from
	suspend to RAM pathway)
Date: Thu, 5 Jul 2007 15:26:00 +0100
Message-ID: <20070705142600.GB22598__26141.2573200234$1183645956$gmane$org@srcf.ucam.org>
References: <18059.6726.218205.104212@cargo.ozlabs.ibm.com>
	<20070705091526.GA3084@elf.ucw.cz>
	<20070705135758.GB22177@srcf.ucam.org>
	<200707051628.12199.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707051628.12199.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 05, 2007 at 04:28:11PM +0200, Rafael J. Wysocki wrote:
> On Thursday, 5 July 2007 15:57, Matthew Garrett wrote:
> > And also "Userland should not depend on userland services", which is 
> > rather more of a problem.
> 
> I think you're oversimplifying it, as far as FUSE is concerned.
> 
> Namely, if there are two userland tasks, A and B, and B is uninterruptible,
> because A is blocked, then this is not a usual situation.

Fuse is one case of it occuring, and if we end up with more userspace 
drivers then the problem is only going to get worse.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
