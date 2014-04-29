From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: time_in_state on Ubuntu 13.10
Date: Tue, 29 Apr 2014 09:58:14 +0530
Message-ID: <CAOh2x==Q_oDn9v4S5ggh_e-3_=vSU_5Ko_89LfWM9ARBS9i=Rg@mail.gmail.com>
References: <535E6906.2090201@unine.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173]:56472 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbaD2E2P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Apr 2014 00:28:15 -0400
In-Reply-To: <535E6906.2090201@unine.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mascha Kurpicz <mascha.kurpicz@unine.ch>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Maxime Colmant <maxime.colmant@inria.fr>

On Mon, Apr 28, 2014 at 8:13 PM, Mascha Kurpicz <mascha.kurpicz@unine.ch> wrote:
> First of all I would like to thank for the cpufreq utility that I use
> regularly.
>
> Unfortunately, when upgrading our systems from Ubuntu 12.04 to 13.10, we
> are encountering some issues with the data in
> /sys/devices/system/cpu/cpu*/cpufreq/stats/time_in_state.
>
> On some of the machines, the values are all set to 0 [1], whereas on
> other machines, values are 0 or very small [2]. In both cases, the
> output of cpufreq-info for the cpufreq stats is not correct. When
> running Ubuntu 12.04, we get reasonable values.
>
> We noticed this behavior on Intel i3 machines, and on Intel Xeon. Kernel
> version in all cases is 3.11.0-20-generic.

Do you mean that kernel version is same for 12.04 and 13.10? We need
kernel versions for these two bases.
