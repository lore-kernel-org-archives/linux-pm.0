From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH]Fix for typos in comments
Date: Tue, 26 May 2015 16:24:43 -0700
Message-ID: <7h382iq5vo.fsf@deeprootsystems.com>
References: <CAGgNLB7Riu6sd_fJGK=Zgg2N9b8uFWsUfcX94oTX9k-AW-aqbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36252 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbEZXYq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2015 19:24:46 -0400
Received: by paza2 with SMTP id a2so94549397paz.3
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2015 16:24:46 -0700 (PDT)
In-Reply-To: <CAGgNLB7Riu6sd_fJGK=Zgg2N9b8uFWsUfcX94oTX9k-AW-aqbg@mail.gmail.com>
	(sriram dash's message of "Mon, 25 May 2015 07:46:10 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sriram dash <dash.sriram@gmail.com>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, linux-pm@vger.kernel.org

sriram dash <dash.sriram@gmail.com> writes:

> I am a newbie into the Linux kernel and eager to improve my understanding
> in this field.

Great, thanks for being willing to contribute!

> Currently, i found the following typo error which i feel could be corrected
> for the following. Please have a review:
>
> In the file: /drivers/base/power/domain.c,
>
> In line 494,
>
>
> ++ * @genpd: PM domain to power off.
> -- * @genpd: PM domait to power off.
>
>
> Please check if the correction is valid.

Please submit your changes in patch form.  Please read
Documentation/SubmittingPatches.txt in the kernel source directory for
guidelines on how to correctly submit patches.

Also, I highly recommend using "git format-patch" to create patches
directly out of your git tree changes.

Kevin
