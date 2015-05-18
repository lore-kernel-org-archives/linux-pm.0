From: Stephane Eranian <eranian@google.com>
Subject: Re: suspend regression in 4.1-rc1
Date: Mon, 18 May 2015 05:13:05 -0700
Message-ID: <CABPqkBTDEXkFuTVZG=LizC2pFwGwswzC6xwxsZAgeVGv5Xw6Ug@mail.gmail.com>
References: <20150517185041.GA5897@dhcp22.suse.cz>
	<CA+55aFy2wWy-k0O-Sb2vUCLiLjeKMu7r95bf294qP5UqQHuxfw@mail.gmail.com>
	<20150518073046.GO17717@twins.programming.kicks-ass.net>
	<20150518090336.GA6393@dhcp22.suse.cz>
	<20150518093150.GC21418@twins.programming.kicks-ass.net>
	<309071648.615900.1431946606778.JavaMail.zimbra@redhat.com>
	<20150518110513.GE21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36475 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbbERMNG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 08:13:06 -0400
Received: by obbkp3 with SMTP id kp3so120594313obb.3
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2015 05:13:05 -0700 (PDT)
In-Reply-To: <20150518110513.GE21418@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ulrich Obergfell <uobergfe@redhat.com>, Michal Hocko <mhocko@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, Don Zickus <dzickus@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi,

On Mon, May 18, 2015 at 4:05 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, May 18, 2015 at 06:56:46AM -0400, Ulrich Obergfell wrote:
>> > Subject: watchdog: Fix merge 'conflict'
>> >
>> > Two watchdog changes that came through different trees had a non
>> > conflicting conflict, that is, one changed the semantics of a variable
>> > but no actual code conflict happened. So the merge appeared fine, but
>> > the resulting code did not behave as expected.
>> >
>> > Commit 195daf665a62 ("watchdog: enable the new user interface of the
>> > watchdog mechanism") changes the semantics of watchdog_user_enabled,
>> > which thereafter is only used by the functions introduced by
>> > b3738d293233 ("watchdog: Add watchdog enable/disable all functions").
>>
>> Don and I already posted a patch in April to address this:
>>
>> https://lkml.org/lkml/2015/4/22/306
>> http://ozlabs.org/~akpm/mmots/broken-out/watchdog-fix-watchdog_nmi_enable_all.patch
>
> Yeah, but it seems to have gotten lost on its way to Linus.
>
>> > There further appears to be a distinct lack of serialization between
>> > setting and using watchdog_enabled, so perhaps we should wrap the
>> > {en,dis}able_all() things in watchdog_proc_mutex.
>>
>> As I understand it, the {en,dis}able_all() functions are only called early
>> at kernel startup, so I do not see how they could be racing with watchdog
>> code that is executed in the context of write() system calls to parameters
>> in /proc/sys/kernel. Please see also my earlier reply to Michal for further
>> details: http://marc.info/?l=linux-pm&m=143194387208250&w=2
>>
>> Do we really need synchronization here?
>
> Same argument as in my previous email; its best to implement exposed
> functions fully and correctly, irrespective of their usage sites.
>
> It costs little extra and might safe a few hairs down the lined. None of
> this is performance critical.

I cannot reproduce this problem on my T430s running tip.git at 4.1-rc3.

The thing about b37609c30e41 is that is introduces a deferred initcall
for perf_events. It adds an subsys_initcall after the default initialization
of perf_events The reason is that the fixup_ht_bug() needs to wait until
cpu topology is setup before proceeding. Thus by the time
watchdog_nmi_disable_all() is called from that function, the kernel
may be multi-cpu already. Thus, there may be a race.




commit b37609c30e41264c4df4acff78abfc894499a49b
Author: Stephane Eranian <eranian@google.com>
Date:   Mon Nov 17 20:07:04 2014 +0100
   perf/x86/intel: Make the HT bug workaround conditional on HT enabled
