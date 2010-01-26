From: "Ai Li" <aili@codeaurora.org>
Subject: Re: PM-QOS hot path discussion.
Date: Tue, 26 Jan 2010 10:36:48 -0700
Message-ID: <001501ca9eae$23c101b0$6b430510$@org>
References: <20091223172718.GB16543@mgross-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091223172718.GB16543@mgross-laptop>
Content-Language: en-us
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: '640E9920' <640e9920@gmail.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> Now what seems to be asked for is that something akin to the
> android WAKE_LOCK_IDLE "thing".
> 
> Last night I gave some thought to this.  One could put a boolean
> or bit mask flag into the aggregated value that when polled the
> poller could know to not go to any lower performing state or
> kick the system into higher performance states.  Setting the
> flag would only happen from kernel API's and no notification
> trees would be called as it gets toggled.  (that would kill fast
> path performance)

Android WAKE_LOCK_IDLE is a very coarse setting.  It does not take
advantage of the multiple performance states with their corresponding
latency values.  WAKE_LOCK_IDLE potentially disallows some low
performance states when their latencies may be quite acceptable.  In
contrast, an integer setting would allow a better match between the
requested latency value and the appropriate low power states.  pm_qos
already provides the integer setting.  IMO, the question is how to
enable hot-path flow through pm_qos...


> But as I thought about it it became clear the correct behavior
> is really a function of the parameter class.  If the parameter
> is cpu_dma_latency then the flag would be used to simply disable
> CPUIDLE from doing any high latency idle states.  However; such
> a flag for network bandwidth (a flag hit in some fast code path)
> shouldn't be telling the NIC to kick up from 100Mbs to 1000Mbs
> or go back.
> 
> So what would a fast path pm-qos parameter look like and how
> would it be used, outside of CPUIDLE?
> 

Stating it in another way: the correct hot path behavior for each
parameter class is dependent on what the parameter class is.  To
accommodate this, we could add a hot_path_fn in struct pm_qos_object.
It specifies the hot path behavior for the parameter class.  In the
hot path flow, update_target() will call
pm_qos_array[pm_qos_class]->hot_path_fn() instead of the notifier
chain.

With regards to NIC cards, I'm not sure what hot_path_fn() would
perform.  Maybe the default hot_path_fn for PM_QOS_NETWORK_THROUGHPUT
does nothing; the platform code or NIC card code can register a
different hot_path_fn.

~Ai
