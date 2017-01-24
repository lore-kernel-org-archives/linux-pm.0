From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Delayed acpi frequency governor call
Date: Tue, 24 Jan 2017 09:52:35 +0530
Message-ID: <20170124042235.GA16906@vireshk-i7>
References: <c8ee7078-ad5a-0a23-66ae-620c507300e5@tik.ee.ethz.ch>
 <20170120100725.GO11478@vireshk-i7>
 <9b332b49-11a1-a5fc-d48e-2c113cdca202@tik.ee.ethz.ch>
 <20170123101145.GB26681@vireshk-i7>
 <086bc55f-d1cc-b893-49c6-1667f6067f1b@tik.ee.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32809 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdAXE2n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Jan 2017 23:28:43 -0500
Received: by mail-pf0-f173.google.com with SMTP id y143so46792552pfb.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Jan 2017 20:28:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <086bc55f-d1cc-b893-49c6-1667f6067f1b@tik.ee.ethz.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philipp Miedl <philipp.miedl@tik.ee.ethz.ch>
Cc: alex@digriz.org.uk, jun.nakajima@intel.com, venkatesh.pallipadi@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 23-01-17, 15:24, Philipp Miedl wrote:
> I would say it only checks whether the elapsed time since the last governor
> call. My question is whether the call to the governor can be delayed for
> such a long time without the CPU going into idle? If it can be guaranteed
> that the governor call cannot be delayed without the CPU going to idle than
> it is true - otherwise not.

You are using a 4.4 kernel, which used the older delayed work stuff at sampling
rate. This has all changed a lot and we hooks paired with the scheduler now to
do this instead. Things have mostly changed since 4.7. Would it be possible for
you to use a later kernel and see if you still see something wrong?

Now coming back to 4.4, the timers (in the delayed works) can't get delayed but
the work can as it is just another process. But your setup has no almost load
and that seems unlikely as well. So, it looks to be a problem at some other
place. Tracers are your friend, only those can confirm something here.

-- 
viresh
