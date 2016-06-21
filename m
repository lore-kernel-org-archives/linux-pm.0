From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PULL Request] Devfreq Fixes for RC5+.
Date: Wed, 22 Jun 2016 00:26:12 +0200
Message-ID: <CAJZ5v0j1U0iCvZhROoJ=HqQ=nACrpNabtFRFFN4WAbHaRJFvHQ@mail.gmail.com>
References: <CGME20160621054943epcms1p5edf96fb3b2179a62bff867190bc6dc13@epcms1p5>
 <1787004839.214561.1466488183645.JavaMail.weblogic@ep2ml104d>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36760 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbcFUW0x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2016 18:26:53 -0400
Received: by mail-lf0-f67.google.com with SMTP id a2so7981134lfe.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Jun 2016 15:26:14 -0700 (PDT)
In-Reply-To: <1787004839.214561.1466488183645.JavaMail.weblogic@ep2ml104d>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Myungjoo Ham <myungjoo.ham@samsung.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>

On Tue, Jun 21, 2016 at 7:49 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
> Dear Rafael,
>
> Here goes a pull request of "PM / Devfreq Fixes" targetting RC5+.

You should sign off all of your commits and some of them are only
acked-by.  Can you please add the sign-offs as appropriate and sent
the request again?

Thanks,
Rafael


> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> The following changes since commit 33688abb2802ff3a230bd2441f765477b94cc89e:
>
>   Linux 4.7-rc4 (2016-06-19 21:30:02 -0700)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git fixes
>
> for you to fetch changes up to 72b2835bab6bb0f7688a78301ac1466c729cb1c9:
>
>   PM / devfreq: fix initialization of current frequency in last status (2016-06-21 14:25:30 +0900)
>
> - ----------------------------------------------------------------
> Pull Request of Devfreq Fixes (3.7 rc 5+) for Rafael Linux PM.
>
> - ----------------------------------------------------------------
> Cai Zhiyong (1):
>       PM / devfreq: fix double call put_device
>
> Dan Carpenter (1):
>       PM / devfreq: exynos-nocp: Remove incorrect IS_ERR() check
>
> Lukasz Luba (1):
>       PM / devfreq: fix initialization of current frequency in last status
>
> MyungJoo Ham (3):
>       PM / devfreq: devm_kzalloc to have dev pointer more precisely
>       PM / devfreq: fix duplicated kfree on devfreq pointer
>       PM / devfreq: remove double put_device
>
>  drivers/devfreq/devfreq.c           | 22 ++++++++++------------
>  drivers/devfreq/event/exynos-nocp.c |  3 ---
>  2 files changed, 10 insertions(+), 15 deletions(-)
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1
>
> iQIcBAEBAgAGBQJXaNMEAAoJEBOhurvWBoCK7zEQAJKBAEThlu6CdQEcN7duZE25
> DD2pGzSKQ5sq/RYg6Y0BUcyY3ltgenRzv93OHyGs4k2Su65rRhso7ClKv6stWdUo
> tfkWuvgH3Zjns0zllaknsCvl5izxRaYdCobmoDZ/omHvP3u9aLqbO7PAqonLQzX+
> /mqasQV02GSBgsgJiS6t5hR68oBEmGMeS6yiZhM1BAPkVqvxVpopgNxY3ZFjHW+Y
> IUzsleiivyU6hZjnJNwcRGJtq3uF+66YvDDM/7jUDAeDK1mFsmJo+kB9jTugLhvo
> B6ZkOfgG+s3GRQYVlq61NHxcO5FQ8qDmDpBLaANeitd6IffVJoPoFusUWnTXcq5W
> wxU/WOEgInRD2hb9yMTbzlFtJjSNPNM/yQSE7wSMFQgVIBoqVTL1ImWwfZKPhVCj
> VNwibytPUJmZD2gT97Kzhnz7o0DDA/YlljYbmcj3L/yL+myltXKFsR998K80OiGk
> byMehap5itfKmwU7WmgpUSCg2F0Kg9JcOAO8SR4J0RB39I1Uot5h6Hei6vbzf5al
> R4VFYyNtk5VuMydtEFwm8m5HeK1TFQxZiGxMricD5U9sA4sODIrAWxDBA8wKMU87
> y0rp3FPRUigPemzUIPXRSrwFpSltVFsdHt58/ZWLco1wTuV3bisbFP+qAwD9AwYr
> L+atxnliyfnmn7OHvZxR
> =BrZs
> -----END PGP SIGNATURE-----
