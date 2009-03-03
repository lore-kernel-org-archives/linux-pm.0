From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC][Patch 0/3] Fix device_move() vs. dpm_list issues.
Date: Tue, 3 Mar 2009 11:20:58 +0100
Message-ID: <20090303112058.1f57d161@gondolin>
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
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, "Rafael J.
	Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Marcel Holtmann <marcel@>
List-Id: linux-pm@vger.kernel.org

Hi,

in thread [1], we discussed the issue of device_move() causing a
reordering of devices without adapting the ancestral order in dpm_list.
If a device is moved to a new parent that was registered after the
device itself, it would still be after its new parent in dpm_list, thus
causing the parent to be suspended before its child.

This patchset attempts to remedy this situation by introducing an
interface for a driver to manipulate dpm_list with the dpm_list_mtx
held. (device_move() does not have enough information to do this
manipulation itself.) The calling sequence for a driver would be:

- lock the dpm_list
- call device_move()
- if device_move() succeeded, fix up dpm_list
- unlock the dpm_list

Following are three patches:

Patch 1 - Introduce the dpm_list manipulation interfaces. I'm not sure
whether the BUG_ON()s should be WARN_ON()s instead.

Patch 2 - Make bluetooth use the new interfaces. I didn't introduce
proper handling for device_move() failures. Very lightly tested (did
not break my setup :)), needs proper review.

Patch 3 - Make s390 use the new interfaces. I'm more confident this
patch is correct, but it is hard to test power management related stuff
without power management support (no regressions were introduced for my
attach/detach testcases though).


[1] https://lists.linux-foundation.org/pipermail/linux-pm/2007-July/014428.html
