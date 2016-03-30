From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: acpi: policy->driver_data can't be NULL in ->exit()
Date: Wed, 30 Mar 2016 13:18:08 +0200
Message-ID: <CAJZ5v0gyndbTjEYvS8BjZzC-jsKc_M2w9BZF=z-tjEVqMxqFog@mail.gmail.com>
References: <f4f0e029b46cdd09dd7d3f0035e8588f5de94e21.1459311858.git.viresh.kumar@linaro.org>
	<CAJZ5v0hqrUyi2ggsDyOq9y0Q9BzktYdSG6DZQMfMF9HsqRLf0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:34932 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbcC3LSK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 07:18:10 -0400
In-Reply-To: <CAJZ5v0hqrUyi2ggsDyOq9y0Q9BzktYdSG6DZQMfMF9HsqRLf0g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Mar 30, 2016 at 1:15 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Mar 30, 2016 at 6:24 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Its always set by ->init() and so it will always be there in ->exit().
>> There is no need to have a special check for just that.
>
> I'm not sure what happens if there are two (or more) CPUs in the policy, though.
>
> That case is almost certainly handled incorrectly here (or rather not
> handled at all), but it may just happen to sort of work, because the
> first exiting CPU will clear driver_data and the second one will
> notice that it is NULL now.  Of course, that still is racy with
> respect to governors etc, but I'd rather fix the driver properly.

Sorry, scratch that.  To core only calls ->exit for the last CPU in
the policy, so I agree with the patch.

It conflicts with other stuff (as you know), so I'm not sure about the
order in which they are going to be applied, though.

Thanks,
Rafael
