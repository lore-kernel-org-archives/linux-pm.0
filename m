From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] PM / Runtime: Only force-resume device if it has been force-suspended
Date: Thu, 21 Apr 2016 23:02:06 +0200
Message-ID: <CAJZ5v0jWj8X+6BTsxxTAz+AkziZkrgahyi+rVebga7fDWxSjXA@mail.gmail.com>
References: <1461196375-21768-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<16994316.unmTLNhP4d@vostro.rjw.lan>
	<1469950.TOloHQY8f4@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35014 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbcDUVCI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 17:02:08 -0400
In-Reply-To: <1469950.TOloHQY8f4@avalon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, linux-renesas-soc@vger.kernel.org

On Thu, Apr 21, 2016 at 10:57 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Rafael,
>
> On Thursday 21 Apr 2016 21:52:56 Rafael J. Wysocki wrote:
>> On Thursday, April 21, 2016 02:52:55 AM Laurent Pinchart wrote:
>> > The pm_runtime_force_suspend() and pm_runtime_force_resume() helpers are
>> > designed to help driver being RPM-centric by offering an easy way to
>> > manage runtime PM state during system suspend and resume. The first
>> > function will force the device into runtime suspend at system suspend
>> > time, while the second one will perform the reverse operation at system
>> > resume time.
>> >
>> > However, the pm_runtime_force_resume() really forces resume, regardless
>> > of whether the device was running or already suspended before the call
>> > to pm_runtime_force_suspend(). This results in devices being runtime
>> > resumed at system resume time when they shouldn't.
>> >
>> > Fix this by recording whether the device has been forcefully suspended
>> > in pm_runtime_force_suspend() and condition resume in
>> > pm_runtime_force_resume() to that state.
>> >
>> > All current users of pm_runtime_force_resume() call the function
>> > unconditionally in their system resume handler (some actually set it as
>> > the resume handler), all after calling pm_runtime_force_suspend() at
>> > system suspend time. The change in behaviour should thus be safe.
>> >
>> > Signed-off-by: Laurent Pinchart
>> > <laurent.pinchart+renesas@ideasonboard.com>
>> > Reviewed-by: Kevin Hilman <khilman@baylibre.com>
>>
>> Ulf, any comments?
>
> Ulf has proposed a different approach in "[PATCH] PM / Runtime: Defer resuming
> of the device in pm_runtime_force_resume()". I agree that using usage_count is
> better than introducing a new state flag in struct dev_pm_info, with a caveat:
> it doesn't work properly :-). We would have to fix genpd first, as commented
> in a reply to Ulf's patch.

OK, thanks!

Since I'd prefer to avoid adding more state flags too, I'll let you
guys noodle around this for a while more. :-)
