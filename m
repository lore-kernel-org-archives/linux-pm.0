From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 3/3] doc: cpufreq: tests: Provide cpufreq tests README
Date: Tue, 27 Jan 2015 09:35:23 +0100
Message-ID: <20150127093523.55cb3a10@amdc2363>
References: <1422268884-26173-1-git-send-email-l.majewski@samsung.com>
 <1422268884-26173-3-git-send-email-l.majewski@samsung.com>
 <CAKohpon6e1kX0DdB46t-60ddeZf1PG4yzSxX_nmVxsHst4cjwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:60390 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757725AbbA0Ife (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:35:34 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NIT0069LUJ82S60@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 27 Jan 2015 17:35:32 +0900 (KST)
In-reply-to: <CAKohpon6e1kX0DdB46t-60ddeZf1PG4yzSxX_nmVxsHst4cjwQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kevin Hilman <khilman@linaro.org>, Kevin Hilman <khilman@kernel.org>, a.nitecki@samsung.com

Hi Viresh,

> On 26 January 2015 at 16:11, Lukasz Majewski <l.majewski@samsung.com>
> wrote:
> > This commit adds README to ./tools/testing/cpufreq directory.
> 
> You might want to have a look at this..
> 
> https://git.linaro.org/people/viresh.kumar/cpufreq-tests.git
> 
> 
> I had been working on this recently ..

Very nice pack of tests.

What I can say after a glimpse look on them is that your tests already
implement case for "governors switching".

However the 'cpufreq_freq_test.sh' do a bit more - it uses performance,
then forces 100% CPU usage and then switch from one single frequency to
all available (including BOOST modes). For that reason I think that it
would be valuable to add this test to your suite (of course on your
discretion).

Viresh, do you plan to add your tests to
kernel's ./tools/testing/cpufreq/ directory? It would enhance
recognition of your work and encourage others to use it before
submitting patches.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
