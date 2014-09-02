From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: ppc-corenet: remove duplicate update of cpu_data
Date: Tue, 2 Sep 2014 12:17:53 +0530
Message-ID: <CAKohpo=iKBaxtDOfuFqHO00ZUzeFzze_VNTtimq30cKPh2T82Q@mail.gmail.com>
References: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
	<b0603621f8104a16a5e407d30a86634b@BY2PR03MB570.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:42581 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbaIBGry (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Sep 2014 02:47:54 -0400
Received: by mail-oa0-f51.google.com with SMTP id n16so4508500oag.10
        for <linux-pm@vger.kernel.org>; Mon, 01 Sep 2014 23:47:54 -0700 (PDT)
In-Reply-To: <b0603621f8104a16a5e407d30a86634b@BY2PR03MB570.namprd03.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "LeoLi@freescale.com" <LeoLi@freescale.com>, Hongtao Jia <hongtao.jia@freescale.com>

On 2 September 2014 12:08, Yuantian Tang <Yuantian.Tang@freescale.com> wrote:
> Hello Viresh:
>
> I am not sure if this is right in CPU hotplug case.

policy->cpus must have all the online CPUs and so it should work for all
online CPUs. what's your doubt?
