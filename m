From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Bug 10030] Suspend doesn't work when SD card is
	inserted
Date: Sun, 24 Feb 2008 15:45:21 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802241535130.11316-100000__5773.21889945797$1203886040$gmane$org@netrider.rowland.org>
References: <200802242125.44032.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802242125.44032.rjw@sisk.pl>
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
> Remove pm_sleep_lock()/pm_sleep_unlock() from device add to avoid
> the issue reported at http://bugzilla.kernel.org/show_bug.cgi?id=9874.

Do you actually know whether removing that lock fixes the reported bug?

I agree, the lock should be removed for now.  But I'd sure like to get 
some feedback about what's going wrong.  It's starting to look as 
though we'd be a lot better off blocking device registration during 
sleep instead of failing it.

Shouldn't resume_device() and suspend_device() now acquire the device 
semaphore before calling the various methods?  That's the way they 
used to work.

Alan Stern
