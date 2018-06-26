From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v5 1/8] interconnect: Add generic on-chip interconnect API
Date: Tue, 26 Jun 2018 14:58:16 -0700
Message-ID: <20180626215816.GQ129942@google.com>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-2-georgi.djakov@linaro.org>
 <CAE=gft4sSdFL7J27WdTuYCtfLPAyv8xOAizYhmtfK5UkTbP5-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE=gft4sSdFL7J27WdTuYCtfLPAyv8xOAizYhmtfK5UkTbP5-A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: georgi.djakov@linaro.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 26, 2018 at 01:57:21PM -0700, Evan Green wrote:
> Hi Georgi. Thanks for the new spin of this.
> 
> On Wed, Jun 20, 2018 at 5:11 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
> >
> > This patch introduce a new API to get requirements and configure the
> > interconnect buses across the entire chipset to fit with the current
> > demand.
> >
> > The API is using a consumer/provider-based model, where the providers are
> > the interconnect buses and the consumers could be various drivers.
> > The consumers request interconnect resources (path) between endpoints and
> > set the desired constraints on this data flow path. The providers receive
> > requests from consumers and aggregate these requests for all master-slave
> > pairs on that path. Then the providers configure each participating in the
> > topology node according to the requested data flow path, physical links and
> > constraints. The topology could be complicated and multi-tiered and is SoC
> > specific.
> >
> > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> > ---
> >  Documentation/interconnect/interconnect.rst |  96 ++++
> >  drivers/Kconfig                             |   2 +
> >  drivers/Makefile                            |   1 +
> >  drivers/interconnect/Kconfig                |  10 +
> >  drivers/interconnect/Makefile               |   2 +
> >  drivers/interconnect/core.c                 | 586 ++++++++++++++++++++
> >  include/linux/interconnect-provider.h       | 127 +++++
> >  include/linux/interconnect.h                |  42 ++
> >  8 files changed, 866 insertions(+)
> >  create mode 100644 Documentation/interconnect/interconnect.rst
> >  create mode 100644 drivers/interconnect/Kconfig
> >  create mode 100644 drivers/interconnect/Makefile
> >  create mode 100644 drivers/interconnect/core.c
> >  create mode 100644 include/linux/interconnect-provider.h
> >  create mode 100644 include/linux/interconnect.h
> >
> > ...
> >
> > diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> > new file mode 100644
> > index 000000000000..e7f96fc6722e
> > --- /dev/null
> > +++ b/drivers/interconnect/core.c
> > @@ -0,0 +1,586 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Interconnect framework core driver
> > + *
> > + * Copyright (c) 2018, Linaro Ltd.
> > + * Author: Georgi Djakov <georgi.djakov@linaro.org>
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/idr.h>
> > +#include <linux/init.h>
> > +#include <linux/interconnect.h>
> > +#include <linux/interconnect-provider.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/slab.h>
> > +
> > +static DEFINE_IDR(icc_idr);
> > +static LIST_HEAD(icc_provider_list);
> > +static DEFINE_MUTEX(icc_lock);
> > +
> > +/**
> > + * struct icc_req - constraints that are attached to each node
> > + *
> > + * @req_node: entry in list of requests for the particular @node
> > + * @node: the interconnect node to which this constraint applies
> > + * @dev: reference to the device that sets the constraints
> > + * @avg_bw: an integer describing the average bandwidth in kbps
> > + * @peak_bw: an integer describing the peak bandwidth in kbps
> > + */
> > +struct icc_req {
> > +       struct hlist_node req_node;
> > +       struct icc_node *node;
> > +       struct device *dev;
> > +       u32 avg_bw;
> > +       u32 peak_bw;
> > +};
> > +
> > +/**
> > + * struct icc_path - interconnect path structure
> > + * @num_nodes: number of hops (nodes)
> > + * @reqs: array of the requests applicable to this path of nodes
> > + */
> > +struct icc_path {
> > +       size_t num_nodes;
> > +       struct icc_req reqs[0];
> > +};
> > +
> > +static struct icc_node *node_find(const int id)
> > +{
> > +       struct icc_node *node;
> > +
> > +       mutex_lock(&icc_lock);
> > +       node = idr_find(&icc_idr, id);
> > +       mutex_unlock(&icc_lock);
> 
> I wonder if this is too low of a level to be dealing with the lock. I
> notice that everywhere you use this function, you afterwards
> immediately grab the lock and do more stuff. Maybe this function
> should have a comment saying it assumes the lock is already held, and
> then you can grab the lock in the callers, since you're doing that
> anyway.

I think the canonical way to document the expectation would be:

WARN_ON(!mutex_is_locked(&icc_lock));

> > +
> > +       return node;
> > +}
> > +
> > +static struct icc_path *path_allocate(struct icc_node *dst, ssize_t num_nodes)
> > +{
> > +       struct icc_node *node = dst;
> > +       struct icc_path *path;
> > +       size_t i;
> > +
> > +       path = kzalloc(sizeof(*path) + num_nodes * sizeof(*path->reqs),
> > +                      GFP_KERNEL);
> > +       if (!path)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       path->num_nodes = num_nodes;
> > +
> > +       for (i = 0; i < num_nodes; i++) {
> > +               hlist_add_head(&path->reqs[i].req_node, &node->req_list);
> > +
> > +               path->reqs[i].node = node;
> > +               /* reference to previous node was saved during path traversal */
> > +               node = node->reverse;
> > +       }
> > +
> > +       return path;
> > +}
> > +
> > +static struct icc_path *path_find(struct device *dev, struct icc_node *src,
> > +                                 struct icc_node *dst)
> > +{
> 
> I personally prefer a comment somewhere indicating that this function
> assumes icc_lock is already held. Not sure if that's conventional or
> not.

Same as above.
