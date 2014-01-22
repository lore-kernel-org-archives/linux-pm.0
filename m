From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Align all CPUs to the same frequency if using
 shared clock
Date: Wed, 22 Jan 2014 12:13:01 +0530
Message-ID: <CAKohpokMFwvY-SMcuJf_C_gASQT-8tT8wRrQ6=YX7QQ0YwcgNg@mail.gmail.com>
References: <1390273543-18032-1-git-send-email-zhuangzhi.li@intel.com>
	<CAKohponL_R8M40BJa3X+++1yDtw5KRvk88w8kVfA+_D+poK08A@mail.gmail.com>
	<630F9443351D2B4BB7EC6BAE6B6B08342549C5DC@SHSMSX104.ccr.corp.intel.com>
	<CAKohpo=ng-B6kLdWxBn_cNsWNVsYaNAD-ZzQLLOfkbj+FDg_fg@mail.gmail.com>
	<CAKohpokHi=yuGJm2Nf-TAMVhGQ8Do02j+s6z3eenKRzoW8pv7g@mail.gmail.com>
	<630F9443351D2B4BB7EC6BAE6B6B08342549CF6A@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:64253 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbaAVGnC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2014 01:43:02 -0500
Received: by mail-oa0-f54.google.com with SMTP id i4so3769327oah.41
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2014 22:43:01 -0800 (PST)
In-Reply-To: <630F9443351D2B4BB7EC6BAE6B6B08342549CF6A@SHSMSX104.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Li, Zhuangzhi" <zhuangzhi.li@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Liu, Chuansheng" <chuansheng.liu@intel.com>

On 22 January 2014 11:56, Li, Zhuangzhi <zhuangzhi.li@intel.com> wrote:
> I don't think it's a real bug in bootloader, the bootloader can set CPUs to different frequencies according to actually requirements(Power saving first or Performance first),
> the CPUs freq policy are initialized in kernel, if the kernel want to share one CPU policy(using CPUFREQ_SHARED_TYPE_ALL type), it should ensure all CPUs frequencies aligned first,
> don't depend on the bootloader CPUs Pre-states, then the kernel can have better compatibility.
>
> If the kernel uses CPUFREQ_SHARED_TYPE_ALL policy, the patch can ensure these:
> 1. If all CPUs are in the same P-state, it does nothing when cpufreq registering
> 2. If the CPUs are in different P-states, all the other CPUs are aligned once to current frequency of CPU0 according to the present policy.

I thought, as you are asking kernel to keep same freq on all of them,
then same should be true for bootloaders.

Otherwise it was okay.
