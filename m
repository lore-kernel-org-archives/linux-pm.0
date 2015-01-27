From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] doc: cpufreq: tests: Provide cpufreq tests README
Date: Tue, 27 Jan 2015 14:10:54 +0530
Message-ID: <CAKohpoma1M_TdJ2kCWB82isge+so=QMTP-thxoy4eo3nR+gWgQ@mail.gmail.com>
References: <1422268884-26173-1-git-send-email-l.majewski@samsung.com>
	<1422268884-26173-3-git-send-email-l.majewski@samsung.com>
	<CAKohpon6e1kX0DdB46t-60ddeZf1PG4yzSxX_nmVxsHst4cjwQ@mail.gmail.com>
	<20150127093523.55cb3a10@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:44819 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbbA0Ikz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:40:55 -0500
Received: by mail-oi0-f46.google.com with SMTP id a141so11384594oig.5
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 00:40:54 -0800 (PST)
In-Reply-To: <20150127093523.55cb3a10@amdc2363>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kevin Hilman <khilman@linaro.org>, Kevin Hilman <khilman@kernel.org>, a.nitecki@samsung.com

On 27 January 2015 at 14:05, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Very nice pack of tests.

Thanks.

> What I can say after a glimpse look on them is that your tests already
> implement case for "governors switching".

Correct and much more than that :)

> However the 'cpufreq_freq_test.sh' do a bit more - it uses performance,
> then forces 100% CPU usage and then switch from one single frequency to
> all available (including BOOST modes). For that reason I think that it
> would be valuable to add this test to your suite (of course on your
> discretion).

Will you be able to send a patch for that to me (*without* the lists)?

> Viresh, do you plan to add your tests to
> kernel's ./tools/testing/cpufreq/ directory? It would enhance
> recognition of your work and encourage others to use it before
> submitting patches.

Yeah, I do plan to. I have been doing some major reworks of cpufreq
core and so I built them. I haven't found time yet to get them in, but
they will surely be there in some time :)

--
viresh
