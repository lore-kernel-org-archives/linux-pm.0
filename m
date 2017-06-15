From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v15 2/7] power: add power sequence library
Date: Thu, 15 Jun 2017 10:11:45 +0200
Message-ID: <CAPDyKFpc8GRKK8bafMU_HPaqWNrger3grPSd5rWWCTYhUGHZLA@mail.gmail.com>
References: <1497319166-17287-1-git-send-email-peter.chen@nxp.com>
 <1497319166-17287-3-git-send-email-peter.chen@nxp.com> <CAPDyKFpOQWTPpdd__OBP1DcW58CbqnygGAOxiEFq5kqqvCm0QA@mail.gmail.com>
 <20170614015338.GA4635@b29397-desktop> <CAPDyKFrLL10TY1JZAhF44_0+qGETLNtFc6ujKVUu7Ay=O8+M5A@mail.gmail.com>
 <20170615065854.GA24157@b29397-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:32940 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752445AbdFOILr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Jun 2017 04:11:47 -0400
Received: by mail-qt0-f177.google.com with SMTP id u12so10245471qth.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Jun 2017 01:11:46 -0700 (PDT)
In-Reply-To: <20170615065854.GA24157@b29397-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Peter Chen <peter.chen@nxp.com>, Mark Rutland <mark.rutland@arm.com>, Heiko Stuebner <heiko@sntech.de>, Stephen Boyd <stephen.boyd@linaro.org>, frank.li@nxp.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gary Bisson <gary.bisson@boundarydevices.com>, Fabio Estevam <festevam@gmail.com>, Joshua Clayton <stillcompiling@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, mka@chromium.org, Alan Stern <stern@rowland.harvard.edu>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.>

On 15 June 2017 at 08:58, Peter Chen <hzpeterchen@gmail.com> wrote:
> On Wed, Jun 14, 2017 at 10:53:29AM +0200, Ulf Hansson wrote:
>> On 14 June 2017 at 03:53, Peter Chen <hzpeterchen@gmail.com> wrote:
>> > On Tue, Jun 13, 2017 at 12:24:42PM +0200, Ulf Hansson wrote:
>> >> [...]
>> >>
>> >> > +
>> >> > +/**
>> >> > + * of_pwrseq_on - Carry out power sequence on for device node
>> >> > + *
>> >> > + * @np: the device node would like to power on
>> >> > + *
>> >> > + * Carry out a single device power on.  If multiple devices
>> >> > + * need to be handled, use of_pwrseq_on_list() instead.
>> >> > + *
>> >> > + * Return a pointer to the power sequence instance on success,
>> >> > + * or an error code otherwise.
>> >> > + */
>> >> > +struct pwrseq *of_pwrseq_on(struct device_node *np)
>> >> > +{
>> >> > +       struct pwrseq *pwrseq;
>> >> > +       int ret;
>> >> > +
>> >> > +       pwrseq = pwrseq_find_available_instance(np);
>> >> > +       if (!pwrseq)
>> >> > +               return ERR_PTR(-ENOENT);
>> >>
>> >> In case the pwrseq instance hasn't been registered yet, then there is
>> >> no way to deal with -EPROBE_DEFER properly here.
>> >>
>> >> I haven't been following the discussions in-depth during all
>> >> iterations, so perhaps you have already discussed why doing it like
>> >> this.
>> >
>> > Yes, it has been discussed. In order to compare with compatible string
>> > at dts, we need to have one registered pwrseq instance for each
>> > pwrseq library, this pre-registered one is allocated using
>> > postcore_initcall, and the new (eg, second) instance is registered
>> > after pwrseq_get has succeeded.
>>
>> I understand you need one compatible per pwrseq library, but how does
>> that have anything to do with -EPROBE_DEFER?
>>
>> My point is that, if a driver calls of_pwrseq_on() (which calls
>> pwrseq_find_available_instance()), but the corresponding pwrseq
>> library and instance has not yet been registered for that device. Then
>> how will you handle -EPROBE_DEFER? I guess you simply can't, which is
>> why *all* pwrseq libraries needs to be registered in early boot phase,
>> like at postcore_initcall(). Right?
>>
>> If that is the case, I really don't like it.
>>
>
> Yes, you are right. This is the limitation for this power sequence
> library, the registration for the 1st power sequence instance must
> be finished before device driver uses it. I am appreciated that
> you can supply some suggestions for it.

In general this kind of problems is solved by first parsing the DTB,
which means you will find out whether there is a resource (a pwrseq)
required for the device. Then you try to fetch that resource, and if
that fails, it means the resource is not yet available, and hence you
want to retry later and should return -EPROBE_DEFER.

In this case, of_pwrseq_on() needs to be converted to start looking
for a pwrseq compatible in it's child node - I guess. Then if that is
found, you try to fetch the instance of the corresponding library.
Failing to fetch the library instance should then cause a return
-EPROBE_DEFER.

>
>> Moreover, I have found yet another severe problem but reviewing the code:
>> In the struct pwrseq, you have a "bool used", which you are setting to
>> "true" once the pwrseq has been hooked up with the device, when a
>> driver calls of_pwrseq_on(). Setting that variable to true, will also
>> prevent another driver from using the same instance of the pwrseq for
>> its device. So, to cope with multiple users, you register a new
>> instance of the same pwrseq library that got hooked up, once the
>> ->get() callback is about to complete.
>>
>> The problem the occurs, when there is another driver calling
>> of_pwrseq_on() in between, meaning that the new instance has not yet
>> been registered. This will simply fail, won't it?
>
> Yes, you are right, thanks for pointing that, I will add mutex_lock for
> of_pwrseq_on.

Another option is to entirely skip to two step approach.

In other words, make the library to cope with multiple users via the
same registered library instance.

[...]

Kind regards
Uffe
