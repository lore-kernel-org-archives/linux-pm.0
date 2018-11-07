From: Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org>
Subject: Re: [driver-core PATCH v5 2/9] async: Add support for queueing on
 specific NUMA node
Date: Tue, 06 Nov 2018 16:50:29 -0800
Message-ID: <1541551829.196084.206.camel@acm.org>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
 <154145230954.29224.13087735653265580553.stgit@ahduyck-desk1.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <154145230954.29224.13087735653265580553.stgit-+uVpp3jiz/RcxmDmkzA3yGt3HXsI98Cx0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2018-11-05 at 13:11 -0800, Alexander Duyck wrote:
> +/**
> + * async_schedule_domain - schedule a function for asynchronous execution within a certain domain
> + * @func: function to execute asynchronously
> + * @data: data pointer to pass to the function
> + * @domain: the domain
> + *
> + * Returns an async_cookie_t that may be used for checkpointing later.
> + * @domain may be used in the async_synchronize_*_domain() functions to
> + * wait within a certain synchronization domain rather than globally.  A
> + * synchronization domain is specified via @domain.
> + * Note: This function may be called from atomic or non-atomic contexts.
> + */

Please leave out "A synchronization domain is specified via @domain." since
that text is redundant due to "@domain: the domain".

> +/**
> + * async_schedule_dev_domain - A device specific version of async_schedule_domain
> + * @func: function to execute asynchronously
> + * @dev: device argument to be passed to function
> + * @domain: the domain
> + *
> + * Returns an async_cookie_t that may be used for checkpointing later.
> + * @dev is used as both the argument for the function and to provide NUMA
> + * context for where to run the function. By doing this we can try to
> + * provide for the best possible outcome by operating on the device on the
> + * CPUs closest to the device.
> + * @domain may be used in the async_synchronize_*_domain() functions to
> + * wait within a certain synchronization domain rather than globally.  A
> + * synchronization domain is specified via @domain.
> + * Note: This function may be called from atomic or non-atomic contexts.
> + */

Same comment here: I think "A synchronization domain is specified via @domain."
is redundant.

> +/**
> + * async_schedule_node_domain - NUMA specific version of async_schedule_domain
> + * @func: function to execute asynchronously
> + * @data: data pointer to pass to the function
> + * @node: NUMA node that we want to schedule this on or close to
> + * @domain: the domain
> + *
> + * Returns an async_cookie_t that may be used for checkpointing later.
> + * @domain may be used in the async_synchronize_*_domain() functions to
> + * wait within a certain synchronization domain rather than globally.  A
> + * synchronization domain is specified via @domain.  Note: This function
> + * may be called from atomic or non-atomic contexts.
> + *
> + * The node requested will be honored on a best effort basis. If the node
> + * has no CPUs associated with it then the work is distributed among all
> + * available CPUs.
> + */

Same comment here: I think that also in the above "A synchronization domain is
specified via @domain." is redundant.

Otherwise this patch looks fine to me.

Bart.
