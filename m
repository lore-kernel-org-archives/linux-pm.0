From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [workqueue/driver-core PATCH v2 0/5] Add NUMA aware async_schedule
 calls
Date: Wed, 10 Oct 2018 16:07:10 -0700
Message-ID: <20181010230435.10609.77825.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org, alexander.h.duyck@linux.intel.com
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
    Dropped nvdimm patch to submit later.
		It relies on code in libnvdimm development tree.
    Simplified queue_work_near to just convert node into a CPU.
	Split up drivers core and PM core patches.
v1->v2:
    Renamed queue_work_near to queue_work_node
    Added WARN_ON_ONCE if we use queue_work_node with per-cpu workqueue

---

Alexander Duyck (5):
      workqueue: Provide queue_work_node to queue work near a given NUMA node
      async: Add support for queueing on specific NUMA node
      driver core: Probe devices asynchronously instead of the driver
      driver core: Attach devices on CPU local to device node
      PM core: Use new async_schedule_dev command


 drivers/base/bus.c        |   23 ++----------
 drivers/base/dd.c         |   44 +++++++++++++++++++++++-
 drivers/base/power/main.c |   12 +++---
 include/linux/async.h     |   36 ++++++++++++++++++-
 include/linux/workqueue.h |    2 +
 kernel/async.c            |   47 ++++++++++++-------------
 kernel/workqueue.c        |   84 +++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 193 insertions(+), 55 deletions(-)

--
