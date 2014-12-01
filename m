From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC V1 0/8] CPUFreq: create platform-dev for DT based cpufreq drivers
Date: Mon, 1 Dec 2014 20:18:43 +0530
Message-ID: <CAKohpo=xDrizL5+5zeVAj_x1BhMuidCa8Ed90YOQbzSTQ_yb2A@mail.gmail.com>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
	<CAKohpo=EPOH-WJ4mmAr-1BzzAEpvC-F0Y99Ox_yL7meUcRNx6Q@mail.gmail.com>
	<547C6E9D.2090205@arm.com>
	<23115535.r6kXsReHU2@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:43206 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbaLAOsn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 09:48:43 -0500
Received: by mail-ob0-f171.google.com with SMTP id uz6so8040557obc.30
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2014 06:48:43 -0800 (PST)
In-Reply-To: <23115535.r6kXsReHU2@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>, Nishanth Menon <nm@ti.com>, "rob.herring@linaro.org" <rob.herring@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Thomas Abraham <ta.omasab@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Chander Kashyap <k.chander@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, "olof@lixom.net" <olof@lixom.net>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mike Turquette <mike.turquette@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, santosh shilimkar <santosh.shilimkar@oracle.com>

On 1 December 2014 at 19:41, Arnd Bergmann <arnd@arndb.de> wrote:
> I would prefer the /cpus node over the /chosen node because the former
> describes the hardware while the latter is supposed to be user-settable
> (on real open-firmware at least). But I think either one is better than
> using the / node compatible string.
>
> How about a "linux,cpu-dvfs-method" property in the root node? Would
> that work better for you than a "linux,dvfs-method" in the "/cpus"
> node?

I will choose "linux,dvfs-method" in the "/cpus" node.
