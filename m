From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [driver-core PATCH v4 0/6] Add NUMA aware async_schedule calls
Date: Mon, 15 Oct 2018 08:09:01 -0700
Message-ID: <20181015150305.29520.86363.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org, tj@kernel.org, akpm@linux-foundation.org, alexander.h.duyck@linux.intel.com
List-Id: linux-pm@vger.kernel.org

This patch set provides functionality that will help to improve the
locality of the async_schedule calls used to provide deferred
initialization.

This patch set originally started out with me focused on just the one call
to async_schedule_domain in the nvdimm tree that was being used to
defer the device_add call however after doing some digging I realized the
scope of this was much broader than I had originally planned. As such I
went through and reworked the underlying infrastructure down to replacing
the queue_work call itself with a function of my own and opted to try and
provide a NUMA aware solution that would work for a broader audience.

RFC->v1:
    Dropped nvdimm patch to submit later
        It relies on code in libnvdimm development tree
    Simplified queue_work_near to just convert node into a CPU
    Split up drivers core and PM core patches
v1->v2:
    Renamed queue_work_near to queue_work_node
    Added WARN_ON_ONCE if we use queue_work_node with per-cpu workqueue
v2->v3:
    Added Acked-by for queue_work_node patch
    Continued rename from _near to _node to be consistent with queue_work_node
        Renamed async_schedule_near_domain to async_schedule_node_domain
        Renamed async_schedule_near to async_schedule_node
    Added kerneldoc for new async_schedule_XXX functions
    Updated patch description for patch 4 to include data on potential gains
v3->v4
    Added patch to consolidate use of need_parent_lock
    Make asynchronous driver probing explicit about use of drvdata
    Added Acked-by for PM core patch

---

Alexander Duyck (6):
      workqueue: Provide queue_work_node to queue work near a given NUMA node
      async: Add support for queueing on specific NUMA node
      device core: Consolidate locking and unlocking of parent and device
      driver core: Probe devices asynchronously instead of the driver
      driver core: Attach devices on CPU local to device node
      PM core: Use new async_schedule_dev command


 drivers/base/base.h       |    2 +
 drivers/base/bus.c        |   46 ++--------------
 drivers/base/dd.c         |  130 ++++++++++++++++++++++++++++++++++++++++-----
 drivers/base/power/main.c |   12 ++--
 include/linux/async.h     |   84 ++++++++++++++++++++++++++++-
 include/linux/device.h    |    4 +
 include/linux/workqueue.h |    2 +
 kernel/async.c            |   53 ++++++++++--------
 kernel/workqueue.c        |   84 +++++++++++++++++++++++++++++
 9 files changed, 329 insertions(+), 88 deletions(-)

--
