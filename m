From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] PM / OPP: discard duplicate OPPs
Date: Tue, 20 May 2014 19:06:29 +0530
Message-ID: <CAKohpokwBK5gMU30CrN8KymyoMsDY-XtWU1vH6x927qqn9YCkQ@mail.gmail.com>
References: <1400230809-11401-1-git-send-email-chander.kashyap@linaro.org>
	<537A0247.1030503@ti.com>
	<CAKohpoknoFuz8qnDpunA7oxr5E_18=+EQsFEy0P39fcU=4Ps9w@mail.gmail.com>
	<CAGo_u6o+Vysq0LkdFTrP82WOpS1TT-=MD+zgP+Q_L=3RV8x5hA@mail.gmail.com>
	<CAKohponAx=Hi_Ywgg4hXxrpmmaqy5=pYnb3nSBNUP3KtADTEeA@mail.gmail.com>
	<CAKohpomKvPcioNmfzvx7vqJHqs_TrhnHH6yYb5w_0f+YvA5hvA@mail.gmail.com>
	<CAGo_u6pJ0n5Z1-aXdGfh6RNgoe=Pp_9Xaf3sDK6zss1t=qU57Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:56489 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbaETNga (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 May 2014 09:36:30 -0400
Received: by mail-oa0-f49.google.com with SMTP id eb12so505511oac.36
        for <linux-pm@vger.kernel.org>; Tue, 20 May 2014 06:36:30 -0700 (PDT)
In-Reply-To: <CAGo_u6pJ0n5Z1-aXdGfh6RNgoe=Pp_9Xaf3sDK6zss1t=qU57Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Chander Kashyap <chander.kashyap@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>

On 20 May 2014 18:02, Nishanth Menon <nm@ti.com> wrote:
>> +               if (new_opp->u_volt == opp->u_volt)
>> +                       ret = -EEXIST;

As I mentioned in the other mail in same thread, I screwed up
again. I meant a s/==/!= here..

In words:
- If we are adding duplicate OPPs (both freq/volt same), return 0 as
we already have that.
- if we are adding OPPs with same key (same freq, diff volt), return
-EEXIST and also print both old and new values of both freq and volt.

> Else -> we now have two OPPs with the same key (same frequency, but
> different voltage) -> That does not make sense.
> Example: why would you add:
> If you already had {1GHz, 1.2V}
> and you attempted:
> {1GHz, 1.1V} (if you could do that, then you should added {1GHz, 1.1V}
> in the first place)
> OR
> {1GHz, 1.3V} (if you could do that, then you should add {1GHz, 1.3V}
> and the {1GHz, 1.2V} is wrong)

Exactly, this is why I wanted to return -EEXIST here with some prints.
