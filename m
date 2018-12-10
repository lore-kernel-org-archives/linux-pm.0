From: Luis Chamberlain <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [driver-core PATCH v8 0/9] Add NUMA aware async_schedule calls
Date: Mon, 10 Dec 2018 15:35:07 -0800
Message-ID: <20181210233507.GK28501@garbanzo.do-not-panic.com>
References: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
 <20181210192216.GJ28501@garbanzo.do-not-panic.com>
 <dd0b44d5dd9d19ac6735f80ae66bb437ec55b2cf.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <dd0b44d5dd9d19ac6735f80ae66bb437ec55b2cf.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bvanassche-HInyCGIudOg@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 10, 2018 at 03:25:04PM -0800, Alexander Duyck wrote:
> On Mon, 2018-12-10 at 11:22 -0800, Luis Chamberlain wrote:
> > On Wed, Dec 05, 2018 at 09:25:13AM -0800, Alexander Duyck wrote:
> > > This patch set provides functionality that will help to improve the
> > > locality of the async_schedule calls used to provide deferred
> > > initialization.
> > > 
> > > This patch set originally started out focused on just the one call to
> > > async_schedule_domain in the nvdimm tree that was being used to defer the
> > > device_add call however after doing some digging I realized the scope of
> > > this was much broader than I had originally planned. As such I went
> > > through and reworked the underlying infrastructure down to replacing the
> > > queue_work call itself with a function of my own and opted to try and
> > > provide a NUMA aware solution that would work for a broader audience.
> > > 
> > > In addition I have added several tweaks and/or clean-ups to the front of the
> > > patch set. Patches 1 through 4 address a number of issues that actually were
> > > causing the existing async_schedule calls to not show the performance that
> > > they could due to either not scaling on a per device basis, or due to issues
> > > that could result in a potential deadlock. For example, patch 4 addresses the
> > > fact that we were calling async_schedule once per driver instead of once
> > > per device, and as a result we would have still ended up with devices
> > > being probed on a non-local node without addressing this first.
> > 
> > No tests were added. Again, I think it would be good to add test
> > cases to showcase the old mechanisms, illustrate the new, and ensure
> > we don't regress both now and also help us ensure we don't regress
> > moving forward.
> > 
> > This is all too critical of a path for the kernel, and these changes
> > are rather instrusive. I'd readlly like to see test code for it now
> > rather than later.
> > 
> >   Luis
> 
> Sorry about that. I was more focused on the rewrite of patch 2 and
> overlooked the comment about lib/test_kmod.c.
> 
> I'll look into it and see if I can squeeze it in for v9.

Superb!

  Luis
