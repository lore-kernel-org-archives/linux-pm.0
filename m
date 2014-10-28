From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [RFC/PATCH] PM / Sleep: Timer quiesce in freeze state
Date: Tue, 28 Oct 2014 12:32:16 +0800
Message-ID: <544F1C50.8010505@linux.intel.com>
References: <5446787E.60202@linux.intel.com> <20141024153656.GM12706@worktop.programming.kicks-ass.net> <544DE5CF.9040501@linux.intel.com> <20141027072816.GD10501@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141027072816.GD10501@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, "linux-pm@vger.kernel.org >> Linux PM list" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2014/10/27 15:28, Peter Zijlstra wrote:
> On Mon, Oct 27, 2014 at 02:27:27PM +0800, Li, Aubrey wrote:
>>> Now I suppose the problem is with cpu_pause() which needs IPIs to
>>> complete? Do we really need cpuidle_pause() there?
>>> cpuidle_uninstall_handlers() seems like a daft thing to call just about
>>> there.
>>
>> Please check the log of 8651f97bd951d0bb1c10fa24e3fa3455193f3548.
>> Rafael should know more this question than me.
> 
> That changelog explains its complete bollocks to do it here. We _want_
> to enter and/or remain in deep idle states.

cpuidle_resume() will be called at the end of dpm_resume_noirq(). So we
still are able to enter deep idle states after resume.

Thanks,
-Aubrey

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
