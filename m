From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/4] CPUFreq: Implement per policy instances of governors
Date: Tue, 5 Feb 2013 15:06:12 +0530
Message-ID: <CAKohpokejWugM+wP5xcqp0F9AggLxuEf9Ox5fDViMxJh1c+kEw@mail.gmail.com>
References: <cover.1359976493.git.viresh.kumar@linaro.org>
	<5808458.pvV2iHpBWm@vostro.rjw.lan>
	<CAKohpok7RiJ_HKGi3r0vU26kNEtFKq==pMMoshT6Z2yy9ghemA@mail.gmail.com>
	<20130204123221.GA22340@pd.tnic>
	<CAKohpomcrtV3i9fL4zV6Mt0uDza-9pHTOsqTe2=C1t6mE6cpCQ@mail.gmail.com>
	<20130204130403.GD13909@pd.tnic>
	<CAKohpokuFC5gnTFcD3+RH3p5XaW8vBtyfq+Kej=d2J8tERdmoQ@mail.gmail.com>
	<20130204133648.GE13909@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:46197 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930Ab3BEJgN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Feb 2013 04:36:13 -0500
Received: by mail-ob0-f181.google.com with SMTP id ni5so7311723obc.26
        for <linux-pm@vger.kernel.org>; Tue, 05 Feb 2013 01:36:12 -0800 (PST)
In-Reply-To: <20130204133648.GE13909@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>

On 4 February 2013 19:06, Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Feb 04, 2013 at 06:55:25PM +0530, Viresh Kumar wrote:

>> Its not only for multicluster system, but a system where multiple cpus
>> have separate clock control and hence multiple policy structures.
>
> What are those systems? Examples?

Qualcomm's ARM based "krait". Currently shipping in millions of Android
phones.

http://en.wikipedia.org/wiki/Krait_(CPU)

Thanks Charles for pointing it out, I knew there is one :)

--
viresh
