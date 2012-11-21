From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PULL REQUEST for Rafael] PM / devfreq: pull request
Date: Wed, 21 Nov 2012 01:48:55 +0100
Message-ID: <6585454.CUq5czq4Ep@vostro.rjw.lan>
References: <1353397850-21949-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:56798 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344Ab2KUAo2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 20 Nov 2012 19:44:28 -0500
In-Reply-To: <1353397850-21949-1-git-send-email-myungjoo.ham@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-pm@vger.kernel.org, myungjoo.ham@gmail.com, nm@ti.com, rajagopal.venkat@linaro.org, kyungmin.park@samsung.com, sh007.yi@samsung.com, jonghwa3.lee@samsung.com, sachin.kamat@linaro.org

On Tuesday, November 20, 2012 04:50:50 PM MyungJoo Ham wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:
> 
>   Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)
> 
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git tags/pull_req_20121120
> , which is based on Rafael's linux-pm.git pm-devfreq.
> 
> Jonghwa Lee (1):
>       PM / devfreq: Add sysfs node for representing frequency transition information.
> 
> Nishanth Menon (12):
>       PM / devfreq: kernel-doc typo corrections
>       PM / devfreq: fix sscanf handling for writable sysfs entries
>       PM / devfreq: make devfreq_class static
>       PM / devfreq: documentation cleanups for devfreq header
>       PM / devfreq: Add sysfs node to expose available frequencies
>       PM / devfreq: export update_devfreq
>       PM / devfreq: provide hooks for governors to be registered
>       PM / devfreq: register governors with devfreq framework
>       PM / devfreq: map devfreq drivers to governor using name
>       PM / devfreq: governors: add GPL module license and allow module build
>       PM / devfreq: allow sysfs governor node to switch governor
>       PM / devfreq: Add sysfs node to expose available governors
> 
> Rajagopal Venkat (3):
>       PM / devfreq: Core updates to support devices which can idle
>       PM / devfreq: Add suspend and resume apis
>       PM / devfreq: Add current freq callback in device profile
> 
> Sachin Kamat (1):
>       PM / devfreq: Use devm_* functions in exynos4_bus.c
> 
> Sangho Yi (1):
>       PM / devfreq: exynos4_bus.c: Fixed an alignment of the func call args.

Pulled, thanks a lot MyungJoo!

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
