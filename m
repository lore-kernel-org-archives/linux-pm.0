From: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for power-domains
Date: Sun, 23 Apr 2017 15:07:10 -0700
Message-ID: <m2r30i4w35.fsf@baylibre.com>
References: <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
        <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
        <20170413053736.GM5910@vireshk-i7>
        <3adbef6a-7b43-528f-e88f-c2121d30a5d3@arm.com>
        <20170417052758.GF28191@vireshk-i7>
        <95aa4b97-4e1a-13bb-f4d8-982b778012ba@arm.com>
        <20170419114740.GD5436@vireshk-i7>
        <9dee7c0d-e5f4-9fcd-3c92-bf7ec9d43a3b@arm.com>
        <20170420052533.GF5436@vireshk-i7>
        <34c7fb69-0324-ad06-678d-8726064e9a18@arm.com>
        <20170420095248.GJ5436@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170420095248.GJ5436@vireshk-i7> (Viresh Kumar's message of
        "Thu, 20 Apr 2017 15:22:48 +0530")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> On 20-04-17, 10:43, Sudeep Holla wrote:
>> Just that the term performance is closely related to frequency, it needs
>> to be explicit on what *exactly* it means. As it stands now,
>> it can be used for OPP as I explain which controls both but as you
>> clarify that's not what it's designed for.
>
> We are talking about active states of a power domain here and
> *performance* is the best word I got.
>
> And yes we can still have
> frequency as a configurable here, just that current platforms don't
> have it.

It's not that your platforms don't have frequency, it's just that it's
hidden by firmware on an M3 in your particular case.

DT is meant to model hardware, and surely what the M3 is managing is
frequency and/or voltage (IOW, an OPP).

The way I see it, the problem you're trying to solve is complicated just
because you don't know the exat freq and/or voltage because they are
hiddent behind the firware, and all you have control over is an index.  

What if you drop the introduction of the new domain-performance-state
and just stick with OPPs (and phandles to them), and for cases where you
don't know the exact freq/volage pairs, just use indexes and comment
what they refer to:

operating-points = <
	/*
         * NOTE: actual frequency and voltages are managed by
         * firmware and are hidden from HLOS, so we simply use index
         * here to select the OPP
         */
        1 1
	2 2
	3 3
>;

Since selecting the OPP is up to the power-domain driver implementation,
this should be fine, IMO.

This would mean just updating the doc to reflect the "relaxing" of these
fields to reflect indexes in cases where the exact freq/voltages are not
known.

IMO, this would be much simpler, as it avoids adding a new property and
continues to use teriminology that people are already familiar with
around OPPs.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
