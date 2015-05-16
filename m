From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/2] cpufreq_stats: Adds sysfs file
 /sys/devices/system/cpu/cpufreq/current_in_state
Date: Sat, 16 May 2015 07:45:39 +0530
Message-ID: <20150516021539.GF4600@linux>
References: <1431648770-7404-1-git-send-email-kandoiruchi@google.com>
 <1431648770-7404-2-git-send-email-kandoiruchi@google.com>
 <20150515024843.GE6348@linux>
 <CAL8qYTO3uurrxQBjfPDNL2hamxh4+GCuzX0mxsEw=+go5CPWcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35049 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992656AbbEPCPo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2015 22:15:44 -0400
Received: by pacwv17 with SMTP id wv17so41469298pac.2
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2015 19:15:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL8qYTO3uurrxQBjfPDNL2hamxh4+GCuzX0mxsEw=+go5CPWcQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ruchi Kandoi <kandoiruchi@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vladimir Davydov <vdavydov@parallels.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Davidlohr Bueso <dave@stgolabs.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 15-05-15, 17:55, Ruchi Kandoi wrote:
> Some of the hand-held devices support hot-plugging of the cpus and
> when the core is hot-plugged out the
> /sys/devices/system/cpu/cpuX/cpufreq directory is removed too. So it
> won't be possible to share folders by multiple CPUs.

Okay, that is changing now..

http://permalink.gmane.org/gmane.linux.power-management.general/59841

-- 
viresh
