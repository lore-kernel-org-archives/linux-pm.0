From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [GIT PULL] CPUFreq ARM Fixes for 3.11
Date: Mon, 24 Jun 2013 11:23:52 +0530
Message-ID: <CAKohpong-+4vu4Ky7u_7mPanOZr-jxHKSJRur1cRPaZuaFUBUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:38647 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab3FXFxx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2013 01:53:53 -0400
Received: by mail-oa0-f53.google.com with SMTP id k14so11558160oag.12
        for <linux-pm@vger.kernel.org>; Sun, 23 Jun 2013 22:53:53 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org

Hi Rafael,

The following changes since commit 9e895ace5d82df8929b16f58e9f515f6d54a=
b82d:

  Linux 3.10-rc7 (2013-06-22 09:47:31 -1000)

are available in the git repository at:

  git://git.linaro.org/people/vireshk/linux.git cpufreq-next

for you to fetch changes up to 166b9addd83aaf6eb22d9db7dc015f81913c9a0e=
:

  cpufreq: s3c2416: fix forgotten driver_data conversions (2013-06-24
11:22:33 +0530)

----------------------------------------------------------------
Heiko St=FCbner (1):
      cpufreq: s3c2416: fix forgotten driver_data conversions

 drivers/cpufreq/s3c2416-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
