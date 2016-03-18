From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle: use high confidence factors only when
 considering polling
Date: Fri, 18 Mar 2016 22:24:10 +0100
Message-ID: <CAJZ5v0hOeFjj6d0jV+6aFtdkAk_ocH=K-KS5NSQ1P0-kqdnRkg@mail.gmail.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<CAJZ5v0iK=vO1HPKfbpMwNx_Tk-kjGEUKrCmehaK7nN+-Up7BoA@mail.gmail.com>
	<20160316121400.680a6a46@annuminas.surriel.com>
	<10828426.sI6CaBvZhk@vostro.rjw.lan>
	<000701d180df$e8a14340$b9e3c9c0$@net>
	<CAJZ5v0gLXE=sRxv35hKuX88L4tphSBtPb9Y2oLERuEhjsbTGJQ@mail.gmail.com>
	<003301d18144$87bb8df0$9732a9d0$@net>
	<20160318152957.5c3b91bc@annuminas.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36651 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbcCRVYM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 17:24:12 -0400
Received: by mail-lf0-f47.google.com with SMTP id d82so27602443lfe.3
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2016 14:24:11 -0700 (PDT)
In-Reply-To: <20160318152957.5c3b91bc@annuminas.surriel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>

On Fri, Mar 18, 2016 at 8:29 PM, Rik van Riel <riel@redhat.com> wrote:
> On Fri, 18 Mar 2016 11:32:28 -0700
> "Doug Smythies" <dsmythies@telus.net> wrote:
>> On 2016.03.18 06:12 Rafael J. Wysocki wrote:
>
>> > I'm wondering what happens if you replace the expected_interval in the
>> > "expected_interval >
>> > drv->states[CPUIDLE_DRIVER_STATE_START].target_residency" test with
>> > data->next_timer_us (with the Rik's patch applied, of course).  Can
>> > you please try doing that?
>>
>> O.K. my reference: rvr6 is the above modification to rvr5
>> It works as well as "reverted"/
>>
>> State k45rc7-rjw10-rvr6 (mins)
>> 0.00  0.87
>> 1.00  24.20
>> 2.00  4.05
>> 3.00  1.72
>> 4.00  147.50
>>
>> total 178.34
>>
>> Energy:
>> Kernel 4.5-rc7-rjw10-rvr6: 55864 Joules
>>
>> Trace data (very crude summary):
>> Kernel 4.5-rc7-rjw10-rvr5: ~3049 long durations at high CPU load (idle state 0)
>> Kernel 4.5-rc7-rjw10-rvr5: ~183 long durations at high, but less, CPU load (not all idle state 0)
>
> What does "long duration" mean?
> Dozens of microseconds?
> Hundreds of microseconds?
> Milliseconds?
>
> Either way, it appears there is something wrong with the
> code in get_typical_interval.  One of the problems is
> that calculating in microseconds, when working with a
> threshold of 1-2 microseconds is not going to work well,
> and secondly the code declares success the moment the
> standard deviation is below 20 microseconds, which is
> also not the best idea when dealing with 1-2 microsecond
> thresholds :)

Well, that might be the reason why 20 was used in the original
data->next_timer_us test ...
