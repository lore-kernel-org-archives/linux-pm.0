From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Regression,
	2.6.36-rc1] ath9k resume problem on Acer Ferrari One
Date: Thu, 19 Aug 2010 00:01:11 +0200
Message-ID: <201008190001.11342.rjw__30048.3329258443$1282169248$gmane$org@sisk.pl>
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
To: Luis Rodriguez <lrodriguez@atheros.com>, Tejun Heo <tj@kernel.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ath9k-devel@venema.h4ckr.net, linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi,

While testing 2.6.36-rc1 (with a couple of fixes on top) I noticed that the ath9k
driver didn't work after resume from suspend to RAM.  An attempt to unload the
driver using rmmod caused the BUG_ON() in kernel/workqueue.c:2844 to trigger.

I wonder if that regression is a result of the recent workqueue changes?

Thanks,
Rafael
