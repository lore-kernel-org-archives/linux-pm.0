From: Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH] PM / Sleep: Print last wakeup source on failed
 wakeup_count write
Date: Tue, 11 Jun 2013 16:20:19 -0700
Message-ID: <CAODwPW8Je0-W5nwvAmWasvwGejWHoeQnaPi8AeDe9s71mQVE7g@mail.gmail.com>
References: <1369944137-30948-1-git-send-email-jwerner@chromium.org>
	<4844834.TBe7kS6ocA@vostro.rjw.lan>
	<CAODwPW9gt_E_rtVhk4bMO_EnGaLbRqca0xQosQBc7KuEtEDQXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:60939 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657Ab3FKXUU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2013 19:20:20 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so12289647obb.39
        for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2013 16:20:19 -0700 (PDT)
In-Reply-To: <CAODwPW9gt_E_rtVhk4bMO_EnGaLbRqca0xQosQBc7KuEtEDQXQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Julius Werner <jwerner@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Todd Poynor <toddpoynor@google.com>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>

Resending as plain text... sorry for the spam, Gmail just likes to
silently mess up my settings every once in a while.

On Tue, Jun 11, 2013 at 4:17 PM, Julius Werner <jwerner@chromium.org> wrote:
>
>> This is going to be done in the autosleep case too, which I'm slightly
>> concerned about.
>>
>> If you wanted to cover /sys/power/wakeup_count only, it would be better
>> to put that into wakeup_count_store(), but perhaps you wanted to cover
>> autosleep too?
>
>
> Hmm... no, I did not really take the autosleep case into account. I can't
> quite tell with what frequency the autosleep try_to_suspend() handler on an
> active system would run... do you think it might be a useful feature to have
> there, or would it lead to logspam?
>
> I can move it to wakeup_count_store() if you prefer, but then I will have to
> turn print_active_wakeup_sources() into an exported function, which is also
> a little inconvenient.
