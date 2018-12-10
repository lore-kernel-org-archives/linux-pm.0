From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [driver-core PATCH v8 0/9] Add NUMA aware async_schedule calls
Date: Mon, 10 Dec 2018 11:22:16 -0800
Message-ID: <20181210192216.GJ28501@garbanzo.do-not-panic.com>
References: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, linux-nvdimm@lists.01.org, tj@kernel.org, akpm@linux-foundation.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com, dave.jiang@intel.com, bvanassche@acm.org
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 05, 2018 at 09:25:13AM -0800, Alexander Duyck wrote:
> This patch set provides functionality that will help to improve the
> locality of the async_schedule calls used to provide deferred
> initialization.
> 
> This patch set originally started out focused on just the one call to
> async_schedule_domain in the nvdimm tree that was being used to defer the
> device_add call however after doing some digging I realized the scope of
> this was much broader than I had originally planned. As such I went
> through and reworked the underlying infrastructure down to replacing the
> queue_work call itself with a function of my own and opted to try and
> provide a NUMA aware solution that would work for a broader audience.
> 
> In addition I have added several tweaks and/or clean-ups to the front of the
> patch set. Patches 1 through 4 address a number of issues that actually were
> causing the existing async_schedule calls to not show the performance that
> they could due to either not scaling on a per device basis, or due to issues
> that could result in a potential deadlock. For example, patch 4 addresses the
> fact that we were calling async_schedule once per driver instead of once
> per device, and as a result we would have still ended up with devices
> being probed on a non-local node without addressing this first.

No tests were added. Again, I think it would be good to add test
cases to showcase the old mechanisms, illustrate the new, and ensure
we don't regress both now and also help us ensure we don't regress
moving forward.

This is all too critical of a path for the kernel, and these changes
are rather instrusive. I'd readlly like to see test code for it now
rather than later.

  Luis
