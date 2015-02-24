From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/7] OPP: Redefine bindings to overcome shortcomings
Date: Tue, 24 Feb 2015 09:54:59 +0530
Message-ID: <CAKohpo=CRkJTkp2FXgYNwd2eEtMVRFuwJ=GPtX7+9WnQD6CK2Q@mail.gmail.com>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
	<be795ef7ec98669bc5aa90ec426a1ec1fbc32b6c.1423642246.git.viresh.kumar@linaro.org>
	<7ha904b6hp.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:52374 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbbBXEZA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Feb 2015 23:25:00 -0500
Received: by mail-oi0-f50.google.com with SMTP id v1so17418321oia.9
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2015 20:24:59 -0800 (PST)
In-Reply-To: <7ha904b6hp.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Rob Herring <rob.herring@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, Rafael Wysocki <rjw@rjwysocki.net>, "olof@lixom.net" <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Mike Turquette <mike.turquette@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Grant Likely <grant.likely@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lucas Stach <l.stach@pengutronix.de>

On 24 February 2015 at 04:06, Kevin Hilman <khilman@kernel.org> wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:

>> +Optional properties:
>> +- shared-opp: Indicates that device nodes using this OPP descriptor's phandle
>> +  switch their DVFS state together, i.e. they share clock lines.
>
> ... or shared voltage rail?

The point is that they switch their frequencies together. Which means,
sharing voltage
rail + PLLs .. How do we write it properly ?

>> +  Missing property means devices have independent clock lines, but they share OPPs.
>
> huh?  missing 'shared-opp' property means they share OPPs?  -ECONFUSED.

Right. s/OPPs/OPP tables ..

Makes sense now ?

> Maybe I missed some of the discussion of why this property is needed,
> but I'm left wondering why it's needed explicitly.  With the OPPs as

So that same OPP tables can be shared across CPUs which don't share
voltage rails..
For example, Krait. We only need to define single set of tables and
all CPUs will point
to it. But this property would be missing in that case as CPUs don't
change their DVFS
state together.

> part of the CPU nodes, shouldnt' the "shared" nature of the OPP be
> easily derived from the clock and or regulator (opp-supply) property of
> the CPU nodes?  IOW, if two CPU nodes share a clock and/or a regulator,
> the framework should know it's "shared".

So you missed all earlier discussions :), there were lots of concerns
around that.
And the best solution we found out is to do it this way..

- There can be multiple clocks/regulators present in CPU's DT node and
that makes
it complex.
- There are cases where immediate clock parents of CPUs are different
but somewhere
higher in the hierarchy they have a common ancestor, which is
responsible for rate
change. And so it would be difficult to find out if they share
clock/regulator or not..
- People wanted it to be some static data instead of trying to find
with help of some
algorithms..

> Or, were there other reasons besides clocks/regulators why this property
> was needed (if so, the documentation doesn't describe them.)

I am not sure if we need to mention anything else.. But yes, please let me know
if it can be improved a bit.
