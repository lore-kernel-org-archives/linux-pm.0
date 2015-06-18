From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3] PM / Domains: Remove intermediate states from the
 power off sequence
Date: Thu, 18 Jun 2015 09:02:10 +0200
Message-ID: <CAPDyKFp4Bh2C5PNNJS3bUqDLADS6MKTfH8UCzbm3c-ofbVOWow@mail.gmail.com>
References: <1434020737-13354-1-git-send-email-ulf.hansson@linaro.org>
	<20150617200346.GC23268@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:34345 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbbFRHCL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2015 03:02:11 -0400
Received: by qcwx2 with SMTP id x2so21027776qcw.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2015 00:02:10 -0700 (PDT)
In-Reply-To: <20150617200346.GC23268@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Axel Haslam <ahaslam+renesas@baylibre.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

[...]

>> @@ -671,32 +475,29 @@ static int pm_genpd_runtime_suspend(struct device
>> *dev)
>>         if (IS_ERR(genpd))
>>                 return -EINVAL;
>>
>> +       /*
>> +        * We can't allow to power off the PM domain if it holds an
>> irq_safe
>> +        * device. That's because we use mutexes to protect data while
>> power
>> +        * off and on the PM domain, thus we can't execute in atomic
>> context.
>> +        */
>> +       if (dev->power.irq_safe)
>> +               return -EBUSY;
>> +
>
> This check will prevent the device from being saved/stopped. This should
> be allowed. Its the mutex_lock(&genpd->lock) below that would be a
> problem, if the device is IRQ safe. But that happens only after the
> device is stopped.

Yes, as we discussed around your patch in [1].

Earlier we could invoke the ->stop|start() callbacks for an IRQ
safe device. This version of $subject patch prevents that.

I am working on a v4, that brings back that functionality, but we can
actually do more. As from the changes in $subject patch, we don't need
to hold the mutex while invoking the runtime PM callbacks for a
device. This enables us to invoke them for IRQ safe devices, yet
another positive side effect.

>
> I am inclined to think that the existing check below is the correct
> place to check. Let me know if I am missing something.
>

You are correct.

Still, as I intend to invoke the runtime PM callbacks for IRQ safe
devices some minor change is also needed in pm_genpd_runtime_resume().

[...]

Kind regards
Uffe

[1]
http://www.spinics.net/lists/arm-kernel/msg425162.html
