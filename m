From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq-dt: register cooling device after validating
 cpufreq table
Date: Wed, 26 Nov 2014 11:32:17 +0530
Message-ID: <CAKohpon=mHNae2ZC+Yi4yTv_Oy=yWHn2RrMBzrcdJVLyEW6W_w@mail.gmail.com>
References: <b4a56cad08c5ef701cf268881697caabe5229994.1416826729.git.viresh.kumar@linaro.org>
	<2189780.D9n5NYrXn8@vostro.rjw.lan>
	<1447952.pbyqNN4RJG@vostro.rjw.lan>
	<CAKohpo=ZM8QstEOp1A86N2jzDEY5w2FmB7K0rtLPmzg+_iZdMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:56159 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbaKZGCS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 01:02:18 -0500
Received: by mail-oi0-f46.google.com with SMTP id h136so1541870oig.5
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 22:02:17 -0800 (PST)
In-Reply-To: <CAKohpo=ZM8QstEOp1A86N2jzDEY5w2FmB7K0rtLPmzg+_iZdMw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>

On 26 November 2014 at 11:27, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 26 November 2014 at 03:35, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> And what bad things are going to happen if this is not pushed for 3.18?
>
> This is what Eduardo reported in one of the mails:

https://lkml.org/lkml/2014/11/21/451
