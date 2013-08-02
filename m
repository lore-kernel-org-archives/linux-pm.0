From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: BUG_ON(irqs_disabled()) in cpufreq.c
Date: Fri, 2 Aug 2013 14:32:17 +0530
Message-ID: <CAKohpon+sQTA77Ln++y2kqRprTwrs0_cWw_c+mfF7p97er_yUg@mail.gmail.com>
References: <CAEL66Hib_KJ3=5Hi-=OAye=2pbQz_0-PcC6CicjP9n2Ng2KG9g@mail.gmail.com>
	<CAOh2x=nfzMEgbetmaUhjKx2FfCvxPjOxk6A_XC-Q9h0+HOEnGQ@mail.gmail.com>
	<20130802063854.6450.70950@quantum>
	<CAKohpok4y3jyZqddQDJu5kwRxZyV7QMRUXFQ-C66Xe90soCKhw@mail.gmail.com>
	<CAG-99FMEnzgS18t5X0vb6NsT8zqUWngW6eUfatQut3VCoTHoWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:48722 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756286Ab3HBJCS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Aug 2013 05:02:18 -0400
Received: by mail-ob0-f169.google.com with SMTP id wc20so722106obb.14
        for <linux-pm@vger.kernel.org>; Fri, 02 Aug 2013 02:02:17 -0700 (PDT)
In-Reply-To: <CAG-99FMEnzgS18t5X0vb6NsT8zqUWngW6eUfatQut3VCoTHoWg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM list <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, cpufreq@vger.kernel.org, Michael Giardino <giardino@ece.gatech.edu>

On 2 August 2013 14:29, Tuukka Tikkanen <tuukka.tikkanen@linaro.org> wrote:
> Like Mike said, the reason is the assumption that DVFS actions may want to
> sleep. While that may not be true for you, the governor you are working on
> might get used on a platform where these actions do sleep. Therefore,
> regardless of the actual situation, these functions are always assumed to
> need a non-interrupt context.

I have the same answer to this as what I wrote in my last mail.

>> BTW, The routine in question doesn't change frequency by itself. But the
>> caller of this routine will change clk just after/before calling this
>> routine.

And so, this routine doesn't need interrupts to be disabled.
