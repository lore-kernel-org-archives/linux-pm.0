From: Sergio P <sergio.pieiga@gmail.com>
Subject: cpufreq and boost with amd ryzen
Date: Sun, 2 Jul 2017 10:34:57 -0400
Message-ID: <CAFFvMK3sFE+zBu3k9vFRTBFVig70DQK8fpvSKiTXkw1bW+zF=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35819 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbdGBOe7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2017 10:34:59 -0400
Received: by mail-vk0-f41.google.com with SMTP id 191so84937540vko.2
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2017 07:34:59 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

I was wondering why cpufreq is not creating
/sys/devices/system/cpu/cpufreq/boost for an AMD Ryzen processor? I am
running kernel 4.11.  I do see cpb (AMD's legacy core performance
boost) in each individual profile*/ but regardless, it does not seem
to boost.  (fyi no overclocking going on).

cpupower frequency-info reports
  boost state support:
    Supported: no
    Active: no
