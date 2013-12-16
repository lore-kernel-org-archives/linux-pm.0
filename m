From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Fix sscanf robustness
Date: Mon, 16 Dec 2013 15:20:19 +0530
Message-ID: <CAOh2x=mOQB5+8T0rgPVXzgmVxT_xYcSqsOQ_KkHGL470G1vS3Q@mail.gmail.com>
References: <20131211183506.9179.83721.stgit@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48]:41544 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab3LPJuU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2013 04:50:20 -0500
Received: by mail-vb0-f48.google.com with SMTP id f13so2980709vbg.35
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2013 01:50:19 -0800 (PST)
In-Reply-To: <20131211183506.9179.83721.stgit@alan.etchedpixels.co.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan <gnomes@lxorguk.ukuu.org.uk>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Thu, Dec 12, 2013 at 12:05 AM, Alan <gnomes@lxorguk.ukuu.org.uk> wrote:
> The cpufreq-set tool has a missing length check. This is basically
> just correctness but still should get fixed.
>
> One of a set of sscanf problems reported by Jackie Chang
>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>  tools/power/cpupower/utils/cpufreq-set.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
