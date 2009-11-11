From: Yavor Trifonov <ytrifonov@mm-sol.com>
Subject: Not going out of suspend after "enable_off_mode"
Date: Wed, 11 Nov 2009 16:33:04 +0200
Message-ID: <1257949984.6811.903.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,
I'm having trouble going out of suspend with 2.6.32-rc5 from the
linux-omap-pm branch. The board is Beagleboard and u-boot is: U-Boot
2009.11-rc1-00019-g0f36527.

root@beagleboard:~# echo 1 > /debug/pm_debug/enable_off_mode 
root@beagleboard:~# echo mem > /sys/power/state 
[   58.611358] PM: Syncing filesystems ... done.
[   58.635559] Freezing user space processes ... (elapsed 0.00 seconds)
done.
[   58.643280] Freezing remaining freezable tasks ... (elapsed 0.00
seconds) done.
[   58.651245] Suspending console(s) (use no_console_suspend to debug)

After that the board can not be waken up using the rs or "user" button.
Suspending without "enable_off_mode" is resuming ok. Any suggestions
what to look for? 

Thanks
