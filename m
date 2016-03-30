From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: acpi: policy->driver_data can't be NULL in
 ->exit()
Date: Wed, 30 Mar 2016 16:53:54 +0530
Message-ID: <20160330112354.GG24343@vireshk-i7>
References: <f4f0e029b46cdd09dd7d3f0035e8588f5de94e21.1459311858.git.viresh.kumar@linaro.org>
 <CAJZ5v0hqrUyi2ggsDyOq9y0Q9BzktYdSG6DZQMfMF9HsqRLf0g@mail.gmail.com>
 <CAJZ5v0gyndbTjEYvS8BjZzC-jsKc_M2w9BZF=z-tjEVqMxqFog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33460 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbcC3LX5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 07:23:57 -0400
Received: by mail-pf0-f175.google.com with SMTP id 4so40208345pfd.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2016 04:23:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gyndbTjEYvS8BjZzC-jsKc_M2w9BZF=z-tjEVqMxqFog@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 30-03-16, 13:18, Rafael J. Wysocki wrote:
> It conflicts with other stuff (as you know), so I'm not sure about the
> order in which they are going to be applied, though.

Yeah, I know. I noticed the ugliness only after looking at your
changes :)

I am fine to rebase them over if you want. Its really trivial.

-- 
viresh
