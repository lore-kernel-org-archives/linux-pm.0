From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 08/14] cpufreq: remove CPUFREQ_UPDATE_POLICY_CPU notifications
Date: Mon, 5 Jan 2015 09:57:52 +0530
Message-ID: <CAKohpon5r2a+VZPPV1K_oODbSzje+RM-jTHDOH5251yKjE0zQg@mail.gmail.com>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
	<dd0f0186a7a3cc759d48ea1c7d3c6494e69db6b9.1420177186.git.viresh.kumar@linaro.org>
	<2433937.yfFORihJWM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:57866 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbbAEE1x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jan 2015 23:27:53 -0500
Received: by mail-ob0-f176.google.com with SMTP id vb8so59505269obc.7
        for <linux-pm@vger.kernel.org>; Sun, 04 Jan 2015 20:27:52 -0800 (PST)
In-Reply-To: <2433937.yfFORihJWM@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On 4 January 2015 at 03:58, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, January 02, 2015 11:16:45 AM Viresh Kumar wrote:
>> CPUFREQ_UPDATE_POLICY_CPU notifications were used only from cpufreq-stats which
>> doesn't use it anymore. Remove them.
>>
>> This also fixes the value of other notification macros, hopefully all users are
>> using macro's instead of direct values and nothing will break :)
>
> The paragraph above is completely unclear to me.  Do you mean that it changes
> the definitions of CPUFREQ_CREATE_POLICY and CPUFREQ_REMOVE_POLICY too which
> may affect code that uses numbers instead of these symbols?

Yeah. I will try to rewrite it a bit..
