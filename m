From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 1/2] cpufreq: split the cpufreq_driver_lock and use the rcu
Date: Tue, 2 Apr 2013 20:29:12 +0530
Message-ID: <CAKohpokXbeRp-pHaJRAOjnF+R+wy8R9We67Yr2C2nyoVXyJd6w@mail.gmail.com>
References: <5159C147.70800@sgi.com>
	<1364847069-2887-1-git-send-email-nzimmer@sgi.com>
	<1364847069-2887-2-git-send-email-nzimmer@sgi.com>
	<CAKohpok7MR28trAddHRi5Lcg0bGBHBnOfJO=yu7SQqGnV5ZCRg@mail.gmail.com>
	<20130402145536.GA31757@gulag1.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:43456 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358Ab3DBO7N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Apr 2013 10:59:13 -0400
Received: by mail-oa0-f43.google.com with SMTP id l10so478145oag.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Apr 2013 07:59:12 -0700 (PDT)
In-Reply-To: <20130402145536.GA31757@gulag1.americas.sgi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nathan Zimmer <nzimmer@sgi.com>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 2 April 2013 20:25, Nathan Zimmer <nzimmer@sgi.com> wrote:
> The lock is unneeded if we expect register and unregister driver to not be
> called from muliple threads at once.  I didn't make that assumption.

Hmm.. But doesn't rcu part take care of that too?? Two writers
updating stuff simultaneously?
