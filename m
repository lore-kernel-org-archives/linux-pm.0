From: Sergio P <sergio.pieiga@gmail.com>
Subject: Re: cpufreq and boost with amd ryzen
Date: Tue, 4 Jul 2017 16:38:35 -0400
Message-ID: <CAFFvMK1FuCUWjOk_hv9W+zTqWcDT86qNbybRrzx989d1gfoZKw@mail.gmail.com>
References: <CAFFvMK3sFE+zBu3k9vFRTBFVig70DQK8fpvSKiTXkw1bW+zF=A@mail.gmail.com>
 <CAOh2x=k87W_i88fXn7LeaMnMJVW8Jvn-jMAxm+Cg5db6xy3bpQ@mail.gmail.com>
 <CAFFvMK1zUZhKAqFMxSWjbW7Bb-j0Odr0DjmTiC8DbqKonNL+Kg@mail.gmail.com> <20170704061000.GE3532@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34930 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752265AbdGDUih (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jul 2017 16:38:37 -0400
Received: by mail-vk0-f47.google.com with SMTP id 191so115217112vko.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Jul 2017 13:38:37 -0700 (PDT)
In-Reply-To: <20170704061000.GE3532@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>

To be honest, I am not very familiar on how to debug the kernel.

My guess would be that X86_FEATURE_CPB is not being detected correctly
for Ryzen family in the CPUID registers, and it returns early from
acpi_cpufreq_boost_init().  Also, CPB was a feature in earlier AMD
processors, but now in the new Ryzen family, I'm not sure if it's
called something else and perhaps defined in a different CPUID bit.
