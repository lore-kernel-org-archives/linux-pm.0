From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 13/14] cpufreq: stats: Fix locking
Date: Tue, 6 Jan 2015 09:04:46 +0530
Message-ID: <CAKohpo=5ry7HQQ5vrxnsqdtaKz-ePJm9+sVyo3vKymWNxWifDg@mail.gmail.com>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
	<2107105.bVfAua7dNn@vostro.rjw.lan>
	<CAKohpon2gVxVQp7Yg4+DNKg=WAp35rAi=Bynu8igjNw9NutVDQ@mail.gmail.com>
	<21209857.m88aJg9vUk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:56848 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319AbbAFDer (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jan 2015 22:34:47 -0500
Received: by mail-ob0-f179.google.com with SMTP id va2so64050157obc.10
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2015 19:34:46 -0800 (PST)
In-Reply-To: <21209857.m88aJg9vUk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On 6 January 2015 at 05:05, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Hard to say from the top of my head and I'm not sure if I have the time to
> have a deeper look into that during the next few days.

Ok, let me resend the patches then with better improved logs. And lets
see if something is still missing.
