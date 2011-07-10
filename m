From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/6 v2] PM / Domains: Generic PM domains
	improvements
Date: Sun, 10 Jul 2011 10:59:29 +0200
Message-ID: <201107101059.30322.rjw__14776.4602130794$1310289203$gmane$org@sisk.pl>
References: <201107062248.35586.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107062248.35586.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi,

The majority of patches have been updated since the last submission and there's
one new patch, so it's the time for a refresh. :-)

All patches in this series have been posted already (the last one without
a changelog, though).

On Wednesday, July 06, 2011, Rafael J. Wysocki wrote:
> 
> For the last few days I've been working on modifications of the generic
> PM domains code allowing .start_device()/.stop_device() and drivers'
> .runtime_suspend()/.runtime_resume() callbacks to execute things like
> pm_runtime_resume() for other devices in the same PM domain safely
> without deadlocking (the original motivation was a console driver on
> shmobile that pm_runtime_get_*()/pm_runtime_put_*() are called for from
> the other devices' .runtime_suspend()/.runtime_resume() callbacks).
> 
> I think I solved that problem, but in the process I found a few places
> where fixes and/on improvements were necessary.  The patches in this
> series address those issues.

[1/6] - Set device state to "active" during system resume.

[2/6] - Make failing pm_genpd_prepare() clean up properly.

[3/6] - Rework generic PM domains locking so that device callbacks are not
        executed under the genpd lock.

[4/6] - Allow device callbacks executed by the generic PM domains code to
        run runtime PM helpers safely (ie. without deadlocking).

[5/6] - Avoid restoring the states of all devices on failing domain power off.

[6/6] - Imorove the handling of system wakeup devices during system suspend.

The series is on top of the branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-domains
 
All patches in this series are regarded as 3.1 material.

Thanks,
Rafael
