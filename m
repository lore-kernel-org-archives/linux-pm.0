From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v15 2/7] power: add power sequence library
Date: Mon, 19 Jun 2017 10:09:58 +0200
Message-ID: <CAPDyKFrSQ7m+yUvKqB9yAMakk8pHZooboZMFdXGU6Xb=TZSGNA@mail.gmail.com>
References: <1497319166-17287-1-git-send-email-peter.chen@nxp.com>
 <1497319166-17287-3-git-send-email-peter.chen@nxp.com> <CAPDyKFpOQWTPpdd__OBP1DcW58CbqnygGAOxiEFq5kqqvCm0QA@mail.gmail.com>
 <20170614015338.GA4635@b29397-desktop> <CAPDyKFrLL10TY1JZAhF44_0+qGETLNtFc6ujKVUu7Ay=O8+M5A@mail.gmail.com>
 <20170615065854.GA24157@b29397-desktop> <CAPDyKFpc8GRKK8bafMU_HPaqWNrger3grPSd5rWWCTYhUGHZLA@mail.gmail.com>
 <20170615091131.GB24157@b29397-desktop> <CAPDyKFrZoyoYCQA1rnRbz9tmT9vJigzSb+xyTZpJjhd=5eFA5A@mail.gmail.com>
 <20170615100604.GC24157@b29397-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170615100604.GC24157@b29397-desktop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Stephen Boyd <stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, frank.li-3arQi8VN3Tc@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gary Bisson <gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Maciej S. Szmigiero" <mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TasMV2rI37PzA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 15 June 2017 at 12:06, Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Jun 15, 2017 at 11:35:20AM +0200, Ulf Hansson wrote:
>> On 15 June 2017 at 11:11, Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > On Thu, Jun 15, 2017 at 10:11:45AM +0200, Ulf Hansson wrote:
>> >> > Yes, you are right. This is the limitation for this power sequence
>> >> > library, the registration for the 1st power sequence instance must
>> >> > be finished before device driver uses it. I am appreciated that
>> >> > you can supply some suggestions for it.
>> >>
>> >> In general this kind of problems is solved by first parsing the DTB,
>> >> which means you will find out whether there is a resource (a pwrseq)
>> >> required for the device. Then you try to fetch that resource, and if
>> >> that fails, it means the resource is not yet available, and hence you
>> >> want to retry later and should return -EPROBE_DEFER.
>> >>
>> >> In this case, of_pwrseq_on() needs to be converted to start looking
>> >> for a pwrseq compatible in it's child node - I guess. Then if that is
>> >> found, you try to fetch the instance of the corresponding library.
>> >> Failing to fetch the library instance should then cause a return
>> >> -EPROBE_DEFER.
>> >
>> > The most difficulty for this is we can't know whether the requested
>> > pwrseq instance will be registered or not, the kernel configuration
>> > for this pwrseq library may not be chosen at all.
>>
>> In such case it is still correct to return -EPROBE_DEFER, because the
>> driver that tries to probe its device will fail unless it can run the
>> needed pwrseq. Right?
>>
>
> Unlike the MMC design, there is no dts entry to indicate whether this
> device needs pwrseq or not at this design, it will only carry out power
> on sequence after matching. So, return -EPROBE_DEFER may not work since
> this device may never need pwrseq.

Then, how will you really be able to fetch the correct pwrseq library
instance for the device node?

Suppose their is a *list* of pwrseq library instances available. In
pwrseq_find_available_instance() you call of_match_node(table, np).
The "table" there corresponds to the compatible for the pwrseq library
and the np is the device node provided by the caller of
of_pwrseq_on().

Why is this match done?

Why can't the match be done before trying to fetch a library instance
and then in a second step, really try to fetch the instance? If only
the second step fails, returning -EPROBE_DEFER can be done, no?

BTW, I didn't compatible for the generic pwrseq library being
documented in this series.

>
>> >
>> >>
>> >> >
>> >> >> Moreover, I have found yet another severe problem but reviewing the code:
>> >> >> In the struct pwrseq, you have a "bool used", which you are setting to
>> >> >> "true" once the pwrseq has been hooked up with the device, when a
>> >> >> driver calls of_pwrseq_on(). Setting that variable to true, will also
>> >> >> prevent another driver from using the same instance of the pwrseq for
>> >> >> its device. So, to cope with multiple users, you register a new
>> >> >> instance of the same pwrseq library that got hooked up, once the
>> >> >> ->get() callback is about to complete.
>> >> >>
>> >> >> The problem the occurs, when there is another driver calling
>> >> >> of_pwrseq_on() in between, meaning that the new instance has not yet
>> >> >> been registered. This will simply fail, won't it?
>> >> >
>> >> > Yes, you are right, thanks for pointing that, I will add mutex_lock for
>> >> > of_pwrseq_on.
>> >>
>> >> Another option is to entirely skip to two step approach.
>> >>
>> >> In other words, make the library to cope with multiple users via the
>> >> same registered library instance.
>> >>
>> >
>> > No, the pwrseq instance stores dtb information (clock, gpio, etc), it
>> > needs to be per device.
>>
>> I think you misunderstood my suggestion here. Of course you need to
>> allocate one pwrseq data per device.
>>
>> However, my point is that you shouldn't need more than one instance of
>> the library functions to be registered in the list of available pwrseq
>> libraries.
>>
>
> This additional instance is used to store compatible information for
> this pwrseq library, it is used for the next matching between device
> and pwrseq library, it just likes we need the first pwrseq instance
> registered at boot stage.

Why can't the compatible information be a static table, known by the
pwrseq core library?

Then when of_pwrseq_on() is called, that static table is parsed and
matched, then a corresponding pwrseq library instance tries to be
fetched.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
