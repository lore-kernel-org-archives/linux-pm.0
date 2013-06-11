From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RESEND][PATCH] cpufreq: stats: Add 'load_table' sysfs file to
 show accumulated data of CPU
Date: Tue, 11 Jun 2013 10:52:27 +0530
Message-ID: <CAKohpomNN=keppPeLLDor_6YpyOO19_fsbWZRE+w33DoVDBprw@mail.gmail.com>
References: <1370419882-16831-1-git-send-email-cw00.choi@samsung.com>
	<CAKohpon6fgft2KZgy3-w5TxDz=5JsVHhNdTPTF7ZUq9K-kGc3w@mail.gmail.com>
	<51B5C2E4.9060400@samsung.com>
	<CAKohpokSt1=cbeYFo-U_DF5Mr8WOFDkkQbyaHh5DqR0OHh+S7A@mail.gmail.com>
	<51B6B373.7040904@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:41510 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab3FKFW2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2013 01:22:28 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so11278520obc.17
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2013 22:22:27 -0700 (PDT)
In-Reply-To: <51B6B373.7040904@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, Lists linaro-kernel <linaro-kernel@lists.linaro.org>

On 11 June 2013 10:49, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> I will modify this patch according to your comment
> and then resend it after merged below patch.
> - [PATCH] cpufreq: stats: Remove CONFIG_CPU_FREQ_STAT_DETAILS

Hmm.. Maybe you can sent it without rebasing your patch over mine and
we can rebase it over my patch later. So, that you don't end up waiting for
my patches to be included.
