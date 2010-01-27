From: Mike Chan <mike@android.com>
Subject: Re: PM-QOS hot path discussion.
Date: Tue, 26 Jan 2010 18:00:22 -0800
Message-ID: <8bb80c381001261800x48f33759h966a6231e7854d0e@mail.gmail.com>
References: <20091223172718.GB16543@mgross-laptop>
	<001501ca9eae$23c101b0$6b430510$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <001501ca9eae$23c101b0$6b430510$@org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ai Li <aili@codeaurora.org>
Cc: linux-pm@lists.linux-foundation.org, 640E9920 <640e9920@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 26, 2010 at 9:36 AM, Ai Li <aili@codeaurora.org> wrote:
>> Now what seems to be asked for is that something akin to the
>> android WAKE_LOCK_IDLE "thing".
>>
>> Last night I gave some thought to this. =A0One could put a boolean
>> or bit mask flag into the aggregated value that when polled the
>> poller could know to not go to any lower performing state or
>> kick the system into higher performance states. =A0Setting the
>> flag would only happen from kernel API's and no notification
>> trees would be called as it gets toggled. =A0(that would kill fast
>> path performance)
>
> Android WAKE_LOCK_IDLE is a very coarse setting. =A0It does not take
> advantage of the multiple performance states with their corresponding
> latency values. =A0WAKE_LOCK_IDLE potentially disallows some low
> performance states when their latencies may be quite acceptable. =A0In
> contrast, an integer setting would allow a better match between the
> requested latency value and the appropriate low power states. =A0pm_qos
> already provides the integer setting. =A0IMO, the question is how to
> enable hot-path flow through pm_qos...
>
There are a few lower power states on msm that we don't differentiate
between when taking an idle lock.

We don't use idle locks on omap. The resource framework in the omap
tree is sufficient with the latency requirement calls in
resource34xx.c/h

I might be wrong here but it sounds like you're trying to solve a
similar problem but working it into the pm-qos framework? Or am I
confused on what the subject of this thread is?

-- Mike

>
>> But as I thought about it it became clear the correct behavior
>> is really a function of the parameter class. =A0If the parameter
>> is cpu_dma_latency then the flag would be used to simply disable
>> CPUIDLE from doing any high latency idle states. =A0However; such
>> a flag for network bandwidth (a flag hit in some fast code path)
>> shouldn't be telling the NIC to kick up from 100Mbs to 1000Mbs
>> or go back.
>>
>> So what would a fast path pm-qos parameter look like and how
>> would it be used, outside of CPUIDLE?
>>
>
> Stating it in another way: the correct hot path behavior for each
> parameter class is dependent on what the parameter class is. =A0To
> accommodate this, we could add a hot_path_fn in struct pm_qos_object.
> It specifies the hot path behavior for the parameter class. =A0In the
> hot path flow, update_target() will call
> pm_qos_array[pm_qos_class]->hot_path_fn() instead of the notifier
> chain.
>
> With regards to NIC cards, I'm not sure what hot_path_fn() would
> perform. =A0Maybe the default hot_path_fn for PM_QOS_NETWORK_THROUGHPUT
> does nothing; the platform code or NIC card code can register a
> different hot_path_fn.
>
> ~Ai
>
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>
