From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [RFC PATCH v4 01/13] ktask: add documentation
Date: Wed, 7 Nov 2018 12:21:45 -0800
Message-ID: <20181107202145.xvaq3pmqbzyekfan@ca-dmjordan1.us.oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-2-daniel.m.jordan@oracle.com>
 <20181106084911.GA22504@hirez.programming.kicks-ass.net>
 <20181106203411.pdce6tgs7dncwflh@ca-dmjordan1.us.oracle.com>
 <20181106205146.GB30490@mellanox.com>
 <20181107102752.GK9781@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181107102752.GK9781@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jason Gunthorpe <jgg@mellanox.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "aarcange@redhat.com" <aarcange@redhat.com>, "aaron.lu@intel.com" <aaron.lu@intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "bsd@redhat.com" <bsd@redhat.com>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "jwadams@google.com" <jwadams@google.com>, "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 07, 2018 at 11:27:52AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 06, 2018 at 08:51:54PM +0000, Jason Gunthorpe wrote:
> > On Tue, Nov 06, 2018 at 12:34:11PM -0800, Daniel Jordan wrote:
> > 
> > > > What isn't clear is if this calling thread is waiting or not. Only do
> > > > this inheritance trick if it is actually waiting on the work. If it is
> > > > not, nobody cares.
> > > 
> > > The calling thread waits.  Even if it didn't though, the inheritance trick
> > > would still be desirable for timely completion of the job.
> > 
> > Can you make lockdep aware that this is synchronous?
> > 
> > ie if I do
> > 
> >   mutex_lock()
> >   ktask_run()
> >   mutex_lock()
> > 
> > Can lockdep know that all the workers are running under that lock?
> > 
> > I'm thinking particularly about rtnl_lock as a possible case, but
> > there could also make some sense to hold the read side of the mm_sem
> > or similar like the above.
> 
> Yes, the normal trick is adding a fake lock to ktask_run and holding
> that over the actual job. See lock_map* in flush_workqueue() vs
> process_one_work().

I'll add that for the next version.
