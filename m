From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 1/2] cpufreq / OPP: Allow boost frequency to be looked
 up from device tree
Date: Wed, 14 May 2014 09:31:49 -0500
Message-ID: <53737E55.9070704@ti.com>
References: <1400029380-5372-1-git-send-email-thomas.ab@samsung.com>	<1400029380-5372-2-git-send-email-thomas.ab@samsung.com>	<CAKohponnPSRAotJUu+5a9y8j97QF8Jqgc5DA5WQnwGWCnVY-aA@mail.gmail.com>	<CAGo_u6p-uqw82ewDciDEhAt0=Nswfw33-gf8Aa+-6_k3eCcTzw@mail.gmail.com>	<20140514080930.781e0557@amdc2363> <CAKohponG9PNse4cHkvfLfaRouW-jxjToBXUCHyOCgx8-Pc=2Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52960 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbaENOcW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 May 2014 10:32:22 -0400
In-Reply-To: <CAKohponG9PNse4cHkvfLfaRouW-jxjToBXUCHyOCgx8-Pc=2Xw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>
Cc: Thomas Abraham <ta.omasab@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Thomas P Abraham <thomas.ab@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 05/14/2014 01:24 AM, Viresh Kumar wrote:
> On 14 May 2014 11:39, Lukasz Majewski <l.majewski@samsung.com> wrote:
>> I agree with Nishanth here, that point 1 (as described by Viresh at
>> [*]) is a more scalable approach.
> 
> The only reason why I wanted all that to be done at OPP level was to
> ensure if somebody else also needs it apart from cpufreq, they don't have
> to duplicate code and find it.. As it is present at a central place..
> 
> But if no other code is going to look for that, it may just be fine as is..
> 
If we eventually have a need beyond cpufreq (say devfreq) with similar
instances, then it makes sense to move it out to a generic place.
Either way, code implementation/duplication is a OS problem - and
should be looked at independent of the description in dts. If we feel
the description is valid hardware description (which, personally, I
do), then lets go to the next discussion point of where to put it -
generic or cpufreq specific (here, I have no preference), and finally
decide the implementation as necessary as a result of the description.

-- 
Regards,
Nishanth Menon
