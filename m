From: Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 18/18] cpupower: change strncpy+truncation to strlcpy
Date: Tue, 14 Aug 2018 21:27:28 +0200
Message-ID: <20180814192728.GA6264@nautica>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
 <1531445169-19912-1-git-send-email-asmadeus@codewreck.org>
 <CAEUSe78K3bxfXp8mAoxtd64ZeBFVN4v0sJ+puvffM_ZkUNsW+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEUSe78K3bxfXp8mAoxtd64ZeBFVN4v0sJ+puvffM_ZkUNsW+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel =?utf-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, Colin Ian King <colin.king@canonical.com>, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Daniel Díaz wrote on Tue, Aug 14, 2018:
> I can't get cpupower to compile anymore now that it made its way to linux-next:
>   [/linux/tools/power/cpupower]$ make
>     CC       lib/cpufreq.o
>   [...]
>   make[1]: Entering directory '/linux/tools/power/cpupower/bench'
>     CC       main.o
>     CC       parse.o
>   parse.c: In function ‘prepare_config’:
>   parse.c:224:4: warning: implicit declaration of function ‘strlcpy’
> [-Wimplicit-function-declaration]
>       strlcpy(config->governor, val,
>       ^
>     CC       system.o
>     CC       benchmark.o
>     CC       cpufreq-bench
>   .//parse.o: In function `prepare_config':
>   /linux/tools/power/cpupower/bench/parse.c:224: undefined reference
> to `strlcpy'
>   collect2: error: ld returned 1 exit status
>   Makefile:25: recipe for target 'cpufreq-bench' failed
>   make[1]: *** [cpufreq-bench] Error 1
>   make[1]: Leaving directory '/linux/tools/power/cpupower/bench'
>   Makefile:258: recipe for target 'compile-bench' failed
>   make: *** [compile-bench] Error 2
> 
> Does it need anything special to make?

Ugh, no, I am really ashamed about this patch series for insufficient
testing in general. It is currently "under rework" for an indefinite
time frame as I have had other priorities but I'll add cpupower to the
list...
More precisely, the function is defined in the linux kernel but for
userspace strlcpy is only available through libbsd, and I don't believe
we should pull that in just for this.

I'll send a second patch using snprintf and warning if a truncation
occurs (which is the proper fix that the gcc folks intended people to do
anyway) when I get around to it, but I would recommend to just revert
the patch for now.


Shuah, could you take the patch off please if you haven't pushed it to
linus yet?


Sorry for the time you might have spent on this,
-- 
Dominique Martinet
