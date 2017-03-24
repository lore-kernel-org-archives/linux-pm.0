From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH] cpufreq: create sysfs symlink for cpus onlined after boot
Date: Fri, 24 Mar 2017 10:31:51 -0600
Message-ID: <f2e4a303-715d-17f7-7dcd-e48dc3eee407@codeaurora.org>
References: <1490304286-18311-1-git-send-email-pprakash@codeaurora.org>
 <CAJZ5v0j956ttMf3Oaek2=xSKFeqKnhO=1+RN3+81H5E1rXY4UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42434 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757367AbdCXQcM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2017 12:32:12 -0400
In-Reply-To: <CAJZ5v0j956ttMf3Oaek2=xSKFeqKnhO=1+RN3+81H5E1rXY4UA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

On 3/23/2017 5:30 PM, Rafael J. Wysocki wrote:
> On Thu, Mar 23, 2017 at 10:24 PM, Prashanth Prakash
> <pprakash@codeaurora.org> wrote:
>> Adds an additional code path within cpufreq_online to create sysfs
>> symlinks for cpus that are bought onilne for the first time after
>> completion of boot.
>>
>> With maxcpus=N kernel parameter, it is possible to bring additional
>> cpus online after boot. In these cases per-cpu "cpufreq" symlinks
>> are not being created during registration as policy may not exist
>> for the cpus that were offline during boot.
>>
>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> This looks way overly complicated to me.  Let me look at it in the
> next couple of days.
Sure. Thanks!
