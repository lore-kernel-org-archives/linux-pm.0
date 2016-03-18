From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle: use high confidence factors only when
 considering polling
Date: Fri, 18 Mar 2016 22:48:45 +0100
Message-ID: <CAJZ5v0iRn7eZY_g8UYze_Wq4v9pCTBMrgjHcuM1OVuTvJHUpAg@mail.gmail.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<CAJZ5v0iK=vO1HPKfbpMwNx_Tk-kjGEUKrCmehaK7nN+-Up7BoA@mail.gmail.com>
	<20160316121400.680a6a46@annuminas.surriel.com>
	<10828426.sI6CaBvZhk@vostro.rjw.lan>
	<000701d180df$e8a14340$b9e3c9c0$@net>
	<CAJZ5v0gLXE=sRxv35hKuX88L4tphSBtPb9Y2oLERuEhjsbTGJQ@mail.gmail.com>
	<003301d18144$87bb8df0$9732a9d0$@net>
	<20160318173551.675ff6e5@annuminas.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33854 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706AbcCRVsr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 17:48:47 -0400
Received: by mail-lb0-f178.google.com with SMTP id k12so96291079lbb.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2016 14:48:46 -0700 (PDT)
In-Reply-To: <20160318173551.675ff6e5@annuminas.surriel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>

On Fri, Mar 18, 2016 at 10:35 PM, Rik van Riel <riel@redhat.com> wrote:
> On Fri, 18 Mar 2016 11:32:28 -0700
> "Doug Smythies" <dsmythies@telus.net> wrote:
>
>> Energy:
>> Kernel 4.5-rc7-rjw10-rvr6: 55864 Joules
>>
>> Trace data (very crude summary):
>> Kernel 4.5-rc7-rjw10-rvr5: ~3049 long durations at high CPU load (idle state 0)
>> Kernel 4.5-rc7-rjw10-rvr5: ~183 long durations at high, but less, CPU load (not all idle state 0)
>
> This is a bit of a big hammer, but since the polling loop already uses
> full CPU power anyway, this could be harmless, and solve your problem.

Yes, it would be good to test this.

No, I don't like it.

If we are to break out of the polling loop after a specific time, we
shouldn't be using polling at all in the first place.

So I very much prefer to compare data->next_timer_us with the target
residency of C1 instead of doing this.
