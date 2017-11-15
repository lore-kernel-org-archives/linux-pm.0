From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Wed, 15 Nov 2017 12:39:36 +0100
Message-ID: <2932a544-dd58-11e3-4012-7d281d6b64ef@linaro.org>
References: <cover.1510735482.git.viresh.kumar@linaro.org>
 <fcca009e0e10840ff5ee31c88b618a212ab69201.1510735482.git.viresh.kumar@linaro.org>
 <20171115113133.GA10252@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44933 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757427AbdKOLjl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 06:39:41 -0500
Received: by mail-lf0-f68.google.com with SMTP id s16so25630031lfs.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Nov 2017 03:39:40 -0800 (PST)
In-Reply-To: <20171115113133.GA10252@localhost>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, edubezval@gmail.com, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, lukasz.luba@arm.com, linux-kernel@vger.kernel.org, Punit Agrawal <punit.agrawal@arm.com>

On 15/11/2017 12:31, Javi Merino wrote:
> On Wed, Nov 15, 2017 at 02:49:48PM +0530, Viresh Kumar wrote:
>> No one has used it for the last two and half years (since it was
>> introduced by commit c36cf0717631 ("thermal: cpu_cooling: implement the
>> power cooling device API")), get rid of it.
> 
> Linaro used it in lsk 3.18 for the cpufreq driver for Juno.  The cpufreq
> driver was converted to the generic one from dt in lsk 4.4, but the
> generic cpufreq driver does not support static power because everything
> has to come from device tree and we don't have a way to specify it there.

Are in favor of removing it or improving the code ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
