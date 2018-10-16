From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] tools/power/cpupower: fix compilation with STATIC=true
Date: Tue, 16 Oct 2018 13:39:57 +0200
Message-ID: <2028892.8FmI4CMcI5@house>
References: <153968018626.397151.17942194042449956995.stgit@buzz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <153968018626.397151.17942194042449956995.stgit@buzz>
Sender: linux-kernel-owner@vger.kernel.org
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, October 16, 2018 10:56:26 AM CEST Konstantin Khlebnikov wrote:
> Rename duplicate sysfs_read_file into cpupower_read_sysfs and fix linking.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Acked-by: Thomas Renninger <trenn@suse.de>

Thanks!

> -       $(OUTPUT)../lib/cpufreq.o $(OUTPUT)../lib/sysfs.o
> +       $(OUTPUT)../lib/cpufreq.o $(OUTPUT)../lib/cpupower.o

I also looked at this and would only have fixed half of it (overseeing above
old leftover from cpupower lib introduction).
I guess, this patch from Konstantin is better and the correct solution.
