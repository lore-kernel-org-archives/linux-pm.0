From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_=5BPATCH=5D_cpufreq=3A_sirf_=3A_Add_cpufreq_for_?=
	=?UTF-8?Q?SiRFprimaII_and_SiRFatlasVI?=
Date: Tue, 5 Nov 2013 14:29:14 +0530
Message-ID: <CAKohpomfAxcqLX1t9SQmtviE-2-VM2C9aSVN4dCBXXsFusE9FA@mail.gmail.com>
References: <1381030393-10452-1-git-send-email-Baohua.Song@csr.com>
	<CAKohpok8GvukpTMyscjhn17UbcNSYpEzVMfv4JNg1Us=Gx39cg@mail.gmail.com>
	<86130EF012BDF348AA0D464A4F449478012953F474@SHAASIEXM01.ASIA.ROOT.PRI>
	<CAKohpomCm86CtZGDiELen63_xnAbFtrqNmfugH94e+n5HeshQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:34561 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671Ab3KEI7P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2013 03:59:15 -0500
Received: by mail-oa0-f53.google.com with SMTP id j17so252950oag.26
        for <linux-pm@vger.kernel.org>; Tue, 05 Nov 2013 00:59:15 -0800 (PST)
In-Reply-To: <CAKohpomCm86CtZGDiELen63_xnAbFtrqNmfugH94e+n5HeshQA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rongjun Ying <Rongjun.Ying@csr.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: Barry Song <21cnbao@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Barry Song <Barry.Song@csr.com>

Trying to send again, it bounced for some reason from lists..

On 5 November 2013 14:26, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 28 October 2013 15:53, Rongjun Ying <Rongjun.Ying@csr.com> wrote:
>>> Viresh Kumar [mailto:viresh.kumar@linaro.org]
>
>>> Any particular reason why you aren't reusing cpufreq-cpu0 ?? I can't see any
>>> special stuff in this driver, that can't be handled by cpu0..
>
>> I tried to use the cpufreq-cpu0, But I found the regulator can't work  correct. Our regulator ic only supply 1.035V(min) and 1.150V(max) voltage which use a gpio pin to control it.
>> But our SoC need 1.025V(200MHz or 400MHz), 1.050V(600MHz) and 1.150V(800MHz).
>> So I can't set a voltage-tolerance value to get a appropriate voltage tolerance pair.
>> For exsample:
>> If I set voltage-tolerance to 1.
>> Freqs           need-voltage            min-voltage             max-voltate             set to
>> 800MHz          1.150V                  1.1385V                 1.1615V                 1.15V
>> 600MHz          1.050V                  1.0395V                 1.0605V                 Can't set, this case can set to 1.150V
>> Set other voltage-tolerance value, the same situation would happen.
>>
>> So I propose use a voltage-max instead of voltage-tolerance and replace regulator_set_voltage_tol to regulator_set_voltage(regulatrer, min_uV, voltage_max);
>
> @Shawn: Can you provide your inputs here?
