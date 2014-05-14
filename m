From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 1/2] cpufreq / OPP: Allow boost frequency to be looked
 up from device tree
Date: Tue, 13 May 2014 23:05:17 -0500
Message-ID: <CAGo_u6p-uqw82ewDciDEhAt0=Nswfw33-gf8Aa+-6_k3eCcTzw@mail.gmail.com>
References: <1400029380-5372-1-git-send-email-thomas.ab@samsung.com>
	<1400029380-5372-2-git-send-email-thomas.ab@samsung.com>
	<CAKohponnPSRAotJUu+5a9y8j97QF8Jqgc5DA5WQnwGWCnVY-aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:42736 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbaENEFT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 May 2014 00:05:19 -0400
In-Reply-To: <CAKohponnPSRAotJUu+5a9y8j97QF8Jqgc5DA5WQnwGWCnVY-aA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Abraham <ta.omasab@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Thomas P Abraham <thomas.ab@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, May 13, 2014 at 10:40 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 14 May 2014 06:32, Thomas Abraham <ta.omasab@gmail.com> wrote:
[...]
>> +#ifdef CONFIG_CPU_FREQ_BOOST_SW
>> +       if (of_find_property(dev->of_node, "boost-frequency", &len)) {
>
> Does this mean another block inside the cpu node ? Like this: ?
>
> cpu@0 {
>         compatible = "arm,cortex-a9";
>         reg = <0>;
>         next-level-cache = <&L2>;
>         operating-points = <
>                 /* kHz    uV */
>                 792000  1100000
>                 396000  950000
>                 198000  850000
>         >;
>         boost-frequency = <
>                 792000
>                 198000
>         >;
> };
>
> I think it we might better add another field in the opp block as these
> OPPs are rather boost one..

If we change the meaning to be:
         operating-points = <
                 /* kHz    uV          boost? */
                 792000  1100000  1
                 396000  950000    0

We are adding a modifier to the OPP definition here and does imply
every platform which may or maynot require "boost" need to indicate
that - basically fails at least my "least common" description for a
generic definition. As I had indicated in other threads -> we are back
to the discussion of "additional properties" to an OPP..
Option 1:
  - describe modifiers separately (as in boost-frequencies) - that
operate based on data from opp table.
Option 2:
  - keep adding to the description of opp as time goes by - every SoC
has it's own set of quirks that are needed for an OPP - I know that at
TI, we have certain OPPs that can only be enabled *if* "custom
hardware driver" is enabled, and similar stories. - yet another
example is enable the OPP if efuse X, bit Y is set.

Personally, looking at the various descriptions and bL, cpu-idle
states dependencies on OPPs, etc.. Option 2 is a non-scalable
approach.

[...]
