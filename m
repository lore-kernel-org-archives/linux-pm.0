From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Tue, 30 Dec 2008 13:10:32 +0000
Message-ID: <495A1DC8.1050609__576.444835360412$1230642790$gmane$org@tuffmail.co.uk>
References: <4959FD3F.1060306@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4959FD3F.1060306@tuffmail.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-wireless@vger.kernel.org, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Alan Jenkins wrote:
> [lsusb: ID 0bda:8187 Realtek Semiconductor Corp]
>
>
> I'd like to use this wireless adaptor I have, but the driver doesn't
> play nice with suspend.  It hangs after switching to the console,
> without printing anything.  This happens even if I haven't used the
> adaptor (i.e. ifconfig shows 0 bytes rx/tx).  Interestingly the numlock
> key on my USB keyboard still works.
>
> I tried "no_console_suspend nmi_watchdog=1", but it didn't show any more
> output.  (I waited 3 minutes for the watchdog to trigger).
>
> However, I can insert panic() calls, and see whether I hit the hang
> first, or go into a panic with flashing keyboard LEDs.  I used this to
> confirm that the hang happens inside the rtl8187_disconnect() function.
>
> There's a good chance I can track this down myself, using panic()
> again.  Before I start, does anyone have an idea what might be happening?
>   
Ok, I think I got it.

The hang is in ieee80211_unregister_hw(), on this line:

destroy_workqueue(local->hw.workqueue);


local->hw.workqueue is created using create_freezeable_workqueue().  So
presumably destroy_workqueue() deadlocks because the workqueue has
already been frozen.

Is it possible to fix this without suspend support in mac80211?  If not,
I vote we change rtl8187 (and zd_usb) to prevent suspend.  I.e. set USB
suspend callbacks which return an error.

Thanks
Alan
