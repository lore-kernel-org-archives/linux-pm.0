From: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [driver-core PATCH v5 1/9] workqueue: Provide queue_work_node
 to queue work near a given NUMA node
Date: Tue, 06 Nov 2018 08:27:19 -0800
Message-ID: <c7f9e6b6b3d7e2217f93bb23b16589dd5dc0b092.camel@linux.intel.com>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
 <154145230445.29224.14651284855380723028.stgit@ahduyck-desk1.jf.intel.com>
 <1541464948.196084.168.camel@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <1541464948.196084.168.camel-HInyCGIudOg@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2018-11-05 at 16:42 -0800, Bart Van Assche wrote:
> On Mon, 2018-11-05 at 13:11 -0800, Alexander Duyck wrote:
> > +/**
> > + * workqueue_select_cpu_near - Select a CPU based on NUMA node
> > + * @node: NUMA node ID that we want to bind a CPU from
> 
>                                           ^^^^
>                                           select?
> > +	/* If CPU is valid return that, otherwise just defer */
> > +	return (cpu < nr_cpu_ids) ? cpu : WORK_CPU_UNBOUND;
> 
> Please leave out the superfluous parentheses if this patch series would have to
> be reposted.
> 
> Anyway:
> 
> Reviewed-by: Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org>

I will incorporate you suggestions and add your Reviewed-by for the
next submission.

Thanks.

- Alex
