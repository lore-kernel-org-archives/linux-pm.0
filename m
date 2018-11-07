From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [driver-core PATCH v5 5/9] driver core: Establish clear order
 of operations for deferred probe and remove
Date: Tue, 06 Nov 2018 17:34:31 -0800
Message-ID: <499e4358e72fca510fa6fcfb76ea3ac3792db08f.camel@perches.com>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
 <154145232484.29224.1635232599636954462.stgit@ahduyck-desk1.jf.intel.com>
 <1541548114.196084.195.camel@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <1541548114.196084.195.camel-HInyCGIudOg@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org>, Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2018-11-06 at 15:48 -0800, Bart Van Assche wrote:
> On Mon, 2018-11-05 at 13:12 -0800, Alexander Duyck wrote:
> > One change I made in addition is I replaced the use of "bool X:1" to define
> > the bitfield to a "u8 X:1" setup in order to resolve some checkpatch
> > warnings.
> 
> Please use "bool X:1" instead of "u8 X:1". I think it was a bad idea to make
> checkpatch complain about "bool X:1" since "bool X:1" should only be avoided
> in structures for which alignment must be architecture-independent. For struct
> device it is fine if member alignment differs per architecture. Additionally,
> changing "bool X:1" into "u8 X:1" will reduce performance on architectures that
> cannot do byte addressing.

I generally agree.  But the checkpatch warning _could_
be useful in those cases where alignment should be
architecture-independent.

Any suggestion on how to improve the message?
s
