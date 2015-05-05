From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Tue, 5 May 2015 16:18:59 +0530
Message-ID: <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
	<d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
	<20150504121209.GM15510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36312 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbbEEKs7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2015 06:48:59 -0400
Received: by obbkp3 with SMTP id kp3so77952461obb.3
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2015 03:48:59 -0700 (PDT)
In-Reply-To: <20150504121209.GM15510@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Nishanth Menon <nm@ti.com>, Mike Turquette <mike.turquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>, santosh

On 4 May 2015 at 17:42, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Apr 30, 2015 at 05:37:59PM +0530, Viresh Kumar wrote:
>
>> +- opp-microamp: current in micro Amperes. It can contain entries for multiple
>> +  regulators.
>> +
>> +  A single regulator's current is specified with an array of size one or three.
>> +  Single entry is for target current and three entries are for <target min max>
>> +  currents.
>
> What is this for - are you trying to define OPPs for current regulators?
> If you are that's worrying, I can't think of a sensible use case.  If
> that's not what's happening then the binding needs to be more specific
> about what this is supposed to mean.

Its another property of the same voltage regulator we are using in
opp-microvolt.
I hope that makes sense ?

And that's why I wrote this as well:

+  Entries for multiple regulators must be present in the same order as
+  regulators are specified in device's DT node. If few regulators don't provide
+  capability to configure current, then values for then should be marked as
+  zero.

i.e. this is optional but the voltage regulator isn't..

But, perhaps I need to write it with more clarity? Or this field doesn't make
sense ?

FWIW, its an outcome of this request from Stephen:

https://www.marc.info/?l=linux-arm-kernel&m=142370250522589&w=3
