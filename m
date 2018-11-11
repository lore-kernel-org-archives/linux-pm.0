From: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [driver-core PATCH v6 2/9] async: Add support for queueing on
 specific NUMA node
Date: Sun, 11 Nov 2018 15:27:32 -0800
Message-ID: <77b6544a-2a32-b8a4-3f3f-575193f04302@linux.intel.com>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170041079.12967.13132220574997822111.stgit@ahduyck-desk1.jf.intel.com>
 <20181111193208.GB8332@kroah.com>
 <CAPcyv4hofCTYMNN=Ow=o4RRuUPM=GLWajNAT9q6WWkuV47te_w@mail.gmail.com>
 <20181111203541.GB16871@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20181111203541.GB16871-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, bvanassche-HInyCGIudOg@public.gmane.org, Linux-pm mailing list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-nvdimm <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 11/11/2018 12:35 PM, Greg KH wrote:
> On Sun, Nov 11, 2018 at 11:53:20AM -0800, Dan Williams wrote:
>> On Sun, Nov 11, 2018 at 11:32 AM Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
>>>
>>> On Thu, Nov 08, 2018 at 10:06:50AM -0800, Alexander Duyck wrote:
>>>> Introduce four new variants of the async_schedule_ functions that allow
>>>> scheduling on a specific NUMA node.
>>>>
>>>> The first two functions are async_schedule_near and
>>>> async_schedule_near_domain end up mapping to async_schedule and
>>>> async_schedule_domain, but provide NUMA node specific functionality. They
>>>> replace the original functions which were moved to inline function
>>>> definitions that call the new functions while passing NUMA_NO_NODE.
>>>>
>>>> The second two functions are async_schedule_dev and
>>>> async_schedule_dev_domain which provide NUMA specific functionality when
>>>> passing a device as the data member and that device has a NUMA node other
>>>> than NUMA_NO_NODE.
>>>>
>>>> The main motivation behind this is to address the need to be able to
>>>> schedule device specific init work on specific NUMA nodes in order to
>>>> improve performance of memory initialization.
>>>>
>>>> Signed-off-by: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>>> ---
>>>
>>> No one else from Intel has reviewed/verified this code at all?
>>>
>>> Please take advantages of the resources you have that most people do
>>> not, get reviewes from your coworkers please before you send this out
>>> again, as they can give you valuable help before the community has to
>>> review the code...
>>
>> I tend to be suspicious of code that arrives on the mailing list
>> day-one with a series of company-internal reviewed-by tags. Sometimes
>> there is preliminary work that can be done internally, but I think we
>> should prefer to do review in the open as much as possible where it
>> does not waste community time. Alex and I did reach a general internal
>> consensus to send this out and get community feedback, but I assumed
>> to do the bulk of the review in parallel with everyone else. That said
>> I think it's fine to ask for some other acks before you take a look,
>> but let's do that in the open.
> 
> Doing it in the open is great, see my response to Pavel for the history
> of why I am normally suspicious of this, and why I wrote the above.
> 
> Also this patchset has had a long history of me asking for things, and
> not seeing the changes happen (hint, where are the benchmark numbers I
> asked for a long time ago?)  Touching the driver core like this is
> tricky, and without others helping in review and test, it makes me
> suspicious that it is not happening.
> 
> This would be a great time for some other people to do that review :)
> 
> thanks,
> 
> greg k-h

Is there any specific benchmark test you were wanting me to run? As far 
as crude numbers this patch set started out specifically focused on 
patch 9/9, but I thought it best to apply it more generically as I found 
we could still run into the issue if we enabled async_probe.

What I have seen on several systems is a pretty significant improvement 
in initialization time for persistent memory. In the case of 3TB of 
memory being initialized on a single node the improvement in the worst 
case was from about 36s down to 26s for total initialization time.

I plan to resubmit this set after plumber's since there were a few typos 
and bits of comment left over in a patch description that needed to be 
sorted out. I will try to make certain to have any benchmark data I have 
included with the set the next time I put it out.

Thanks.

- Alex
