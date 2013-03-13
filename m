From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] PM/domains: add delayed power off capability
Date: Wed, 13 Mar 2013 12:27:02 -0700
Message-ID: <87zjy7m77d.fsf@linaro.org>
References: <1363078159-17571-1-git-send-email-mkulkarni@nvidia.com>
	<20130312134913.GD3514@kroah.com> <513F4208.4040207@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f47.google.com ([209.85.210.47]:40141 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933096Ab3CMT1H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Mar 2013 15:27:07 -0400
Received: by mail-da0-f47.google.com with SMTP id s35so554488dak.20
        for <linux-pm@vger.kernel.org>; Wed, 13 Mar 2013 12:27:06 -0700 (PDT)
In-Reply-To: <513F4208.4040207@nvidia.com> (Mayuresh Kulkarni's message of
	"Tue, 12 Mar 2013 20:26:08 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mayuresh Kulkarni <mkulkarni@nvidia.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "rjw@sisk.pl" <rjw@sisk.pl>, Peter De Schrijver <pdeschrijver@nvidia.com>

Mayuresh Kulkarni <mkulkarni@nvidia.com> writes:

> On Tuesday 12 March 2013 07:19 PM, Greg KH wrote:
>> On Tue, Mar 12, 2013 at 02:19:19PM +0530, Mayuresh Kulkarni wrote:
>>> - this commit adds a capability to delay the powering off
>>> of the domain
>>
>> Why?
>>
>
> - As I mentioned below (sorry for mentioning below rather than at
> start), powering off a domain means the context save needs to be done
> && it needs to be restored during power on.
> - It often observed that saving and restoring of context is expensive
> in terms of power consumed as well as overall system response.

Are you talking about per-device context save/restore?

Your drivers should be using runtime PM, which has an autosuspend
timeout feature.  Using autosuspend on any device in the power domain
will have the same effect as this proposed patch.  

Using runtime PM to target specific devices that have expensive
save/restore paths is also more understandable and maintainable IMO,
because the "fix" is targetted.

If instead you're talking about CPU context/save restore, you should be
coupling the powerdomain with CPUidle (genpd provides this for you) and
having the C-state latency/threshold values set properly so CPUidle will
not pick those states.

If instead, you're talking about per-powerdomain QoS, the genpd code
also provides pluggable governors based on per-device PM QoS that can be
used for making decisions about whether or not to actually cut power.

IOW, I'm not sure about exactly which problem you're trying to solve
since it's not described very thoroughly, but I'm pretty sure one of the
existing solutions should be used instead.

Kevin
