From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [GIT PULL]: CPUFreq: ARM Fixes for 3.12
Date: Mon, 26 Aug 2013 19:36:56 +0530
Message-ID: <CAKohpo=2msHhAWqqe==yLCszE5U6ccSti31E82eovkb4emJd5A@mail.gmail.com>
References: <CAKohpoksNiGT+r3JTY6KFwnDFA5OYE-vQe8W_9GT-fN21UMrfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:52831 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab3HZOG5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2013 10:06:57 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so3599220oag.12
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2013 07:06:56 -0700 (PDT)
In-Reply-To: <CAKohpoksNiGT+r3JTY6KFwnDFA5OYE-vQe8W_9GT-fN21UMrfQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Joseph Lo <josephl@nvidia.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Stephen Warren <swarren@nvidia.com>, Sascha Hauer <s.hauer@pengutronix.de>

On 26 August 2013 11:48, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Rafael,
>
> Hopefully this is the last patch for 3.12 for ARM CPUFreq subsystem.

Another last minute patch from Sascha..

-----------x------------------x------------------

The following changes since commit b36f4be3de1b123d8601de062e7dbfc904f305fb:

  Linux 3.11-rc6 (2013-08-18 14:36:53 -0700)

are available in the git repository at:

  git://git.linaro.org/people/vireshk/linux.git cpufreq-fixes

for you to fetch changes up to fae19b84724ff93c1ac59ce1eecc1411f8269d9e:

  cpufreq: imx6q: Fix clock enable balance (2013-08-26 19:34:07 +0530)

----------------------------------------------------------------
Joseph Lo (1):
      cpufreq: tegra: fix the wrong clock name

Sascha Hauer (1):
      cpufreq: imx6q: Fix clock enable balance

 drivers/cpufreq/imx6q-cpufreq.c | 17 -----------------
 drivers/cpufreq/tegra-cpufreq.c |  4 ++--
 2 files changed, 2 insertions(+), 19 deletions(-)
