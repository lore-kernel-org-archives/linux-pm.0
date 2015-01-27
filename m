From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 3/3] doc: cpufreq: tests: Provide cpufreq tests README
Date: Tue, 27 Jan 2015 09:57:25 +0100
Message-ID: <20150127095725.48350e56@amdc2363>
References: <1422268884-26173-1-git-send-email-l.majewski@samsung.com>
 <1422268884-26173-3-git-send-email-l.majewski@samsung.com>
 <CAKohpon6e1kX0DdB46t-60ddeZf1PG4yzSxX_nmVxsHst4cjwQ@mail.gmail.com>
 <20150127093523.55cb3a10@amdc2363>
 <CAKohpoma1M_TdJ2kCWB82isge+so=QMTP-thxoy4eo3nR+gWgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46569 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbbA0I5d (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:57:33 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NIT004DPVJWMY80@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 27 Jan 2015 17:57:32 +0900 (KST)
In-reply-to: <CAKohpoma1M_TdJ2kCWB82isge+so=QMTP-thxoy4eo3nR+gWgQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kevin Hilman <khilman@linaro.org>, Kevin Hilman <khilman@kernel.org>, a.nitecki@samsung.com

Hi Viresh,

> On 27 January 2015 at 14:05, Lukasz Majewski <l.majewski@samsung.com>
> wrote:
> > Very nice pack of tests.
> 
> Thanks.
> 
> > What I can say after a glimpse look on them is that your tests
> > already implement case for "governors switching".
> 
> Correct and much more than that :)
> 
> > However the 'cpufreq_freq_test.sh' do a bit more - it uses
> > performance, then forces 100% CPU usage and then switch from one
> > single frequency to all available (including BOOST modes). For that
> > reason I think that it would be valuable to add this test to your
> > suite (of course on your discretion).
> 
> Will you be able to send a patch for that to me (*without* the lists)?

I rather thought about running this test as your run yours with runme.sh

> 
> > Viresh, do you plan to add your tests to
> > kernel's ./tools/testing/cpufreq/ directory? It would enhance
> > recognition of your work and encourage others to use it before
> > submitting patches.
> 
> Yeah, I do plan to. I have been doing some major reworks of cpufreq
> core and so I built them. I haven't found time yet to get them in, but
> they will surely be there in some time :)

I had similar problem with UDC/USB development in u-boot. I had a set
of "private/not ready to publish/etc" tests against regressions.

Only when I've posted those tests to the mailing list and they were
included to development tree, people started to use them before
submitting patches. I have less maintanence work and also developers
helped me a lot with improving the tests itself.

I'm a good example - I wasn't aware about your tests, and hence didn't
use them.
I believe that those tests shall land under ./tools/testing/cpufreq/
directory ASAP.

> 
> --
> viresh



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
