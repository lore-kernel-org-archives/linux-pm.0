From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / QoS: Fix default runtime_pm device resume latency
Date: Tue, 31 Oct 2017 18:22:19 +0100
Message-ID: <CAJZ5v0guHP=icMiRBZ1B4oWQVxrtN2Nt+aE_V1646PfpsKkiJg@mail.gmail.com>
References: <1509347446-26105-1-git-send-email-t-kristo@ti.com>
 <CAJZ5v0i8HMDfV907QDTD54YPaFpoBLVt+R4oeQ704+9_C8APoA@mail.gmail.com>
 <3227682.nATp9NGxKU@aspire.rjw.lan> <CAMuHMdVKh9n4aep+niyYYEA_4cNrB4+BfGWrJ3WLpej1me114w@mail.gmail.com>
 <CAMuHMdW3AJFZQVDPTcpL-UMRxNThcOpQxNz6yTx9qDP7SQ-kLg@mail.gmail.com> <CAMuHMdX4WjXZQrP9QMGFV8sbntOUvfZ4y-uQSS4_4ArrCjsxWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="94eb2c0439ee578ba5055cdaff2d"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdX4WjXZQrP9QMGFV8sbntOUvfZ4y-uQSS4_4ArrCjsxWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tero Kristo <t-kristo@ti.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, DRI Development <dri-devel@lists.freedesktop.org>
List-Id: linux-pm@vger.kernel.org

--94eb2c0439ee578ba5055cdaff2d
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 31, 2017 at 2:55 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Rafael, Tero,
>
> CC pinchartl, dri-devel
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

Sorry for the breakage.

OK, I'll just push the reverts to Linus later today.

>>> Do you have a clue?

Well, kind of.

There is a change in behavior in domain_governor.c that should not
have made any difference to my eyes, but maybe that's it.

Can you please check if the attached patch makes any difference?

Thanks,
Rafael

--94eb2c0439ee578ba5055cdaff2d
Content-Type: text/x-patch; charset="US-ASCII"; name="pm-domain-qos-fixup.patch"
Content-Disposition: attachment; filename="pm-domain-qos-fixup.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j9fvqdg80

LS0tCiBkcml2ZXJzL2Jhc2UvcG93ZXIvZG9tYWluX2dvdmVybm9yLmMgfCAgIDExICsrKysrLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKSW5k
ZXg6IGxpbnV4LXBtL2RyaXZlcnMvYmFzZS9wb3dlci9kb21haW5fZ292ZXJub3IuYwo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09Ci0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvYmFzZS9wb3dlci9kb21haW5fZ292ZXJub3Iu
YworKysgbGludXgtcG0vZHJpdmVycy9iYXNlL3Bvd2VyL2RvbWFpbl9nb3Zlcm5vci5jCkBAIC04
MywxMiArODMsMTEgQEAgc3RhdGljIGJvb2wgZGVmYXVsdF9zdXNwZW5kX29rKHN0cnVjdCBkZQog
CQl0ZC0+Y2FjaGVkX3N1c3BlbmRfb2sgPSB0cnVlOwogCX0gZWxzZSB7CiAJCWNvbnN0cmFpbnRf
bnMgLT0gdGQtPnN1c3BlbmRfbGF0ZW5jeV9ucyArIHRkLT5yZXN1bWVfbGF0ZW5jeV9uczsKLQkJ
aWYgKGNvbnN0cmFpbnRfbnMgPiAwKSB7Ci0JCQl0ZC0+ZWZmZWN0aXZlX2NvbnN0cmFpbnRfbnMg
PSBjb25zdHJhaW50X25zOwotCQkJdGQtPmNhY2hlZF9zdXNwZW5kX29rID0gdHJ1ZTsKLQkJfSBl
bHNlIHsKLQkJCXRkLT5lZmZlY3RpdmVfY29uc3RyYWludF9ucyA9IDA7Ci0JCX0KKwkJaWYgKGNv
bnN0cmFpbnRfbnMgPT0gMCkKKwkJCXJldHVybiBmYWxzZTsKKworCQl0ZC0+ZWZmZWN0aXZlX2Nv
bnN0cmFpbnRfbnMgPSBjb25zdHJhaW50X25zOworCQl0ZC0+Y2FjaGVkX3N1c3BlbmRfb2sgPSBj
b25zdHJhaW50X25zID49IDA7CiAJfQogCiAJLyoK
--94eb2c0439ee578ba5055cdaff2d--
