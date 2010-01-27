From: "Ai Li" <aili@codeaurora.org>
Subject: Re: PM-QOS hot path discussion.
Date: Wed, 27 Jan 2010 12:08:22 -0700
Message-ID: <002401ca9f84$18cbcf70$4a636e50$@org>
References: <20091223172718.GB16543@mgross-laptop>	
	<001501ca9eae$23c101b0$6b430510$@org>
	<8bb80c381001261800x48f33759h966a6231e7854d0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8bb80c381001261800x48f33759h966a6231e7854d0e@mail.gmail.com>
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
To: 'Mike Chan' <mike@android.com>
Cc: linux-pm@lists.linux-foundation.org, '640E9920' <640e9920@gmail.com>
List-Id: linux-pm@vger.kernel.org

> There are a few lower power states on msm that we don't
> differentiate
> between when taking an idle lock.
> 
> We don't use idle locks on omap. The resource framework in the
> omap
> tree is sufficient with the latency requirement calls in
> resource34xx.c/h
> 
> I might be wrong here but it sounds like you're trying to solve
> a
> similar problem but working it into the pm-qos framework? Or am
> I
> confused on what the subject of this thread is?

pm_qos framework handles latency requirements already and can be used
on all platforms.  Our code at codeaurora.org for MSM chips uses
pm_qos for latency.  This thread discusses improving efficient
execution of pm_qos in hot-path, i.e. when pm_qos is called very
frequently.  The improvement would apply to all pm_qos parameters,
not just latency.  The latency implementations in pm_qos and in
android's WAKE_LOCK_IDLE are references as to what have been done
already.

There is a related discussion in the thread "[linux-pm] platform
specific pm_qos parameters".  That thread focuses on how to add
platform-specifc parameters to pm_qos, i.e. creating a mechanism so
that each platform (i.e. x86, OMAP, MSM) can append its own set of
pm_qos parameters and associated behavior.

~Ai
