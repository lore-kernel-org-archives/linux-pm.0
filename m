From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/14] cpufreq: resource management in preparation for
 module build
Date: Wed, 4 Feb 2015 10:28:35 +0530
Message-ID: <CAKohpo=3Ug9yOR2r0Dt7rr609=088ZTe1EpoYG-P-GWekFkYmQ@mail.gmail.com>
References: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
	<CAKohpokgNwdYnc30yd72eJJtpwcDAHx=PmCRWRWPRuXLOq9bnw@mail.gmail.com>
	<20150203193123.GC3486@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:47602 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbbBDE6g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 23:58:36 -0500
Received: by mail-ob0-f181.google.com with SMTP id vb8so22791230obc.12
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2015 20:58:35 -0800 (PST)
In-Reply-To: <20150203193123.GC3486@developer.amazonguestwifi.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Linux PM <linux-pm@vger.kernel.org>

On 4 February 2015 at 01:01, Eduardo Valentin <edubezval@gmail.com> wrote:
> OK. Pick what makes sense.

Because most of your patches are touching files already removed, it
requires a resend of these.

>> And please cc samsung maintainers next time ..
>
> Sure. The patches were all copied to what get_maintainers.pl told me.
> I missed them in Patch 0 though.
>
> I would appreciate if we can fix this issue so that I can send out the
> thermal changes in exynos code without breaking things apart.
>
> What would be the best way to proceed here? Would you be picking the
> rework in exynos cpufreq code and then the cleanups to make to make
> possible to build it as a module? Or should this go together with the
> thermal changes?

I think the thermal changes can go without your patches. If module removal
breaks, it would only break for exynos and nobody was using it until now
that way.

Over that, Kukjin needs to confirm what's going on with the other thread.
Why isn't that pushed to mainline yet ?

--
viresh
