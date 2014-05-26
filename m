From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/3] cpufreq: handle calls to ->target_index() in
 separate routine
Date: Tue, 27 May 2014 05:29:34 +0530
Message-ID: <CAKohpo=F2yYc8r=oA6Y43c-FAgPBeAz8sRnYjbS0K8HE0OmpRg@mail.gmail.com>
References: <cover.1400662383.git.viresh.kumar@linaro.org>
	<b2ed4e111222c2367a77a1382a6a7ea232ef9b59.1400662383.git.viresh.kumar@linaro.org>
	<2164172.cubRkjSW1o@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:59063 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbaEZX7f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 May 2014 19:59:35 -0400
Received: by mail-oa0-f49.google.com with SMTP id eb12so8689713oac.8
        for <linux-pm@vger.kernel.org>; Mon, 26 May 2014 16:59:34 -0700 (PDT)
In-Reply-To: <2164172.cubRkjSW1o@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Stephen Warren <swarren@nvidia.com>, Doug Anderson <dianders@chromium.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Thomas Abraham <thomas.abraham@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>

On 27 May 2014 04:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> I guess I can take this one without the rest of the series?

Yes.
