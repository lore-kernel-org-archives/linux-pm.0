From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
	[RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Fri, 12 Jun 2009 21:56:14 +0200
Message-ID: <200906122156.14873.rjw__4065.72834258458$1244839579$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906121547490.2862-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906121547490.2862-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday 12 June 2009, Alan Stern wrote:
> On Fri, 12 Jun 2009, Rafael J. Wysocki wrote:
> 
> > So, are you suggesting that the core should only check the "all children
> > suspended" condition if special flag is set in dev_pm_info?
> 
> Or rather, check it only if the special flag _isn't_ set.

Where the default is unset, I guess?

But then, what about the resuming of the parents before the device is resumed?
Should the parents be resumed regardless of the flag state?  And if so, what's
the condition for breaking the recurrence?  Surely it's not sufficient to check
if the parent is active, because its parent need not be active if it has this
special flag set.

Best,
Rafael
