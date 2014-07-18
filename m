From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH] cpufreq: tests: Providing cpufreq regression test
Date: Fri, 18 Jul 2014 13:59:33 +0200
Message-ID: <20140718135933.0837e094@amdc2363>
References: <1405678985-21677-1-git-send-email-l.majewski@samsung.com>
 <CAK5sBcH=L-7=BHNPQUjuoQfQx5QeFmBSdwdow+RXBExgCOP0Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:44993 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761566AbaGRL7o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jul 2014 07:59:44 -0400
In-reply-to: <CAK5sBcH=L-7=BHNPQUjuoQfQx5QeFmBSdwdow+RXBExgCOP0Ww@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <spk.linux@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Abraham <ta.omasab@gmail.com>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tomasz Figa <t.figa@samsung.com>

Hi Sachin,

> Hi Lukasz,
> 
> I tested this script on 4210 based Origen board.
> This is the output:
> ./cpufreq_freq_test.sh
> CURRENT GOVERNOR: performance
> SET GOVERNOR: performance
> ######################################
> TEST AVAILABLE FREQS
> ######################################
> FREQ: 1200000 sleep: invalid number '0.1'
> [    5.918347] random: gzip urandom read with 61 bits of entropy
> available OK
> FREQ: 1000000 sleep: invalid number '0.1'
>          OK
> FREQ: 800000 sleep: invalid number '0.1'
>          OK
> FREQ: 500000 sleep: invalid number '0.1'
>          OK
> FREQ: 200000 sleep: invalid number '0.1'
>          OK
> ######################################
> TEST FREQS SWITCHING
> ######################################
> REFERENCE FREQ: 1200000
> FREQ: 1200000 ----> FREQ: 1200000 sleep: invalid number '0.1'
>          OK
> FREQ: 1200000 ----> FREQ: 1000000 sleep: invalid number '0.1'
>          OK
> FREQ: 1200000 ----> FREQ: 800000 sleep: invalid number '0.1'
>          OK
> FREQ: 1200000 ----> FREQ: 500000 sleep: invalid number '0.1'
>          OK
> FREQ: 1200000 ----> FREQ: 200000 sleep: invalid number '0.1'
>          OK
> REFERENCE FREQ: 1000000
> FREQ: 1000000 ----> FREQ: 1200000 sleep: invalid number '0.1'
>          OK
> FREQ: 1000000 ----> FREQ: 1000000 sleep: invalid number '0.1'
>          OK
> FREQ: 1000000 ----> FREQ: 800000 sleep: invalid number '0.1'
>          OK
> FREQ: 1000000 ----> FREQ: 500000 sleep: invalid number '0.1'
>          OK
> FREQ: 1000000 ----> FREQ: 200000 sleep: invalid number '0.1'
>          OK
> REFERENCE FREQ: 800000
> FREQ: 800000 ----> FREQ: 1200000 sleep: invalid number '0.1'
>          OK
> FREQ: 800000 ----> FREQ: 1000000 sleep: invalid number '0.1'
>          OK
> FREQ: 800000 ----> FREQ: 800000 sleep: invalid number '0.1'
>          OK
> FREQ: 800000 ----> FREQ: 500000 sleep: invalid number '0.1'
>          OK
> FREQ: 800000 ----> FREQ: 200000 sleep: invalid number '0.1'
>          OK
> REFERENCE FREQ: 500000
> FREQ: 500000 ----> FREQ: 1200000 sleep: invalid number '0.1'
>          OK
> FREQ: 500000 ----> FREQ: 1000000 sleep: invalid number '0.1'
>          OK
> FREQ: 500000 ----> FREQ: 800000 sleep: invalid number '0.1'
>          OK
> FREQ: 500000 ----> FREQ: 500000 sleep: invalid number '0.1'
>          OK
> FREQ: 500000 ----> FREQ: 200000 sleep: invalid number '0.1'
>          OK
> REFERENCE FREQ: 200000
> FREQ: 200000 ----> FREQ: 1200000 sleep: invalid number '0.1'
>          OK
> FREQ: 200000 ----> FREQ: 1000000 sleep: invalid number '0.1'
>          OK
> FREQ: 200000 ----> FREQ: 800000 sleep: invalid number '0.1'
>          OK
> FREQ: 200000 ----> FREQ: 500000 sleep: invalid number '0.1'
>          OK
> FREQ: 200000 ----> FREQ: 200000 sleep: invalid number '0.1'
>          OK
> ######################################
> ERRORS: 0
> ######################################
> 
> Though it says 0 errors, what does the "invalid number..." signify?

I guess that this message is caused by your default sleep
implementation.

Could you type 'sleep 0.1' and then 'sleep 1' in your console on the
target system?
Is the "invalid number" not present with the second case?


> 
> 
> On Fri, Jul 18, 2014 at 3:53 PM, Lukasz Majewski
> <l.majewski@samsung.com> wrote:
> > This commit adds first regression test "cpufreq_freq_test.sh" for
> > the cpufreq subsystem.
> >
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > ---
> >  drivers/cpufreq/tests/README               |  23 +++++
> >  drivers/cpufreq/tests/cpufreq_freq_test.sh | 149
> > +++++++++++++++++++++++++++++ 2 files changed, 172 insertions(+)
> >  create mode 100644 drivers/cpufreq/tests/README
> >  create mode 100755 drivers/cpufreq/tests/cpufreq_freq_test.sh
> >
> > diff --git a/drivers/cpufreq/tests/README
> > b/drivers/cpufreq/tests/README new file mode 100644
> > index 0000000..66638d2
> > --- /dev/null
> > +++ b/drivers/cpufreq/tests/README
> > @@ -0,0 +1,23 @@
> > +This file contains list of cpufreq's available regression tests
> > with a short +usage description.
> > +
> > +1. cpufreq_freq_test.sh
> > +
> > +Description:
> > +------------
> > +This test is supposed to test if cpufreq attributes exported by
> > sysfs are
> 
> s/test/script would be better

Yes, you are right.

> 
> > +exposing a correct values.
> 
> s/ exposing a correct values / exposing correct values
> 
> > +
> > +It can work with or without boost enabled and helps spotting
> > errors related to
> 
> s/ helps spotting / helps in spotting
> 

Thanks for feedback.

> <snip>
> 
> > +
> > +set +x
> > +
> > +COLOUR_RED="\33[31m"
> > +COLOUR_BLUE="\33[34m"
> > +COLOUR_GREEN="\33[32m"
> > +COLOUR_DEFAULT="\33[0m"
> > +
> > +T_PATCH=/sys/devices/system/cpu/cpu0/cpufreq
> 
> Shouldn't this be called PATH instead of PATCH?

Hmm.... It really should be PATH :-).

> 
> > +BOOST_PATCH=/sys/devices/system/cpu/cpufreq
> 
> ditto and rest of the places in the document.
> 

Ok, I will correct that.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
