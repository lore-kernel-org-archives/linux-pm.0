From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] PM/domains: add delayed power off capability
Date: Fri, 22 Mar 2013 09:58:04 -0700
Message-ID: <87obebe5ib.fsf@linaro.org>
References: <1363078159-17571-1-git-send-email-mkulkarni@nvidia.com>
	<20130312134913.GD3514@kroah.com> <513F4208.4040207@nvidia.com>
	<87zjy7m77d.fsf@linaro.org>
	<20130314085916.GC18519@tbergstrom-lnx.Nvidia.com>
	<5141DABF.9050002@nvidia.com> <87vc8sk09p.fsf@linaro.org>
	<20130318100714.GL18519@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f44.google.com ([209.85.210.44]:45870 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1160998Ab3CVQ6I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 12:58:08 -0400
Received: by mail-da0-f44.google.com with SMTP id z20so2384599dae.3
        for <linux-pm@vger.kernel.org>; Fri, 22 Mar 2013 09:58:08 -0700 (PDT)
In-Reply-To: <20130318100714.GL18519@tbergstrom-lnx.Nvidia.com> (Peter De
	Schrijver's message of "Mon, 18 Mar 2013 12:07:14 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Mayuresh Kulkarni <mkulkarni@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "rjw@sisk.pl" <rjw@sisk.pl>

Peter De Schrijver <pdeschrijver@nvidia.com> writes:

>> > - If such a domain is going to be needed very soon in future, it makes
>> > sense to avoid its power down for at-least that much amount of time
>> > (which is what the proposed patch does).
>> 
>> ...and is also what the pluggable governors inside genpd are meant to
>> allow you to do.
>> 
>
> Unfortunately this is rather akward to implement in a genpd governor. The
> governor only gets called when the genpd core wants to power off a domain.
> It can then say yes or no. You could start a timer and on expiry call into
> genpd and use a flag to indicate to the governor (which will be called
> again), it should now allow the power off.
>
>> More specifically, what you said above: "if such a domain is going to be
>> needed very soon in the future" is just another way of saying it there
>> is a wakeup latency constraint.   Wakeup latency constratints are
>> handled by per-device PM QoS, which can be queried by a governor
>> associated with a genpd.
>
> No. This is not a wakeup latency constraint but rather an energy breakeven
> point constraint.

OK, that makes more sense, but the way it was described in the
changelog, it sounded like a wakeup latency constraint.

Speaking of the changelog, I would suggest it be updated to describe why
the other methods proposed here would not work.

Kevin

