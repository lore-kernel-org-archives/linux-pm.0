From: Willi Mann <foss-ml@wm1.at>
Subject: another software suspend issue,
	seems to be caused by i915/KMS
Date: Sun, 01 Aug 2010 11:49:51 +0200
Message-ID: <i33g00$ros$1@dough.gmane.org>
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

On my Thinkpad T500 with Debian-compiled kernel 2.6.35~rc6-1~experimental.1, 
I still get OOpses on suspend. 

The following OOPS has been found be using the platform method. I had to 
hard-reboot as SysRQ didn't work. (although I have also seen similar suspend 
OOPSes where it worked). The suspend has been initiated by echo disk > 
/sys/power/state from virtual terminal. 

http://wserver.wm1.at/~willi/linux/suspend_issue/suspend_error.jpg

However, I don't get the same OOPS every time, and the problem does not 
occur at every suspend. I haven't managed to get more than one suspend 
successfully finished (since a cold-boot). Particularly, it seems that if 
the first suspend succeeds, the problem always occurs at the second attempt. 

Also note that if I initiated the suspend from X, I often got a blank screen 
(except for a blinking cursor) instead of the OOPS. (The fact that the 
screen was blank could also be related to the fact that when tested from X, 
I hadn't raised the log levels)

When I disable the i915 module (I renamed it), I can't reproduce the 
problem.

lspci -v -s 00:02.0:
00:02.0 VGA compatible controller: Intel Corporation Mobile 4 Series Chipset 
Integrated Graphics Controller (rev 07) (prog-if 00 [VGA controller])
        Subsystem: Lenovo Device 2114
        Flags: bus master, fast devsel, latency 0, IRQ 48
        Memory at f4400000 (64-bit, non-prefetchable) [size=4M]
        Memory at d0000000 (64-bit, prefetchable) [size=256M]
        I/O ports at 1800 [size=8]
        Expansion ROM at <unassigned> [disabled]
        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Capabilities: [d0] Power Management version 3
        Kernel driver in use: i915

Please let me know what additional infos are required to resolve this 
problem. 

WM 
