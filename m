From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: AMD: Ignore the check for ProcFeedback in ST/CZ
Date: Thu, 18 Jan 2018 15:41:50 +0530
Message-ID: <20180118101150.GG3012@vireshk-i7>
References: <1516265488-31452-1-git-send-email-akshu.agrawal@amd.com>
 <20180118091103.GF3012@vireshk-i7>
 <ab16f642-32ce-662d-c086-b185ec60f038@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35933 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755674AbeARKLy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jan 2018 05:11:54 -0500
Received: by mail-pg0-f65.google.com with SMTP id k68so6081161pga.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2018 02:11:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ab16f642-32ce-662d-c086-b185ec60f038@amd.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, satyajit.sahu@amd.com

On 18-01-18, 15:34, Agrawal, Akshu wrote:
> 
> 
> On 1/18/2018 2:41 PM, Viresh Kumar wrote:
> >On 18-01-18, 14:21, Akshu Agrawal wrote:
> >>In ST/CZ CPUID 8000_0007_EDX[11, ProcFeedbackInterface] is 0,
> >>but the mechanism is still available and can be used.
> >>
> >>Change-Id: I5751d92c628da9ad4e15ec34079090c4315d4f2a
> >
> >??
> 
> unique-id to keep track of changes. Came in because I made the patch on a
> different git.
> Removing it and sending a v2.

Yeah, I know its a gerrit thing. Just wanted to point out that you
should drop it :)

-- 
viresh
