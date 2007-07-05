From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: removing refrigerator does not help with s2ram vs. fuse deadlocks
	(was Re: Re: [PATCH] Remove process freezer from
	suspend to RAM pathway)
Date: Thu, 5 Jul 2007 14:57:58 +0100
Message-ID: <20070705135758.GB22177__1857.75307841158$1183644251$gmane$org@srcf.ucam.org>
References: <18059.6726.218205.104212@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44L0.0707041104140.25704-100000@netrider.rowland.org>
	<18060.15591.556676.28935@cargo.ozlabs.ibm.com>
	<20070705091526.GA3084@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070705091526.GA3084@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 05, 2007 at 11:15:26AM +0200, Pavel Machek wrote:

> Now, if kernel needs FUSE services for some reason (that's the problem
> we hit in s2ram case, right?), we have a deadlock.
> 
> So main problem still seems to be "kernel should not depend on
> userland services during suspend", refrigerator or not.

And also "Userland should not depend on userland services", which is 
rather more of a problem.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
