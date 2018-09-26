From: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC workqueue/driver-core PATCH 0/5] Add NUMA aware async_schedule
 calls
Date: Wed, 26 Sep 2018 14:51:32 -0700
Message-ID: <20180926214433.13512.30289.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
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

I am submitting this an RFC to figure out just how far off I am from where
I need to be on this patch set and to determine which tree I should
ultimately be submitting this to.

---

Alexander Duyck (5):
      workqueue: Provide queue_work_near to queue work near a given NUMA node
      async: Add support for queueing on specific NUMA node
      driver core: Probe devices asynchronously instead of the driver
      driver core: Use new async_schedule_dev command
      nvdimm: Schedule device registration on node local to the device


 drivers/base/bus.c        |   23 +-------
 drivers/base/dd.c         |   44 +++++++++++++++
 drivers/base/power/main.c |   12 ++--
 drivers/nvdimm/bus.c      |   11 +++-
 include/linux/async.h     |   27 ++++++++-
 include/linux/workqueue.h |    2 +
 kernel/async.c            |   62 ++++++++++++++++------
 kernel/workqueue.c        |  129 ++++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 258 insertions(+), 52 deletions(-)

--
