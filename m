From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 05/18] cpufreq: Manage governor usage history with 'policy->last_governor'
Date: Tue, 17 Feb 2015 13:32:00 +0530
Message-ID: <CAKohpokKCxhMrVubu6rJpELkeXf9Afzv6mQqc7XOcTznbH7j+A@mail.gmail.com>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
	<bc7154266269beb8c6b9b3d56b529b64db33d2e2.1422346933.git.viresh.kumar@linaro.org>
	<54DC1806.9040001@codeaurora.org>
	<CAKohpomFvGXacyc-huavSyGxasrcKY19591OLMnAWY4hJHo9ow@mail.gmail.com>
	<a0d981c970a45d59bae727789a8b7834.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:62264 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754698AbbBQICB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Feb 2015 03:02:01 -0500
Received: by mail-ob0-f172.google.com with SMTP id nt9so50565451obb.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2015 00:02:00 -0800 (PST)
In-Reply-To: <a0d981c970a45d59bae727789a8b7834.squirrel@www.codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 12 February 2015 at 16:00,  <skannan@codeaurora.org> wrote:
> I think for logical hotplug we should lock the governor from being

Nack.

> removed. Or, if you don't want that, go set the pointer to NULL lazily
> when/if that happens.

That would be another band-aid ..

> I'm not sure if you read rest of my email. Unless you added some patches

I did read them..

> recently, restoring the last_governor is definitely functionally broken as
> of at least 3.12. Probably 3.14 too (I need to check again). It just
> restores the governor with the default tunables. So, it's kinda useless in
> the real world. You might as well set it to default governor because it's
> just as helpful as using the last governor with different tunables.

I agree that the tunables aren't restored, but this is useful atleast for the
case where the governor tunables are shared across policies. And so
we don't have to change the tunables on policy-re-init..

This patch wasn't about changing the functionality but about saving some
memory and simple code flow..
