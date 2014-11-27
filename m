From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] cpufreq: Add "dvfs-method" binding to probe cpufreq drivers
Date: Thu, 27 Nov 2014 10:44:45 +0530
Message-ID: <CAKohpokLeX+NoD9KX1MWWjyZtu6otw_oryt1f4gwLz7TffcExQ@mail.gmail.com>
References: <596a6d49f2b3e2837aa9a54a3e1249161d3c9265.1416991009.git.viresh.kumar@linaro.org>
	<CAKohpomBijLiBgV31ZhZDTctsTLccBZ+93r+esG-WRZAS4sqww@mail.gmail.com>
	<54760107.3010205@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:44481 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701AbaK0FOq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Nov 2014 00:14:46 -0500
Received: by mail-ob0-f176.google.com with SMTP id vb8so3219728obc.7
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 21:14:45 -0800 (PST)
In-Reply-To: <54760107.3010205@oracle.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: santosh shilimkar <santosh.shilimkar@oracle.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Chander Kashyap <k.chander@samsung.com>, "olof@lixom.net" <olof@lixom.net>, Thomas Abraham <ta.omasab@gmail.com>

On 26 November 2014 at 22:04, santosh shilimkar
<santosh.shilimkar@oracle.com> wrote:
> Its really not 'dvfs-method' but really the actual driver which you
> want to probe. Also we should just have one global way to parse
> DT vs non-DT cpufreq drivers. In other words, instead of matching
> multiple driver strings for different drivers, we should come up with
> slightly generic binding. Probably 'cpufreq-dt' for all DT based probed
> CPUFREQ drivers.
>
> What you say ?

I got a bit confused. :(

The whole purpose of this binding is to select which cpufreq driver to
choose from the available ones.

Are you saying that we should have only one cpufreq driver that works
with DT ? I don't think that would be the right decision, but we should
try to reuse cpufreq-dt wherever possible.

Or are you saying that some common code should parse this DT information?
This is what I said in the patch, we can write another file which will
just create
a platform_device for us, depending on the string that came in.
