From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 04/20] cpufreq: Keep a single path for adding managed CPUs
Date: Fri, 20 Mar 2015 08:46:20 +0530
Message-ID: <CAKohponozcMvV1XO3+UfxUpoYMF38ByhJrwUr4ux+_aNPDiUTw@mail.gmail.com>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
	<ff44aa28b7c344936cbc43cfcff7efac92ad9700.1424345053.git.viresh.kumar@linaro.org>
	<550B6BD9.7080602@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:35934 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbbCTDQV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2015 23:16:21 -0400
Received: by oigv203 with SMTP id v203so81580137oig.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2015 20:16:21 -0700 (PDT)
In-Reply-To: <550B6BD9.7080602@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 20 March 2015 at 06:07, Saravana Kannan <skannan@codeaurora.org> wrote:
> The term manages CPUs is a bit unclear/confusing. When I hear managed CPUs,
> I think CPUs that are already marked in policy->cpus and the governor has
> already been started on them.
>
> Can you clarify this commit text please?

Sure.
