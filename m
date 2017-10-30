From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PULL REQUEST] for Rafael's Linux-PM / For-Next
Date: Mon, 30 Oct 2017 11:20:08 +0100
Message-ID: <CAJZ5v0hM=gm5=mR1W=E6=LUPDMSJVS+xpb4B+xXpu-dx=gU4Sg@mail.gmail.com>
References: <CGME20171027003236epcms1p294d11fd0d6e074ec177abe903a2a91b8@epcms1p2>
 <20171027003236epcms1p294d11fd0d6e074ec177abe903a2a91b8@epcms1p2>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:57251 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932575AbdJ3KUJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Oct 2017 06:20:09 -0400
Received: by mail-oi0-f66.google.com with SMTP id v9so21022480oif.13
        for <linux-pm@vger.kernel.org>; Mon, 30 Oct 2017 03:20:08 -0700 (PDT)
In-Reply-To: <20171027003236epcms1p294d11fd0d6e074ec177abe903a2a91b8@epcms1p2>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Myungjoo Ham <myungjoo.ham@samsung.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>

On Fri, Oct 27, 2017 at 2:32 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
> Dear Rafael,
>
> Here goes a pull request from PM/devfreq mainly focussing on supporting OPP better.
>
>
> Cheers,
> MyungJoo
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> The following changes since commit bb176f67090ca54869fc1262c913aa69d2ede070:
>
>   Linux 4.14-rc6 (2017-10-23 06:49:47 -0400)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git tags/pullreq_20171026
>
> for you to fetch changes up to aa7c352f9841ab3fee5bf1de127a45e6310124a6:
>
>   PM / devfreq: Define the constant governor name (2017-10-26 17:08:40 +0900)
>
> - ----------------------------------------------------------------
> Pull Request from PM/devfreq to Linux-PM
>
> - ----------------------------------------------------------------
> Chanwoo Choi (7):
>       PM / devfreq: Set min/max_freq when adding the devfreq device
>       Revert "PM / devfreq: Add show_one macro to delete the duplicate code"
>       PM / devfreq: Use the available min/max frequency
>       PM / devfreq: Change return type of devfreq_set_freq_table()
>       PM / devfreq: Show the all available frequencies
>       PM / devfreq: Remove unneeded conditional statement
>       PM / devfreq: Define the constant governor name

Pulled, thanks!
