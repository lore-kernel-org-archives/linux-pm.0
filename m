From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq-dt: register cooling device after validating
 cpufreq table
Date: Wed, 26 Nov 2014 08:58:11 +0530
Message-ID: <CAKohpomLQQgfX_9OEoP=DJn392=qap1o6x6fW+y3v2X8keJ9oA@mail.gmail.com>
References: <b4a56cad08c5ef701cf268881697caabe5229994.1416826729.git.viresh.kumar@linaro.org>
	<20141125014435.GA28906@developer>
	<CAKohpomFOJWc4C9rWbCmcW7e1kUO=C=awO9RFvBVA0-H2dHjZQ@mail.gmail.com>
	<1620245.pJZHDc87Jv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:39157 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbaKZD2L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 22:28:11 -0500
Received: by mail-oi0-f46.google.com with SMTP id h136so1430232oig.33
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 19:28:11 -0800 (PST)
In-Reply-To: <1620245.pJZHDc87Jv@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Eduardo Valentin <edubezval@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>

On 26 November 2014 at 02:17, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Can we please avoid adding any new notifiers?

Sure :)

> We can add a new cpufreq driver callback to be invoked by the core when
> everything has been set up for this purpose.

Hmm, that will be better..
