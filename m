From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] Fix CONFIG_PM_OPP without CONFIG_OF build failure
Date: Thu, 5 May 2016 10:20:48 +0100
Message-ID: <CAPKp9uZihuEHBgA7vnsuPNUeEW2ue-+bjFXMyPAT39EC0JmvTw@mail.gmail.com>
References: <20160505030109.GG2573@vireshk-i7>
	<1462439658-4523-1-git-send-email-eric.engestrom@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f196.google.com ([209.85.214.196]:34451 "EHLO
	mail-ob0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902AbcEEJUt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2016 05:20:49 -0400
In-Reply-To: <1462439658-4523-1-git-send-email-eric.engestrom@imgtec.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eric Engestrom <eric.engestrom@imgtec.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rufus Hamade <rufus.hamade@imgtec.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>

On Thu, May 5, 2016 at 10:14 AM, Eric Engestrom
<eric.engestrom@imgtec.com> wrote:
> From: Rufus Hamade <rufus.hamade@imgtec.com>
>
> A few `#ifdef CONFIG_OF` were missing, resulting in "unused function"
> warnings in core.c.
>
> Signed-off-by: Rufus Hamade <rufus.hamade@imgtec.com>
> Reviewed-by: Eric Engestrom <eric.engestrom@imgtec.com>
> Tested-by: Eric Engestrom <eric.engestrom@imgtec.com>
> ---
> v2: drop incorrect change in cpu.c (Viresh Kumar)
>
> On Thu, May 05, 2016 at 08:31:09AM +0530, Viresh Kumar wrote:
>> Some things have already changed, can you please rebase on linux-next
>> and resend this patch?
>
> I rebased on top of linux-next (30d0993ec9f6) from the repo
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> but there were no change (the patch is identical, save for the
> removed change in cpu.c; not even a line number changed).
> Which repo did you want me to rebase on?
>

I posted some changes around this a week ago, I see Rafael has pulled into
his bleeding-edge[1] patch this morning. If no issue are found, it
should eventually
make to linux-next in couple of days.

Regards,
Sudeep

[1] git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm bleeding-edge
