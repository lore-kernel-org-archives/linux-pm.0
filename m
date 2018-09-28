From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC workqueue/driver-core PATCH 5/5] nvdimm: Schedule device
 registration on node local to the device
Date: Fri, 28 Sep 2018 10:46:20 -0700
Message-ID: <CAPcyv4gK59QVke3a3Lt4Ds_yYTLiDFjte8DcPqaH1pZ4otFrAg@mail.gmail.com>
References: <20180926214433.13512.30289.stgit@localhost.localdomain> <20180926215201.13512.55945.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926215201.13512.55945.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.h.duyck@linux.intel.com
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, Greg KH <gregkh@linuxfoundation.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Brown, Len" <len.brown@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Vishal L Verma <vishal.l.verma@intel.com>, jiangshanlai@gmail.com, Pavel Machek <pavel@ucw.cz>, zwisler@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 26, 2018 at 2:52 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> This patch is meant to force the device registration for nvdimm devices to
> be closer to the actual device. This is achieved by using either the NUMA
> node ID of the region, or of the parent. By doing this we can have
> everything above the region based on the region, and everything below the
> region based on the nvdimm bus.
>
> By guaranteeing NUMA locality I see an improvement of as high as 25% for
> per-node init of a system with 12TB of persistent memory.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Looks good to me. This does have a dependency on the current contents
of libnvdimm development tree.
