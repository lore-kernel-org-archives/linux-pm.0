From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: 3.0-rc6-git6: Reported regressions from 2.6.39
Date: Sun, 10 Jul 2011 12:54:37 +0200
Message-ID: <1310295277.3942.1.camel__12143.68946753$1310295433$gmane$org@jlt3.sipsolutions.net>
References: <Y7LyOsOBwFM.A.kJG.kBYGOB@chimera>
	(sfid-20110710_124712_285053_7BCF3183)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Y7LyOsOBwFM.A.kJG.kBYGOB@chimera>
	(sfid-20110710_124712_285053_7BCF3183)
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
Cc: Linux SCSI List <linux-scsi@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Florian Mickler <florian@mickler.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sun, 2011-07-10 at 12:19 +0200, Rafael J. Wysocki wrote:

> Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=38702
> Subject		: 3.0.0-rc4-git6 - INFO: possible circular locking dependency detected - (&rdev->mtx){+.+.+.}, at: [<ffffffffa00e27e0>] cfg80211_netdev_notifier_call+0x275/0x4ff [cfg80211]
> Submitter	: Miles Lane <miles.lane@gmail.com>
> Date		: 2011-06-26 21:54 (15 days old)
> Message-ID	: <BANLkTikztsFnPkJZ7VxRC-zsitwCCvVmeg@mail.gmail.com>
> References	: http://marc.info/?l=linux-kernel&m=130912559804336&w=2

Should be fixed by c10841ca722a0bc960dc541c51582773f9a24f98 which was
part of John's latest pull request and is in net-2.6 now on its way up.

johannes
