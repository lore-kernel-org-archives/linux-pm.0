From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/5] updates for intel_pstate
Date: Thu, 08 May 2014 22:30:44 +0200
Message-ID: <3320314.vMXib5RYFF@vostro.rjw.lan>
References: <1399579047-5792-1-git-send-email-dirk.j.brandewie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399579047-5792-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dirk.brandewie@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Dirk Brandewie <dirk.j.brandewie@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, May 08, 2014 12:57:22 PM dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
> 
> Patches 1-4 are bugfixes.  Patch 4 specifically removes the wreckage
> caused by C0 tracking change. 

I would appreciate sending such stuff before the -rc4 time frame.

> Patch 5 Adds new CPU IDs for the Broadwell processors.
> 
> Dirk Brandewie (5):
>   intel_pstate: Set turbo VID for Baytrail
>   intel_pstate: remove setting P state to MAX on init
>   intel_pstate: Fix fixed point rounding macro
>   intel_pstate: Remove C0 tracking
>   intel_pstate: Add CPU IDs for Broadwell processors
> 
>  drivers/cpufreq/intel_pstate.c | 52 +++++++++++++++++-------------------------
>  1 file changed, 21 insertions(+), 31 deletions(-)

I'll queue them up for 3.15-rc6, but that's a bit too late.

Next time I may just wait for the next merge window, fixes or not.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
