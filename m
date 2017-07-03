From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq and boost with amd ryzen
Date: Mon, 3 Jul 2017 09:55:38 +0530
Message-ID: <CAOh2x=k87W_i88fXn7LeaMnMJVW8Jvn-jMAxm+Cg5db6xy3bpQ@mail.gmail.com>
References: <CAFFvMK3sFE+zBu3k9vFRTBFVig70DQK8fpvSKiTXkw1bW+zF=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35975 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdGCEZj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 00:25:39 -0400
Received: by mail-yw0-f169.google.com with SMTP id a12so18451767ywh.3
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2017 21:25:39 -0700 (PDT)
In-Reply-To: <CAFFvMK3sFE+zBu3k9vFRTBFVig70DQK8fpvSKiTXkw1bW+zF=A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergio P <sergio.pieiga@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On Sun, Jul 2, 2017 at 8:04 PM, Sergio P <sergio.pieiga@gmail.com> wrote:
> I was wondering why cpufreq is not creating
> /sys/devices/system/cpu/cpufreq/boost for an AMD Ryzen processor? I am
> running kernel 4.11.  I do see cpb (AMD's legacy core performance
> boost) in each individual profile*/ but regardless, it does not seem
> to boost.  (fyi no overclocking going on).
>
> cpupower frequency-info reports
>   boost state support:
>     Supported: no
>     Active: no

Please give output of:

grep . /sys/devices/system/cpu/cpu0/cpufreq/*

I want to see what driver is running and what features are available.

--
viresh
