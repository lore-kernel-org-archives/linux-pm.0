From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Wed, 15 Nov 2017 07:09:26 -0800
Message-ID: <20171115150924.GA1758@localhost.localdomain>
References: <cover.1510735482.git.viresh.kumar@linaro.org>
 <fcca009e0e10840ff5ee31c88b618a212ab69201.1510735482.git.viresh.kumar@linaro.org>
 <20171115113133.GA10252@localhost>
 <2932a544-dd58-11e3-4012-7d281d6b64ef@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44163 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752852AbdKOPJa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 10:09:30 -0500
Content-Disposition: inline
In-Reply-To: <2932a544-dd58-11e3-4012-7d281d6b64ef@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Javi Merino <javi.merino@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, lukasz.luba@arm.com, linux-kernel@vger.kernel.org, Punit Agrawal <punit.agrawal@arm.com>

On Wed, Nov 15, 2017 at 12:39:36PM +0100, Daniel Lezcano wrote:
> On 15/11/2017 12:31, Javi Merino wrote:
> > On Wed, Nov 15, 2017 at 02:49:48PM +0530, Viresh Kumar wrote:
> >> No one has used it for the last two and half years (since it was
> >> introduced by commit c36cf0717631 ("thermal: cpu_cooling: implement the
> >> power cooling device API")), get rid of it.
> > 
> > Linaro used it in lsk 3.18 for the cpufreq driver for Juno.  The cpufreq
> > driver was converted to the generic one from dt in lsk 4.4, but the
> > generic cpufreq driver does not support static power because everything
> > has to come from device tree and we don't have a way to specify it there.
> 
> Are in favor of removing it or improving the code ?

Yes, to what I can remember, Juno driver originally used this and it was
supposed to be a reference on who this stuff gets to be used. So, this
is more like "the code never made mainline" instead of no one is using.

And to be frank, this is the API that represents static power, which is
the component that differentiate things while using IPA. Maybe 

So yes, my suggestion is to put effort to get the juno code that uses
the static power back to mainline.

> 
> 
> -- 
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
