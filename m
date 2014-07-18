From: Olof Johansson <olof@lixom.net>
Subject: Re: [RFC] cpufreq: Add bindings for CPU clock sharing topology
Date: Fri, 18 Jul 2014 14:52:25 -0700
Message-ID: <CAOesGMhuNzVtUkaUjF+JjNgHcgf08WiM0DG-kzwtcyUxkK_zow@mail.gmail.com>
References: <7e097b71342c9f5f63b07ff2e135eb7beb626aab.1405661369.git.viresh.kumar@linaro.org>
	<CAOesGMhTkTEXp99gpU8cZBwYmiXpsySG5zMn6oSyo_Mf5PAiUg@mail.gmail.com>
	<CAKohpo=MmoALOHg-=7cf0jm=OJO57TWQZQXqkRwhRwU-DGPMmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:61830 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755506AbaGRVw0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jul 2014 17:52:26 -0400
Received: by mail-vc0-f169.google.com with SMTP id hu12so8541294vcb.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2014 14:52:25 -0700 (PDT)
In-Reply-To: <CAKohpo=MmoALOHg-=7cf0jm=OJO57TWQZQXqkRwhRwU-DGPMmA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mike Turquette <mike.turquette@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arvind Chauhan <arvind.chauhan@arm.com>, Arnd Bergmann <arnd.bergmann@linaro.org>

On Thu, Jul 17, 2014 at 11:40 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 18 July 2014 11:47, Olof Johansson <olof@lixom.net> wrote:
>> Why complicate it by using two properties?
>>
>> If there is no property, then the CPUs are assumed to be controlled
>> independently.
>>
>> if there is a clock-master = <phandle> property, then that points at
>> the cpu that is the main one controlling clock for the group.
>>
>> There's really no need to label the master -- it will be the only one
>> with incoming links but nothing outgoing. And a master without slaves
>> is an independently controlled cpu so you should be fine in that
>> aspect too.
>
> I thought so earlier, but then I remembered something I read long back.
> Don't remember which thread now, but I *might* be wrong..
>
> "Bindings are like APIs and new bindings shouldn't break existing stuff.."
>
> And:
>
>> If there is no property, then the CPUs are assumed to be controlled
>> independently.
>
> seems to break the existing API.

What is the current API that is being broken, in your opinion?

> But if that isn't the case, the bindings are very simple & clear to handle.
> Diff for new bindings:

It's somewhat confusing to see a diff to the patch instead of a new
version. It seems to remove the cpu 0 entry now?


-Olof
