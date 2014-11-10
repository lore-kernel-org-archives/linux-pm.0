From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V3 2/6] sched: idle: cpuidle: Check the latency req
 before idle
Date: Mon, 10 Nov 2014 16:28:03 +0100
Message-ID: <20141110152803.GX10501@worktop.programming.kicks-ass.net>
References: <1415370687-18688-1-git-send-email-daniel.lezcano@linaro.org>
 <1415370687-18688-3-git-send-email-daniel.lezcano@linaro.org>
 <20141110124111.GN3337@twins.programming.kicks-ass.net>
 <5460D5EF.2000805@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5460D5EF.2000805@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, preeti@linux.vnet.ibm.com, nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, lenb@kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 10, 2014 at 04:12:47PM +0100, Daniel Lezcano wrote:
> All this is to remove the poll idle state from the x86 cpuidle driver in
> order to remove the CPUIDLE_DRIVER_STATE_START (this one forces to write
> always ugly code in the cpuidle framework).
> 
> This poll state introduces the CPUIDLE_DRIVER_STATE_START macro. If you look
> at the different governors and the code, you can checkout what kind of
> tricks this macro introduces and how that makes the code ugly.
> 
> For the sake of what ? Just a small optimization in the menu governor.
> 
> I suppose that has been introduce and then evolved on a wrong basis. So now
> we have to deal with that.
> 
> This patchset provides a first round of cleanup around the poll function,
> the next patchset will move the 5us timer optimization from the menu
> governor and the last patchset will remove the CPUIDLE_DRIVER_STATE_START
> ugly macro.

I don't get it, I've clearly not stared at it long enough, but why is
that STATE_START crap needed anywhere?

To me it appears 'natural' to have a latency_req==0 state, why does it
need so much special casing?
