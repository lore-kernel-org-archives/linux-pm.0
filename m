From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 00/20] cpufreq: Don't loose cpufreq history on CPU hotplug
Date: Fri, 27 Mar 2015 10:45:15 +0530
Message-ID: <CAKohpo=erBw5jPgeE+bTmaK6F5gHihHHCbk+hJ5R9MTGE+pi3g@mail.gmail.com>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
	<5508A702.1040509@codeaurora.org>
	<CAKohponcXi5R_02uqVQHRMb8pxZhizxCzF2dN6meVp9SZBBYYg@mail.gmail.com>
	<1668524.oqBHi5Cb0r@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35986 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbbC0FPQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Mar 2015 01:15:16 -0400
Received: by oicf142 with SMTP id f142so58398600oic.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2015 22:15:15 -0700 (PDT)
In-Reply-To: <1668524.oqBHi5Cb0r@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Saravana Kannan <skannan@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Srivatsa Bhat <srivatsa@mit.edu>

On 27 March 2015 at 01:58, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> My impression was that there had been some comments to address already.
> Isn't that the case?

It was just about coding style, nothing more. Use do-while instead of
while(1) :)
