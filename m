From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 8/9] spark: cpufreq: move cpufreq driver to drivers/cpufreq
Date: Tue, 26 Mar 2013 07:30:03 +0530
Message-ID: <CAKohpomnOaVG1xktDL=YGz6yM2vFoYVF2Un-9_zL7owiJVG6gw@mail.gmail.com>
References: <cover.1364229828.git.viresh.kumar@linaro.org>
	<2641a3f059f1698ee6825c7b6bfe25a3937e1474.1364229828.git.viresh.kumar@linaro.org>
	<20130325.130745.670476511400589185.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:42468 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759192Ab3CZCAE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 22:00:04 -0400
Received: by mail-ob0-f178.google.com with SMTP id wd20so6725260obb.9
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2013 19:00:03 -0700 (PDT)
In-Reply-To: <20130325.130745.670476511400589185.davem@davemloft.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: rjw@sisk.pl, arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org, sparclinux@vger.kernel.org

On 25 March 2013 22:37, David Miller <davem@davemloft.net> wrote:
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Mon, 25 Mar 2013 22:24:44 +0530
>
>> This patch moves cpufreq driver of SPARK architecture to drivers/cpufreq.
>
> I don't know what spark is.

:(

s/spark/sparc ...

I will fix patch in V2..
