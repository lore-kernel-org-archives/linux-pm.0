From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 43/44] cpufreq: unicore2: Use generic cpufreq routines
Date: Mon, 12 Aug 2013 11:38:14 +0530
Message-ID: <CAKohpon5A-h5p7LNjv11QbiguauWMLgK1SK51L3HkSxh1myvoQ@mail.gmail.com>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
	<d518dd39781933a497d44253205b0c039965c718.1376116345.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:64820 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326Ab3HLGIO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2013 02:08:14 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so8698809obc.12
        for <linux-pm@vger.kernel.org>; Sun, 11 Aug 2013 23:08:14 -0700 (PDT)
In-Reply-To: <d518dd39781933a497d44253205b0c039965c718.1376116345.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>

On 10 August 2013 12:14, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
> and .attr. So its better if we have generic routines for them which can be used
> by cpufreq drivers then.
>
> This patch uses these generic routines for this driver.
>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/unicore2-cpufreq.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)

My patch was wrong.. It was based on the assumption that everybody who
had implemented a .target() also implements a frequency table and exposes
it.. And the generic routines I have exposed depend on that frequency table.
And this cpufreq driver doesn't expose that freq table...

And so this patch is dropped :(
