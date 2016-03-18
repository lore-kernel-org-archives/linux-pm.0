From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: use high confidence factors only when considering polling
Date: Fri, 18 Mar 2016 11:32:28 -0700
Message-ID: <003301d18144$87bb8df0$9732a9d0$@net>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>	<CAJZ5v0iK=vO1HPKfbpMwNx_Tk-kjGEUKrCmehaK7nN+-Up7BoA@mail.gmail.com>	<20160316121400.680a6a46@annuminas.surriel.com>	<10828426.sI6CaBvZhk@vostro.rjw.lan>	<000701d180df$e8a14340$b9e3c9c0$@net> <CAJZ5v0gLXE=sRxv35hKuX88L4tphSBtPb9Y2oLERuEhjsbTGJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta6.telus.net ([209.171.16.79]:50877 "EHLO cmta6.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753404AbcCRSca (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Mar 2016 14:32:30 -0400
In-Reply-To: <CAJZ5v0gLXE=sRxv35hKuX88L4tphSBtPb9Y2oLERuEhjsbTGJQ@mail.gmail.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Rik van Riel' <riel@redhat.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Chen, Yu C'" <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, 'Arto Jantunen' <viiru@iki.fi>, 'Len Brown' <lenb@kernel.org>

On 2016.03.18 06:12 Rafael J. Wysocki wrote:
> On Fri, Mar 18, 2016 at 7:32 AM, Doug Smythies <dsmythies@telus.net> wrote:
>
>> For my part of it, this patch seems to be not O.K.
>> (reference rvr5 = this patch)
>>
>> Aggregate idle for the 2000 second test. All in minutes.
>> (old tests re-stated)
>>
>> State	k45rc7-rjw10	k45rc7-rjw10-reverted	k45rc7-rjw10-rvr5
>> 0.00	18.07			0.92				18.67
>> 1.00	12.35			19.51				12.82
>> 2.00	3.96			4.28				3.97
>> 3.00	1.55			1.53				1.58
>> 4.00	138.96		141.99			143.80
>>
>> total	174.90		168.24			180.84
>>
>> Energy:
>>>> Kernel 4.5-rc7-rjw10: 61983 Joules
>>>> Kernel 4.5-rc7-rjw10-reverted: 48409 Joules (test 2 was 55040 Joules)
>> Kernel 4.5-rc7-rjw10-rvr5: 62243 Joules
>>
>> I did acquire trace data with this test, but haven't post processed it yet.
>
> I'm wondering what happens if you replace the expected_interval in the
> "expected_interval >
> drv->states[CPUIDLE_DRIVER_STATE_START].target_residency" test with
> data->next_timer_us (with the Rik's patch applied, of course).  Can
> you please try doing that?

O.K. my reference: rvr6 is the above modification to rvr5
It works as well as "reverted"/

State	k45rc7-rjw10-rvr6 (mins)
0.00	0.87
1.00	24.20
2.00	4.05
3.00	1.72
4.00	147.50

total	178.34

Energy:
Kernel 4.5-rc7-rjw10-rvr6: 55864 Joules

Trace data (very crude summary):
Kernel 4.5-rc7-rjw10-rvr5: ~3049 long durations at high CPU load (idle state 0)
Kernel 4.5-rc7-rjw10-rvr5: ~183 long durations at high, but less, CPU load (not all idle state 0)

... Doug


