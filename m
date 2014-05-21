From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5] PM/OPP: discard duplicate OPPs
Date: Wed, 21 May 2014 09:33:42 +0530
Message-ID: <CAKohponU2feK9+9sUn4tu0t4fhwSy6PZuaAO3zkF7qRejCwM1Q@mail.gmail.com>
References: <7cb6e0e039e0935e37c81d0f23d26b0b81ad8cda.1400597170.git.viresh.kumar@linaro.org>
	<1555967.8fxByr2j83@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:41904 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaEUEDn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 May 2014 00:03:43 -0400
Received: by mail-oa0-f52.google.com with SMTP id eb12so1624827oac.11
        for <linux-pm@vger.kernel.org>; Tue, 20 May 2014 21:03:42 -0700 (PDT)
In-Reply-To: <1555967.8fxByr2j83@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Ips Gandhi <inderpal.s@samsung.com>, Nishanth Menon <nm@ti.com>, Chander Kashyap <chander.kashyap@linaro.org>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Chander Kashyap <k.chander@samsung.com>

On 21 May 2014 02:39, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> +     /* Duplicate OPPs ? */
>> +     if (new_opp->rate == opp->rate) {
>> +             int ret = (new_opp->u_volt == opp->u_volt) && opp->available ?
>> +                     0 : -EEXIST;
>
> The parens are not necessary.  And is the direction correct?

What do you mean by direction here ?
