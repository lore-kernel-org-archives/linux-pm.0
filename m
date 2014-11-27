From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] cpufreq: Add "dvfs-method" binding to probe cpufreq drivers
Date: Thu, 27 Nov 2014 15:52:59 +0530
Message-ID: <CAKohpok+M+HuuQBJ3EJ_3e+Uv-Me5za7EO2TVguU_tCXNtahvQ@mail.gmail.com>
References: <596a6d49f2b3e2837aa9a54a3e1249161d3c9265.1416991009.git.viresh.kumar@linaro.org>
	<5476071B.1060705@arm.com>
	<CAKohpomFE6xg+HfOicha4Ntkr9osqDK2gxdKce=BU_q35jfBxA@mail.gmail.com>
	<5476F4ED.6040206@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:64369 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbaK0KXA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Nov 2014 05:23:00 -0500
Received: by mail-oi0-f53.google.com with SMTP id x69so3274760oia.40
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2014 02:22:59 -0800 (PST)
In-Reply-To: <5476F4ED.6040206@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, "rob.herring@linaro.org" <rob.herring@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kesavan.abhilash@gmail.com" <kesavan.abhilash@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "k.chander@samsung.com" <k.chander@samsung.com>, "olof@lixom.net" <olof@lixom.net>, "ta.omasab@gmail.com" <ta.omasab@gmail.com>

On 27 November 2014 at 15:24, Sudeep Holla <sudeep.holla@arm.com> wrote:
> No that won't suffice. You can't modify the DTs of the platforms using
> cpufreq-dt.c as of today. They should continue to work, so either you
> retain all the existing platform device creation in platform code as is
> or do something like below with the blacklist for those platforms.

Is the meaning of "backward compatibility" for DTs mentioned somewhere?
I am not sure if we have to *always* follow the compatibility you are talking
about.

Probably we want new DTs to continue supporting older version of kernels.
Not that older DTs should work with new kernel changes.

So, even with another field in cpuX node, we wouldn't break older kernels
as they will anyway get the device from platform code.

@Rob?

> OK, in this way you still continue to work on existing platforms with
> *old DT*.

Probably not.
