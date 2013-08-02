From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [GIT PULL] ACPI and power management fixes for v3.11-rc4
Date: Fri, 2 Aug 2013 14:12:49 -0500
Message-ID: <CAMP44s2a2HqohWL9d+i3cpifJiUfidTw_ZfO3PttvhMn_hGE1A@mail.gmail.com>
References: <2052880.bHfzt6NKt5@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2052880.bHfzt6NKt5@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 2, 2013 at 9:29 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> ---------------
>
> Colin Cross (1):
>       freezer: set PF_SUSPEND_TASK flag on tasks that call freeze_processes
>
> Lan Tianyu (1):
>       ACPI / battery: Fix parsing _BIX return value
>
> Rafael J. Wysocki (3):
>       Revert "cpuidle: Quickly notice prediction failure in general case"
>       Revert "cpuidle: Quickly notice prediction failure for repeat mode"
>       cpufreq: Fix cpufreq driver module refcount balance after suspend/resume
>
> ---------------

You forgot this patch:

https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=3706231332d57072e0e2c0e59975443f3f18e673

Or do you think it's fine to boot these machines into a black screen?

-- 
Felipe Contreras
