From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq-dt: register cooling device after validating
 cpufreq table
Date: Wed, 26 Nov 2014 11:27:42 +0530
Message-ID: <CAKohpo=ZM8QstEOp1A86N2jzDEY5w2FmB7K0rtLPmzg+_iZdMw@mail.gmail.com>
References: <b4a56cad08c5ef701cf268881697caabe5229994.1416826729.git.viresh.kumar@linaro.org>
	<2189780.D9n5NYrXn8@vostro.rjw.lan>
	<1447952.pbyqNN4RJG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:47942 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbaKZF5m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 00:57:42 -0500
Received: by mail-oi0-f42.google.com with SMTP id v63so1571824oia.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 21:57:42 -0800 (PST)
In-Reply-To: <1447952.pbyqNN4RJG@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>

On 26 November 2014 at 03:35, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> And what bad things are going to happen if this is not pushed for 3.18?

This is what Eduardo reported in one of the mails:

---

As an example, I am taking the ti-soc-thermal, but we already have other
of-thermal based drivers. Booting with this patch ti-soc-thermal
(of-based boot) loads fine, but the cpu_cooling never gets bound to the
thermal zone.

The thing is that the bind may happen before cpufreq-dt code loads the
cpufreq driver, and when cpu_cooling is checking what is the max freq,
by using cpufreq table, it won't be able to do it, as there is no table.

While, without the patch, it will use wrong in the binding, but after
it gets bound, and cpufreq loads, the max will be used correctly.

----

And so it looked like things aren't going to work smoothly in 3.18
and so I thought we should get it in.

But probably the problem will be worst only after applying Lukasz
patchset?

@Eduardo: Do you want Rafael to apply this for 3.18? or 3.19 will
work as well ?

--
viresh
