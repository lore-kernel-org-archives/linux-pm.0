From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq and memory intensive benchmarks
Date: Mon, 5 Aug 2013 12:40:13 +0530
Message-ID: <CAOh2x==AR1KQO7f8RSztXpU9g2pCyToikmk6GLO0SXfUGTw3dA@mail.gmail.com>
References: <CAMefCkCv1vXWJ3wVq0i3uugmPoXRVHscfDsk1J3h3amtpLsZ6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vb0-f54.google.com ([209.85.212.54]:49706 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749Ab3HEHKO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2013 03:10:14 -0400
In-Reply-To: <CAMefCkCv1vXWJ3wVq0i3uugmPoXRVHscfDsk1J3h3amtpLsZ6Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guru Prasad <gurupras@buffalo.edu>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

Please remember adding cc'd lists/people in your next mail

On Sat, Aug 3, 2013 at 1:15 AM, Guru Prasad <gurupras@buffalo.edu> wrote:
> I was recently running some SPEC benchmarks to test the way in which
> cpufreq module adjusts the CPU frequency for various benchmarks and I
> noticed that cpufreq always tends to rest at the maximum frequency
> regardless of the benchmark on ondemand / conservative.

They will stay there if cpu is busy doing some activity..

> I then tried to identify memory intensive benchmarks
> (http://users.elis.ugent.be/~leeckhou/papers/isca12-2.pdf) and upon
> running milc / libquantum, I noticed that the same trend continued.
>
> Does this mean that memory operation latencies are attributed as CPU busy time?
> Could someone explain the inner workings behind this? What does the
> CPU *really* do while the load/store is executing? Is it busy-waiting
> / idle?

We actually take cpu's busy vs idle time for all calculations here..
idle time is calculated by the time cpu was running its idle thread..
i.e. when CPU doesn't have any process to run and is idle..

But in your case not sure how cpu would behave.. If cpu is doing
word-by-word copy of some stuff, it would be busy most of the
time and isn't really running its idle thread. And so would be counted
as busy I suppose..

But if some DMA is taking care of copying stuff then it can be idle,
depending on what else is getting scheduled on it.

@Rafael: Am I right?

--
Viresh
