From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [GIT PULL] CPUFreq: ARM Updates for v3.11
Date: Fri, 7 Jun 2013 16:35:24 +0530
Message-ID: <CAKohponx-dSdRVX77Fa8ePKhppvvE=dS=ofJT0_+3014b38ZOg@mail.gmail.com>
References: <CAKohpokdrw1KZuCx6Y5E1JyK-Yq0T1fh0qP+bEaqgZjoK8JEEQ@mail.gmail.com>
	<54837539.yBQlA0EhhC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:55668 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638Ab3FGLFY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2013 07:05:24 -0400
Received: by mail-ob0-f170.google.com with SMTP id ef5so6398980obb.29
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2013 04:05:24 -0700 (PDT)
In-Reply-To: <54837539.yBQlA0EhhC@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lists linaro-dev <linaro-dev@lists.linaro.org>, linux-arm-kernel@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On 7 June 2013 16:41, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, June 07, 2013 04:26:36 PM Viresh Kumar wrote:

>>       cpufreq: bit.LITTLE needs cpufreq table
>
> That should be big.LITTLE I suppose?

Yes. This is not the first time I face this issue where big is
written as bit. Even I named one of my external repo like this
earlier and after a long time some other careful viewer caught
it :)

Fixed my branch now with s/bit/big.

Thanks.
