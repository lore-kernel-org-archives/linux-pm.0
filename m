From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH] PM / QoS: Fix default runtime_pm device resume latency
Date: Tue, 31 Oct 2017 17:37:50 +0200
Message-ID: <87r2tje3ap.fsf@intel.com>
References: <1509347446-26105-1-git-send-email-t-kristo@ti.com> <CAJZ5v0i8HMDfV907QDTD54YPaFpoBLVt+R4oeQ704+9_C8APoA@mail.gmail.com> <3227682.nATp9NGxKU@aspire.rjw.lan> <CAMuHMdVKh9n4aep+niyYYEA_4cNrB4+BfGWrJ3WLpej1me114w@mail.gmail.com> <CAMuHMdW3AJFZQVDPTcpL-UMRxNThcOpQxNz6yTx9qDP7SQ-kLg@mail.gmail.com> <CAMuHMdX4WjXZQrP9QMGFV8sbntOUvfZ4y-uQSS4_4ArrCjsxWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdX4WjXZQrP9QMGFV8sbntOUvfZ4y-uQSS4_4ArrCjsxWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tero Kristo <t-kristo@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Lofstedt, Marta" <marta.lofstedt@intel.com>, "Peres, Martin" <martin.peres@intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 31 Oct 2017, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Rafael, Tero,
>
> CC pinchartl, dri-devel

Cc: Marta, Martin

Our CI is hitting this too.

BR,
Jani.

>
> On Tue, Oct 31, 2017 at 2:10 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> CC linux-renesas-soc
>>
>> On Tue, Oct 31, 2017 at 2:09 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> On Tue, Oct 31, 2017 at 12:27 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>> On Monday, October 30, 2017 11:19:08 AM CET Rafael J. Wysocki wrote:
>>>>> On Mon, Oct 30, 2017 at 8:10 AM, Tero Kristo <t-kristo@ti.com> wrote:
>>>>> > The recent change to the PM QoS framework to introduce a proper
>>>>> > no constraint value overlooked to handle the devices which don't
>>>>> > implement PM QoS OPS. Runtime PM is one of the more severely
>>>>> > impacted subsystems, failing every attempt to runtime suspend
>>>>> > a device. This leads into some nasty second level issues like
>>>>> > probe failures and increased power consumption among other things.
>>>>>
>>>>> Oh, that's bad.
>>>>>
>>>>> Sorry about breaking it and thanks for the fix!
>>>>>
>>>>> > Fix this by adding a proper return value for devices that don't
>>>>> > implement PM QoS implicitly.
>>>>> >
>>>>> > Fixes: 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")
>>>>> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>>> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> Applied.
>>>>
>>>> And pushed to Linus.
>>>
>>> I'm afraid it is not sufficient.
>>>
>>> Commit 0cc2b4e5a020fc7f ("PM / QoS: Fix device resume latency PM QoS")
>>> introduced two issues on Renesas platforms:
>>>  1. After boot up, many devices have changed their state from "suspended"
>>>     to "active", according to /sys/kernel/debug/pm_genpd/pm_genpd_summary
>>>     (comparing that file across boots is one of my standard tests).
>>>     Interestingly, doing a system suspend/resume cycle restores their state
>>>     to "suspended".
>>>
>>>  2. During system suspend, the following warning is printed on
>>>     r8a7791/koelsch:
>>>
>>>         i2c-rcar e6530000.i2c: runtime PM trying to suspend device but
>>> active child
>
>  3. I've just bisected a seemingly unrelated issue to the same commit.
>     On Salvator-XS with R-Car H3, initialization of the rcar-du driver now
>     takes more than 1 minute due to flip_done time outs, while it took 0.12s
>     before:
>
>     [    3.015035] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
>     [    3.021721] [drm] No driver support for vblank timestamp query.
>     [   13.280738] [drm:drm_atomic_helper_wait_for_flip_done] *ERROR*
> [CRTC:58:crtc-3] flip_done timed out
>     [   23.520707] [drm:drm_atomic_helper_commit_cleanup_done] *ERROR*
> [CRTC:58:crtc-3] flip_done timed out
>     [   33.760708] [drm:drm_atomic_helper_wait_for_flip_done] *ERROR*
> [CRTC:58:crtc-3] flip_done timed out
>     [   44.000755] [drm:drm_atomic_helper_commit_cleanup_done] *ERROR*
> [CRTC:58:crtc-3] flip_done timed out
>     [   44.003597] Console: switching to colour frame buffer device 128x48
>     [   54.240707] [drm:drm_atomic_helper_wait_for_flip_done] *ERROR*
> [CRTC:58:crtc-3] flip_done timed out
>     [   64.480706] [drm:drm_atomic_helper_commit_cleanup_done] *ERROR*
> [CRTC:58:crtc-3] flip_done timed out
>     [   64.544876] rcar-du feb00000.display: fb0:  frame buffer device
>     [   64.552013] [drm] Initialized rcar-du 1.0.0 20130110 for
> feb00000.display on minor 0
>     [   64.559873] [drm] Device feb00000.display probed
>
>>> Commit 2a9a86d5c81389cd ("PM / QoS: Fix default runtime_pm device resume
>>> latency") fixes the second issue, but not the first.
>
> ... nor the third.
>
>>> Reverting commits 2a9a86d5c81389cd ("PM / QoS: Fix default runtime_pm
>>> device resume latency") and 0cc2b4e5a020fc7f ("PM / QoS: Fix device resume
>>> latency PM QoS") fixes both.
>
> ... all three.
>
>>> Do you have a clue?
>>> Thanks!


-- 
Jani Nikula, Intel Open Source Technology Center
