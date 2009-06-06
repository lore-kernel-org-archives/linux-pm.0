From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/2] PM: Rearrange core suspend code
Date: Sun, 7 Jun 2009 00:54:18 +0200
Message-ID: <200906070054.19207.rjw__13645.5938955352$1244329330$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Here's something I wanted to do quite some time ago.

kernel/power/main.c becomes more and more difficult to maintain over time,
since it contains both the suspend to RAM core code and some common PM code
that is also used for hibernation.  For this reason [1/2] separates the suspend
to RAM code from main.c and puts it into two new files (the test facility is,
again, separated from the core code for clarity).

[2/2] renames kernel/power/disk.c to kernel/power/hibernate.c, because the role
of this file is analogous to kernel/power/suspend.c (introduced by [1/2]).

Comments welcome.

Best,
Rafael
