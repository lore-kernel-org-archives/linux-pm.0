From: Marcus Better <marcus@better.se>
Subject: 2.6.21 suspend-to-disk regression
Date: Sun, 29 Apr 2007 16:22:30 +0200
Message-ID: <f129n6$mro$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
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

Hi,

suspend-to-disk isn't working well anymore on my Thinkpad R60 with Intel
Core 2 Duo and kernel 2.6.21 (x86_64). It's a Debian system with uswsusp
0.6~cvs20070202-1, and I'm using s2disk. I believe it was quite stable
around 2.6.20. 

It does succeed sometimes, but often it fails at suspend. Several times it
hung at "snapshotting system" with the sleep LED blinking. Once it just
rebooted at that point. Sometimes it suspends correctly but the image is
not recognized at boot.

I don't know if this is similar to any of the previously listed regressions,
it's a bit daunting to wade through all the suspend-related threads...

Marcus
