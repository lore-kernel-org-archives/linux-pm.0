From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Change the calculation of next pstate
Date: Tue, 29 Apr 2014 10:28:02 +0530
Message-ID: <CAKohpomhUk7RQ3YL3=wpVKSbK_oSkyYBRUZiqnHzWqrZ2DjRRA@mail.gmail.com>
References: <535D80C8.9090906@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:46081 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbaD2E6E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Apr 2014 00:58:04 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp4so8356183obc.6
        for <linux-pm@vger.kernel.org>; Mon, 28 Apr 2014 21:58:03 -0700 (PDT)
In-Reply-To: <535D80C8.9090906@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>, Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Cc'd Dirk,

On 28 April 2014 03:42, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> Currently the driver calculates the next pstate proportional to
> core_busy factor and reverse proportional to current pstate.
>
> Change the above method and calculate the next pstate independently
> of current pstate.

We must mention why the change is required.
