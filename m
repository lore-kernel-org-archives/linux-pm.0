From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V7 3/3] OPP: Add binding for 'opp-suspend'
Date: Tue, 16 Jun 2015 06:01:58 +0530
Message-ID: <CAKohpomTT6i0dbboK901eguCbQiBdCT6gvLvTY24ajDdY__2fg@mail.gmail.com>
References: <cover.1433434659.git.viresh.kumar@linaro.org>
	<dedf8c02fdd9dbf169f43de74ead4c1434d89b45.1433434659.git.viresh.kumar@linaro.org>
	<CAL_JsqJb4P2Z2esgm5ffjWV37MU2KUF4gBdUpwSV8+21iTD1Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqJb4P2Z2esgm5ffjWV37MU2KUF4gBdUpwSV8+21iTD1Bg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mike Turquette <mike.turquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Viswanath Puttagunta <viswanath.puttagunta-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Thomas Abraham <ta.omasab-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Abhilash Kesavan <kesavan.abhilash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Santosh
List-Id: linux-pm@vger.kernel.org

On 16 June 2015 at 05:05, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> +- opp-suspend: Phandle of the OPP to set while device is suspended.
>> +
>
> I would just do a bool property in the OPP you want.

I will do that if you want, no big deal.

But I would like to explain why I did it this way. Nishanth asked the same
thing earlier and now he looks convinced :)

There can only be one OPP that can be selected during suspend. Allowing
more than one OPP to select this property doesn't look like the right thing
to me. In that case we have to make a rule that the first OPP in the table
will be selected or error out in that case.

And I thought that this is property of the table, instead of each OPP. For
example, in code this will waste lots of space if we choose such a field
in individual OPPs, and we will always keep it in the OPP-table thing..

But then this is DT :)

I will wait for your reply Rob on this, and then will send an update. Thanks.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
