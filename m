From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] PM / QoS: Fix default runtime_pm device resume latency
Date: Wed, 1 Nov 2017 12:28:46 +0200
Message-ID: <42ddd99a-e279-0d64-d000-e70f356998d0@ti.com>
References: <1509347446-26105-1-git-send-email-t-kristo@ti.com>
 <CAJZ5v0i8HMDfV907QDTD54YPaFpoBLVt+R4oeQ704+9_C8APoA@mail.gmail.com>
 <3227682.nATp9NGxKU@aspire.rjw.lan>
 <CAMuHMdVKh9n4aep+niyYYEA_4cNrB4+BfGWrJ3WLpej1me114w@mail.gmail.com>
 <CAMuHMdW3AJFZQVDPTcpL-UMRxNThcOpQxNz6yTx9qDP7SQ-kLg@mail.gmail.com>
 <CAMuHMdX4WjXZQrP9QMGFV8sbntOUvfZ4y-uQSS4_4ArrCjsxWA@mail.gmail.com>
 <CAJZ5v0guHP=icMiRBZ1B4oWQVxrtN2Nt+aE_V1646PfpsKkiJg@mail.gmail.com>
 <CAMuHMdWiwURQ2MAvpQu-=0AZ+O8Ej=VzPE7bCJ+FWxL3D2n_cg@mail.gmail.com>
 <CAJZ5v0iHdSzAf2KSJ0r5-kVaa1eEohgoUhdOR9s-uLRFw7EC9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iHdSzAf2KSJ0r5-kVaa1eEohgoUhdOR9s-uLRFw7EC9w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, DRI Development <dri-devel@lists.freedesktop.org>
List-Id: linux-pm@vger.kernel.org

On 01/11/17 00:32, Rafael J. Wysocki wrote:
> On Tue, Oct 31, 2017 at 7:07 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> Hi Rafael,
>>
>> On Tue, Oct 31, 2017 at 6:22 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Tue, Oct 31, 2017 at 2:55 PM, Geert Uytterhoeven
>>> <geert@linux-m68k.org> wrote:
>>>> Hi Rafael, Tero,
>>>>
>>>> CC pinchartl, dri-devel
>>>>
>>>> On Tue, Oct 31, 2017 at 2:10 PM, Geert Uytterhoeven
>>>> <geert@linux-m68k.org> wrote:
>>>>> CC linux-renesas-soc
>>>>>
>>>>> On Tue, Oct 31, 2017 at 2:09 PM, Geert Uytterhoeven
>>>>> <geert@linux-m68k.org> wrote:
>>>>>> On Tue, Oct 31, 2017 at 12:27 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>>>> On Monday, October 30, 2017 11:19:08 AM CET Rafael J. Wysocki wrote:
>>>>>>>> On Mon, Oct 30, 2017 at 8:10 AM, Tero Kristo <t-kristo@ti.com> wrote:
>>>>>>>>> The recent change to the PM QoS framework to introduce a proper
>>>>>>>>> no constraint value overlooked to handle the devices which don't
>>>>>>>>> implement PM QoS OPS. Runtime PM is one of the more severely
>>>>>>>>> impacted subsystems, failing every attempt to runtime suspend
>>>>>>>>> a device. This leads into some nasty second level issues like
>>>>>>>>> probe failures and increased power consumption among other things.
>>>>>>>>
>>>>>>>> Oh, that's bad.
>>>>>>>>
>>>>>>>> Sorry about breaking it and thanks for the fix!
>>>>>>>>
>>>>>>>>> Fix this by adding a proper return value for devices that don't
>>>>>>>>> implement PM QoS implicitly.
>>>>>>>>>
>>>>>>>>> Fixes: 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")
>>>>>>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>>>>>>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>>>
>>>>>>>> Applied.
>>>>>>>
>>>>>>> And pushed to Linus.
>>>>>>
>>>>>> I'm afraid it is not sufficient.
>>>>>>
>>>>>> Commit 0cc2b4e5a020fc7f ("PM / QoS: Fix device resume latency PM QoS")
>>>>>> introduced two issues on Renesas platforms:
>>>>>>   1. After boot up, many devices have changed their state from "suspended"
>>>>>>      to "active", according to /sys/kernel/debug/pm_genpd/pm_genpd_summary
>>>>>>      (comparing that file across boots is one of my standard tests).
>>>>>>      Interestingly, doing a system suspend/resume cycle restores their state
>>>>>>      to "suspended".
>>>>>>
>>>>>>   2. During system suspend, the following warning is printed on
>>>>>>      r8a7791/koelsch:
>>>>>>
>>>>>>          i2c-rcar e6530000.i2c: runtime PM trying to suspend device but
>>>>>> active child
>>>>
>>>>   3. I've just bisected a seemingly unrelated issue to the same commit.
>>>>      On Salvator-XS with R-Car H3, initialization of the rcar-du driver now
>>>>      takes more than 1 minute due to flip_done time outs, while it took 0.12s
>>>>      before:
>>>>
>>>>      [    3.015035] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
>>>>      [    3.021721] [drm] No driver support for vblank timestamp query.
>>>>      [   13.280738] [drm:drm_atomic_helper_wait_for_flip_done] *ERROR*
>>>> [CRTC:58:crtc-3] flip_done timed out
>>>>      [   23.520707] [drm:drm_atomic_helper_commit_cleanup_done] *ERROR*
>>>> [CRTC:58:crtc-3] flip_done timed out
>>>>      [   33.760708] [drm:drm_atomic_helper_wait_for_flip_done] *ERROR*
>>>> [CRTC:58:crtc-3] flip_done timed out
>>>>      [   44.000755] [drm:drm_atomic_helper_commit_cleanup_done] *ERROR*
>>>> [CRTC:58:crtc-3] flip_done timed out
>>>>      [   44.003597] Console: switching to colour frame buffer device 128x48
>>>>      [   54.240707] [drm:drm_atomic_helper_wait_for_flip_done] *ERROR*
>>>> [CRTC:58:crtc-3] flip_done timed out
>>>>      [   64.480706] [drm:drm_atomic_helper_commit_cleanup_done] *ERROR*
>>>> [CRTC:58:crtc-3] flip_done timed out
>>>>      [   64.544876] rcar-du feb00000.display: fb0:  frame buffer device
>>>>      [   64.552013] [drm] Initialized rcar-du 1.0.0 20130110 for
>>>> feb00000.display on minor 0
>>>>      [   64.559873] [drm] Device feb00000.display probed
>>>>
>>>>>> Commit 2a9a86d5c81389cd ("PM / QoS: Fix default runtime_pm device resume
>>>>>> latency") fixes the second issue, but not the first.
>>>>
>>>> ... nor the third.
>>>>
>>>>>> Reverting commits 2a9a86d5c81389cd ("PM / QoS: Fix default runtime_pm
>>>>>> device resume latency") and 0cc2b4e5a020fc7f ("PM / QoS: Fix device resume
>>>>>> latency PM QoS") fixes both.
>>>>
>>>> ... all three.
>>>
>>> Sorry for the breakage.
>>>
>>> OK, I'll just push the reverts to Linus later today.
>>>
>>>>>> Do you have a clue?
>>>
>>> Well, kind of.
>>>
>>> There is a change in behavior in domain_governor.c that should not
>>> have made any difference to my eyes, but maybe that's it.
>>>
>>> Can you please check if the attached patch makes any difference?
>>
>> Thanks, but it doesn't seem to fix the issues.
> 
> Thanks for testing!
> 
> I've just pushed the reverts, but the PM QoS still needs to be fixed,
> so we have to get to the bottom of this.
> 
> The current theory goes that the changes in domain_governor.c are to
> blame.  Is genpd involved in all of the issues with the PM QoS fix you
> have seen?
> 
> Thanks,
> Rafael
> 

It seems the default values for pm_qos have changed with the patch, and 
that breaks genpd at least. I only fixed PM runtime initially, but you 
could try this diff to fix the genpd part also:

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index d68b056..7c8f643 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -34,9 +34,9 @@ enum pm_qos_flags_status {
  #define PM_QOS_NETWORK_LAT_DEFAULT_VALUE       (2000 * USEC_PER_SEC)
  #define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE        0
  #define PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE  0
-#define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE    0
+#define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE    PM_QOS_LATENCY_ANY
  #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT    PM_QOS_LATENCY_ANY
-#define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE 0
+#define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE (-1)
  #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT (-1)

  #define PM_QOS_FLAG_NO_POWER_OFF       (1 << 0)
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
