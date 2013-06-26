From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 1/7] cpufreq: Store cpufreq policies in a list
Date: Wed, 26 Jun 2013 16:38:15 +0530
Message-ID: <CAKohpo=aaJyhZ1U2W=DUyi8wGH=rLCL47SBSO7TgsxHXamdotA@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1371661969-7660-1-git-send-email-l.majewski@samsung.com>
	<1371661969-7660-2-git-send-email-l.majewski@samsung.com>
	<CAKohpomStuSGyQHnk9jNLpije=SAkb4zHg40zHDgLRCUQeZC1A@mail.gmail.com>
	<20130626125411.5dc935bf@amdc308.digital.local>
	<CAKohpom1yJOAVZ1XE+Q+dtrZM1N6Zqd7DjURSA_f2fhQ1OiCJA@mail.gmail.com>
	<20130626130407.021c05cb@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:65157 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab3FZLIP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 07:08:15 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so13014583obb.8
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2013 04:08:15 -0700 (PDT)
In-Reply-To: <20130626130407.021c05cb@amdc308.digital.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, t.figa@samsung.com

On 26 June 2013 16:34, Lukasz Majewski <l.majewski@samsung.com> wrote:
> err_out_kobj_put:
>         list_del(&cpufreq_policy_list);
>         [rest of error path]

I couldn't find err_out_kobj_put in existing code :)

BTW, just add to the list only once everything passed.
