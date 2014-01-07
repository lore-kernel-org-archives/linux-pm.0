From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [8/11] use-case 2: Audio playback on Android
Date: Tue, 7 Jan 2014 13:15:00 +0100
Message-ID: <20140107121500.GR30183@twins.programming.kicks-ass.net>
References: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
 <1387557951-21750-9-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:55947 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbaAGMP0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2014 07:15:26 -0500
Content-Disposition: inline
In-Reply-To: <1387557951-21750-9-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@kernel.org, rjw@rjwysocki.net, markgross@thegnar.org, vincent.guittot@linaro.org, catalin.marinas@arm.com, linux-pm@vger.kernel.org

On Fri, Dec 20, 2013 at 04:45:48PM +0000, Morten Rasmussen wrote:
> Audio playback is a low load periodic application that has little/no
> variation in period and load over time. It consists of tasks involved in
> decoding the audio stream and communicating with audio frameworks and
> drivers.
> 
> Performance Criteria
> 
> All tasks must have completed before the next request to fill the audio
> buffer. Most modern hardware should be able to deal with the load even
> at the lowest P-state.
> 
> Task behaviour
> 
> The task load pattern period is dictated by the audio interrupt. On an
> example modern ARM based system this occurs every ~6 ms. The decoding
> work is triggered every fourth interrupt, i.e. a ~24 ms period. No tasks
> are scheduled at the intermediate interrupts. The tasks involved are:
> 
> Main audio framework task (AudioOut): The first task to be scheduled
> after the interrupt and continues running until decoding has completed.
> That is ~5 ms. Runs at nice=-19.
> 
> Audio framework task 2 (AudioTrack): Woken up by the main task ~250-300
> us after the main audio task is scheduled. Runs for ~300 us at nice=-16.
> 
> Decoder task (mp3.decoder): Woken up by the audio task 2 when that
> finishes (serialized). Runs for ~1 ms until it wakes a third Android
> task on which it blocks and continues for another ~150 us afterwards
> (serialized). Runs at nice=-2.
> 
> Android task 3 (OMXCallbackDisp): Woken by decoder task. Runs for ~300
> us at nice=-2.

I probably shouldn't ask; but..

Why would the AudioOut task keep running while waiting for the
mp3.decoder thing to provide content? That doesn't make sense.

One would expect something simple like:

DMA buffer reaches low mark, sends interrupt, interrupt wakes task, task fills
up buffer, goto 1.

Instead we get this merry dance of far too many tasks.

And even if you want to add mixing multiple streams in software (and do
not optimize the single active stream) and you want to do this with
multiple tasks instead of chaining calls in the same task, you still
get a normal blocking task chain with at most 1 runnable task.

Something seems fucked with Android if it needs more than 1 running task
to fill an audio buffer.

/me continues reading..
