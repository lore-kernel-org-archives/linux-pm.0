From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [driver-core PATCH v3 0/5] Add NUMA aware async_schedule calls
Date: Thu, 11 Oct 2018 15:09:16 -0700
Message-ID: <20181011220134.1408.63391.stgit@localhost.localdomain>
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

Ideally this solution should be agnostic enough that it can be used for any
given device type. So ideally we shouldn't need to implement one-off
solutions for each bus as has already kind of happened in the PCI tree with
pci_call_probe.

RFC->v1:
    Dropped nvdimm patch to submit later.
		It relies on code in libnvdimm development tree.
    Simplified queue_work_near to just convert node into a CPU.
    Split up drivers core and PM core patches.
v1->v2:
    Renamed queue_work_near to queue_work_node
    Added WARN_ON_ONCE if we use queue_work_node with per-cpu workqueue
v2->v3:
    Added Acked-by for queue_work_node patch
    Continued rename from _near to _node for consistency with queue_work_node
        Renamed async_schedule_near_domain to async_schedule_node_domain
        Renamed async_schedule_near to async_schedule_node
    Added kerneldoc for new async_schedule_XXX functions
    Added nvdimm boot time improvement data to description of patch 4
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
 include/linux/async.h     |   84 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/workqueue.h |    2 +
 kernel/async.c            |   53 ++++++++++++++++------------
 kernel/workqueue.c        |   84 +++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 248 insertions(+), 54 deletions(-)

--
