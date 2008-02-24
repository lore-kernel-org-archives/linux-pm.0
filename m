From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Bug 10030] Suspend doesn't work when SD card is
	inserted
Date: Sun, 24 Feb 2008 16:11:03 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802241605340.17767-100000__38107.4415207424$1203887594$gmane$org@netrider.rowland.org>
References: <200802242156.55948.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802242156.55948.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Sun, 24 Feb 2008, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Remove the code that acquires all device semaphores from the suspend
> code path as it causes multiple problems to appear (most notably,
> http://bugzilla.kernel.org/show_bug.cgi?id=10030) and revert the
> change introduced by commit 4145ed6dc597a9bea5f6ae8c574653b2de10620f
> depending on the code being removed.
> 
> Remove pm_sleep_lock()/pm_sleep_unlock() from device_add() to avoid
> the issue reported at http://bugzilla.kernel.org/show_bug.cgi?id=9874.

This looks okay.

Are you going to submit it just for 2.6.25, leaving the existing code 
as-is for 2.6.26?

Alan Stern
