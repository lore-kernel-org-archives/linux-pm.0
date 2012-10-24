From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 3/6] Thermal: fix bug of counting cpu frequencies.
Date: Wed, 24 Oct 2012 19:04:44 +0530
Message-ID: <CAKohpomygrbhNMJ5+P6DnppBTOSXB8GFeQsbjkUZ61Ou6bzaPQ@mail.gmail.com>
References: <1350387889-15324-1-git-send-email-hongbo.zhang@linaro.com>
	<1351079900-32236-1-git-send-email-hongbo.zhang@linaro.com>
	<1351079900-32236-4-git-send-email-hongbo.zhang@linaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:42559 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194Ab2JXNep (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Oct 2012 09:34:45 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so357248iag.19
        for <linux-pm@vger.kernel.org>; Wed, 24 Oct 2012 06:34:44 -0700 (PDT)
In-Reply-To: <1351079900-32236-4-git-send-email-hongbo.zhang@linaro.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "hongbo.zhang" <hongbo.zhang@linaro.org>
Cc: linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, kernel@igloocommunity.org, linaro-kernel@lists.linaro.org, "hongbo.zhang" <hongbo.zhang@linaro.com>, patches@linaro.org

On 24 October 2012 17:28, hongbo.zhang <hongbo.zhang@linaro.org> wrote:
> From: "hongbo.zhang" <hongbo.zhang@linaro.com>
>
> In the while loop for counting cpu frequencies, if table[i].frequency equals
> CPUFREQ_ENTRY_INVALID, index i won't be increased, so this leads to an endless
> loop, what's more the index i cannot be referred as cpu frequencies number if
> there is CPUFREQ_ENTRY_INVALID case.
>
> Signed-off-by: hongbo.zhang <hongbo.zhang@linaro.com>

Good one.

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
