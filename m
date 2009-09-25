From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Regression] 2.6.31-git: tty change broke resume from
	hibernation on MSI Wind U100
Date: Sat, 26 Sep 2009 00:38:21 +0200
Message-ID: <200909260038.22079.rjw__7612.19743076271$1253918283$gmane$org@sisk.pl>
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
To: Alan Cox <alan@linux.intel.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Alan,

As stated at http://bugzilla.kernel.org/show_bug.cgi?id=14229, your commit
b50989dc444599c8b21edc23536fc305f4e9b7d5
(tty: make the kref destructor occur asynchronously) appears to have broken
resume from hibernation on MSI Wind U100.

I verified that hibernation works correctly with this commit reverted.

I'm still not sure what the root cause of the problem is, though.

Thanks,
Rafael
