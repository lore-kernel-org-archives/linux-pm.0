From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] cpufreq: ARM big LITTLE: Add generic cpufreq driver and
 its DT glue
Date: Wed, 6 Mar 2013 17:50:20 -0800
Message-ID: <CAOesGMiOBxEHVgkr=K_4JVQ6+0Swy1uRmHaS8QwRxTJKs3J2Ow@mail.gmail.com>
References: <f20e3c5e822c4bd28a3b71264d73143cc1f850b0.1362458878.git.viresh.kumar@linaro.org>
	<20130307014657.GA7426@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:45749 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab3CGBuV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Mar 2013 20:50:21 -0500
Received: by mail-ie0-f178.google.com with SMTP id c13so10229038ieb.23
        for <linux-pm@vger.kernel.org>; Wed, 06 Mar 2013 17:50:20 -0800 (PST)
In-Reply-To: <20130307014657.GA7426@quad.lixom.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, linaro-kernel@lists.linaro.org, mark.hambleton@broadcom.com, linux-arm-kernel@lists.infradead.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

On Wed, Mar 6, 2013 at 5:46 PM, Olof Johansson <olof@lixom.net> wrote:

> This binding makes no sense to me. It needs to be substantially better
> documented, not just a couple of sentences that people that understand
> bit.LITTLE thoroughly can make sense of.
>
> It also duplicates the cpu binding. I suspect this should instead be done
> through additions of the cpu bindings instead of duplication. So this needs to
> be substantially reworked.

Also, _ALWAYS_ cc devicetree-discuss on new bindings. get_maintainer
tells you to do so.


-Olof
