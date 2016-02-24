From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Wed, 24 Feb 2016 21:05:46 +0100
Message-ID: <CAJZ5v0hh20C3vgWfBpRmR+oOjOf7kqP6HMLKjqzYx8h0ka_dVQ@mail.gmail.com>
References: <1443738317-4224-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<20151007172343.GE4557@linux>
	<4807388.hTIoZIhGRk@vostro.rjw.lan>
	<20151016054226.GQ19018@linux>
	<1456344052.8680.208.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33071 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758152AbcBXUFx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2016 15:05:53 -0500
Received: by mail-lb0-f171.google.com with SMTP id x4so17108498lbm.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2016 12:05:52 -0800 (PST)
In-Reply-To: <1456344052.8680.208.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Feb 24, 2016 at 9:00 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Fri, 2015-10-16 at 11:12 +0530, Viresh Kumar wrote:
>> On 16-10-15, 00:45, Rafael J. Wysocki wrote:
>> > We're talking about a continuous range above the base frequency
>> > here.
>>
>> Ick. No it can't be reused for the continuous range stuff.
>>
> I know this is bit old discussion. Is there any problem in applying
> this patch?

Not in principle, but can you please resubmit?

Thanks,
Rafael
