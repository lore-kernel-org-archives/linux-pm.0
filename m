From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] PM: acquire device locks prior to suspending
Date: Wed, 12 Dec 2007 23:42:01 -0800
Message-ID: <20071212234201.a8932915.akpm@linux-foundation.org>
References: <Pine.LNX.4.44L0.0709211536570.5816-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0709211536570.5816-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 21 Sep 2007 15:37:40 -0400 (EDT) Alan Stern <stern@rowland.harvard.edu> wrote:

> This patch (as994) reorganizes the way suspend and resume
> notifications are sent to drivers.  The major changes are that now the
> PM core acquires every device semaphore before calling the methods,
> and calls to device_add() during suspends will fail.

Causes my t61p to deadlock during suspend-to-RAM.  Really late - the little
moon symbol has started to flash but the LCD is still powered and the
cursor still blinks.  Only a poweroff restores control.
