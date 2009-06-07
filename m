From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 0/2] PM: Rearrange core suspend code
Date: Sun, 7 Jun 2009 16:51:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906071651060.25203-100000__12822.9836620905$1244407967$gmane$org@netrider.rowland.org>
References: <200906070054.19207.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906070054.19207.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 7 Jun 2009, Rafael J. Wysocki wrote:

> Hi,
> 
> Here's something I wanted to do quite some time ago.
> 
> kernel/power/main.c becomes more and more difficult to maintain over time,
> since it contains both the suspend to RAM core code and some common PM code
> that is also used for hibernation.  For this reason [1/2] separates the suspend
> to RAM code from main.c and puts it into two new files (the test facility is,
> again, separated from the core code for clarity).
> 
> [2/2] renames kernel/power/disk.c to kernel/power/hibernate.c, because the role
> of this file is analogous to kernel/power/suspend.c (introduced by [1/2]).
> 
> Comments welcome.

Looks like a good idea to me.

Alan Stern
