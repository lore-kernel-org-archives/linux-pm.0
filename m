From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 07/18] cpufreq: Drop (now) useless check 'cpu > nr_cpu_ids'
Date: Thu, 12 Feb 2015 15:50:15 +0800
Message-ID: <CAKohpok5fDSCR01q9oGwKmA=8SiLVSbwC-mMFSGHzJ11GnWsig@mail.gmail.com>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
	<0b79fabc34316fe1e38c9cbe4750bd68ae65b03b.1422346933.git.viresh.kumar@linaro.org>
	<54DC1AED.6020506@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:64255 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbbBLHuQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Feb 2015 02:50:16 -0500
Received: by mail-ob0-f169.google.com with SMTP id wp4so8444065obc.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2015 23:50:16 -0800 (PST)
In-Reply-To: <54DC1AED.6020506@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 12 February 2015 at 11:15, Saravana Kannan <skannan@codeaurora.org> wrote:
> You are getting rid of this check because you no longer use the per-cpu
> variable. So, just squash it with the previous patch that removes the
> per-cpu variable?

We can, but its always better to keep such things in separate patches so that
we know exactly why we did it.. And this is how Me and Srivatsa were asking
you to do it earlier. It helps later on why something has changed.
