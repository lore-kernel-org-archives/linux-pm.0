From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [GIT PULL] One more power management fix for 2.6.37
Date: Mon, 15 Nov 2010 10:20:21 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1011151018380.1606-100000__12211.4742327996$1289834564$gmane$org@iolanthe.rowland.org>
References: <201011102151.22552.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011102151.22552.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 10 Nov 2010, Rafael J. Wysocki wrote:

> What about applying the patch below now and moving to the multiple list heads
> approach in the next cycle?
> 
> Rafael
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM: Allow devices to be removed during late suspend and early resume
> 
> Holding dpm_list_mtx across late suspend and early resume of devices
> is problematic for the PCMCIA subsystem and doesn't allow device
> objects to be removed by late suspend and early resume driver
> callbacks.  This appears to be overly restrictive, as drivers are
> generally allowed to remove device objects in other phases of suspend
> and resume.  Therefore rework dpm_{suspend|resume}_noirq() so that
> they don't have to hold dpm_list_mtx all the time.

This looks okay to me.  Just like the other routines.

Alan Stern
