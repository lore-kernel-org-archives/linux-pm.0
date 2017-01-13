From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/4] selftest: cpufreq: Add support for cpufreq framework
Date: Fri, 13 Jan 2017 12:06:44 +0530
Message-ID: <cover.1484289212.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35265 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdAMGg7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2017 01:36:59 -0500
Received: by mail-pf0-f171.google.com with SMTP id f144so26328304pfa.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2017 22:36:59 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Shuah Khan <shuah@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kselftest@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi,

This patchset adds support for cpufreq selftests to the kernel selftest
framework. More details can be found on individual patches.

These are all tested after installation of selftests on ARM Dual A15
core Exynos platform.

The content of the output file for the basic tests looks like this:
http://pastebin.com/nBY9AfD5 .

--
viresh

Viresh Kumar (4):
  selftest: cpufreq: Add support for cpufreq tests
  selftest: cpufreq: Add suspend/resume/hibernate support
  selftest: cpufreq: Add support to test cpufreq modules
  selftest: cpufreq: Add special tests

 tools/testing/selftests/Makefile                 |   1 +
 tools/testing/selftests/cpufreq/Makefile         |   8 +
 tools/testing/selftests/cpufreq/cpu.sh           |  84 ++++++++
 tools/testing/selftests/cpufreq/cpufreq.sh       | 241 ++++++++++++++++++++++
 tools/testing/selftests/cpufreq/governor.sh      | 153 ++++++++++++++
 tools/testing/selftests/cpufreq/main.sh          | 194 ++++++++++++++++++
 tools/testing/selftests/cpufreq/module.sh        | 243 +++++++++++++++++++++++
 tools/testing/selftests/cpufreq/special-tests.sh | 115 +++++++++++
 8 files changed, 1039 insertions(+)
 create mode 100644 tools/testing/selftests/cpufreq/Makefile
 create mode 100755 tools/testing/selftests/cpufreq/cpu.sh
 create mode 100755 tools/testing/selftests/cpufreq/cpufreq.sh
 create mode 100755 tools/testing/selftests/cpufreq/governor.sh
 create mode 100755 tools/testing/selftests/cpufreq/main.sh
 create mode 100755 tools/testing/selftests/cpufreq/module.sh
 create mode 100755 tools/testing/selftests/cpufreq/special-tests.sh

-- 
2.7.1.410.g6faf27b

