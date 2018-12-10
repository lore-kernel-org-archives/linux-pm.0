From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [driver-core PATCH v8 2/9] driver core: Establish order of
 operations for device_add and device_del via bitflag
Date: Mon, 10 Dec 2018 13:23:48 -0800
Message-ID: <CAPcyv4hrML3SKnFP9UANC-hdTrpnOx4nWX=b-yhLsLuujL5oAA@mail.gmail.com>
References: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
 <154403072403.11544.10419282512791659652.stgit@ahduyck-desk1.jf.intel.com>
 <CAPcyv4jH_Op-xHTd2FwQizPaWFx_2FE-pVsOLLmZAEK8EVPrYg@mail.gmail.com>
 <15b6817fd945a1622afe673b46b028bacefad72b.camel@linux.intel.com>
 <CAPcyv4i1RTrKYX0YpyCRE=pqt3pHBRiCGQq1wYUriLjKKTVA7A@mail.gmail.com>
 <bd92d0a3ff60097bf4424ff4c556a5369e66da6d.camel@linux.intel.com> <CAPcyv4jDG_2VwFr4oDGCURFrA=B0Bs2HGN9exLE47vDj0P3_8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4jDG_2VwFr4oDGCURFrA=B0Bs2HGN9exLE47vDj0P3_8A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.h.duyck@linux.intel.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>, "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>, bvanassche@acm.org
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 10, 2018 at 1:15 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Dec 10, 2018 at 12:58 PM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
[..]
> > Also the context for the two functions seems to be a bit different. In
> > the case of __device_attach_driver the device_lock is already held. In
> > __driver_attach the lock on the device isn't taken until after a match
> > has been found.
>
> Yes, I was only pattern matching when looking at the context of where
> dev->dead is checked in __driver_attach() and wondering why it was
> checked outside of __device_attach_driver()

...and now I realize the bigger point of your concern, we need to
check dev->dead after acquiring the device_lock otherwise the race is
back. We can defer that consolidation, but the larger concern of
making it internal to __device_attach_driver() still stands.
