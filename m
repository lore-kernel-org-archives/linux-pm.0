From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [RFC PATCH v4 01/13] ktask: add documentation
Date: Tue, 6 Nov 2018 20:51:54 +0000
Message-ID: <20181106205146.GB30490@mellanox.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-2-daniel.m.jordan@oracle.com>
 <20181106084911.GA22504@hirez.programming.kicks-ass.net>
 <20181106203411.pdce6tgs7dncwflh@ca-dmjordan1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181106203411.pdce6tgs7dncwflh@ca-dmjordan1.us.oracle.com>
Content-Language: en-US
Content-ID: <5D06AA0EB35F9848AAEE468B33AEEB0F@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "aarcange@redhat.com" <aarcange@redhat.com>, "aaron.lu@intel.com" <aaron.lu@intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "bsd@redhat.com" <bsd@redhat.com>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "jwadams@google.com" <jwadams@google.com>, "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>, "mhocko@kernel.org" <mhocko@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 06, 2018 at 12:34:11PM -0800, Daniel Jordan wrote:

> > What isn't clear is if this calling thread is waiting or not. Only do
> > this inheritance trick if it is actually waiting on the work. If it is
> > not, nobody cares.
>=20
> The calling thread waits.  Even if it didn't though, the inheritance tric=
k
> would still be desirable for timely completion of the job.

Can you make lockdep aware that this is synchronous?

ie if I do

  mutex_lock()
  ktask_run()
  mutex_lock()

Can lockdep know that all the workers are running under that lock?

I'm thinking particularly about rtnl_lock as a possible case, but
there could also make some sense to hold the read side of the mm_sem
or similar like the above.

Jason
