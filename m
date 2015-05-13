From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 13 May 2015 09:24:57 -0500
Message-ID: <CAGo_u6o5nw8C3uwLGmP+kbCOG5twmXgC2ATb5Gv-dL3G-grDSg@mail.gmail.com>
References: <20150507110233.GR15510@sirena.org.uk>
	<20150507211855.GA2455@codeaurora.org>
	<20150507221842.GW22845@sirena.org.uk>
	<CAKohpomU8wm0T=A7EkosdOjXbP8q2Cb726Hsjh08KTKYjoz3-A@mail.gmail.com>
	<555000B6.2010107@ti.com>
	<20150512052033.GC32300@linux>
	<20150512190134.16410.89041@quantum>
	<5552510B.9010306@ti.com>
	<20150512194134.GC3066@sirena.org.uk>
	<55525B29.2080307@ti.com>
	<20150513115422.GQ3066@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150513115422.GQ3066-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Michael Turquette <mike.turquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Rob Herring <rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linaro Kernel Mailman List <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Viswanath Puttagunta <viswanath.puttagunta-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Thomas Abraham <ta.omasab-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Abhilash Kesavan <kesavan.abhilash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 13, 2015 at 6:54 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, May 12, 2015 at 02:57:29PM -0500, Nishanth Menon wrote:
>> On 05/12/2015 02:41 PM, Mark Brown wrote:
>> > On Tue, May 12, 2015 at 02:14:19PM -0500, Nishanth Menon wrote:
>
>> > specifying the currents involved.  For plausible applications these are
>> > likely to be ballpark figures rather than anything too accurate - if
>> > nothing else the instantaneous current draw normally varies very
>> > substantially so realistically you're talking about a maximum here.  If
>> > the corners vary that dramatically then I'd expect you'd see different
>> > OPP tables being used anyway.
>
>> OK - If we state "worst case", then it is quantifiable (if SoC vendors
>> would like to expose such information - I doubt mine ever will ;) ).
>> - We might be able to quantify it better by stating worst case(under
>> maximum load) steady state current (to avoid including transient
>> spikes which are never representative) at ambient temperature(25C).
>
> Qualcomm do.  It kind of depends on the system how worst case it needs
> to be - it'll depend on the expected performance of both the system and
> potentially the regulator.  For some systems it may be important to have
> some accounting for transients.  Equally systems would only need to be
> as accurate as the underlying hardware was able to make use of.

True, some parts of the system like choice in regulator sizing has to account
for transients.

How about rephrasing as following:

- opp-microamp: The maximum current drawn by the device in microamperes
  considering system specific parameters (such as transients, process,
aging, etc.)
  as necessary,  at an  ambient temperature of 25C. This may be used to set
  the most efficient regulator operating mode.

  Valid only if opp-microvolt is set for the OPP.

  Entries for multiple regulators must be present in the same order as
  regulators are specified in device's DT node. If this property isn't required
  for few regulators, then this should be marked as zero for them. If it isn't
  required for any regulator, then this property need not be present.


---
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
