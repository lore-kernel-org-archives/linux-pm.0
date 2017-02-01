From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Linux v4.10.0-rc1+] Still call-traces after
 suspend-resume (pm? i915? cpu/hotplug?)
Date: Wed, 1 Feb 2017 01:22:47 +0100
Message-ID: <CAJZ5v0gaVL1zkVdb3G8p=Lgk5fX8fB2pv-RR54j8_UTd9PYFmA@mail.gmail.com>
References: <CA+icZUVydvidHHeWn7=ni1Kxr0y1kaRLKMWCPQi2YY5c_xNL_Q@mail.gmail.com>
 <CAJZ5v0gp_BwxR+B3wtoLRh2B_ojY7cd9E5shJ8zsBeGL_LtnGg@mail.gmail.com>
 <CA+icZUVwTRCAGiO-5Q2uo8SETjHwwSmJ2Pxh56niWsbEVZfV7w@mail.gmail.com>
 <7e7ccb13-1db8-af76-9585-ca7bbdd04c55@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113f05f85ec53205476d0c5e
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <7e7ccb13-1db8-af76-9585-ca7bbdd04c55@intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: sedat.dilek@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx <intel-gfx@lists.freedesktop.org>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

--001a113f05f85ec53205476d0c5e
Content-Type: text/plain; charset=UTF-8

On Mon, Jan 30, 2017 at 11:44 PM, Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
> On 1/24/2017 2:33 AM, Sedat Dilek wrote:
>>
>> On Fri, Dec 30, 2016 at 3:02 PM, Rafael J. Wysocki <rafael@kernel.org>
>> wrote:
>>>
>>> On Fri, Dec 30, 2016 at 12:40 PM, Sedat Dilek <sedat.dilek@gmail.com>
>>> wrote:
>>>>
>>>> Hi,
>>>>
>>>> I have already reported this issue in [1].
>>>> One of the issue was solved.
>>>> Unfortunately, it looks like there is still a different problem here
>>>> (Ubuntu/precise AMD64).
>>>>
>>>> I tried v4.10-rc1 and latest Linus tree up to...
>>>>
>>>> commit 98473f9f3f9bd404873cd1178c8be7d6d619f0d1
>>>> "mm/filemap: fix parameters to test_bit()"
>>>>
>>>> Here we go...
>>>>
>>>> [   29.636047] BUG: sleeping function called from invalid context at
>>>> drivers/base/power/runtime.c:1032
>>>> [   29.636055] in_atomic(): 1, irqs_disabled(): 0, pid: 1500, name: Xorg
>>>> [   29.636058] 1 lock held by Xorg/1500:
>>>> [   29.636060]  #0:  (&dev->struct_mutex){+.+.+.}, at:
>>>> [<ffffffffa0680c13>] i915_mutex_lock_interruptible+0x43/0x140 [i915]
>>>> [   29.636107] CPU: 0 PID: 1500 Comm: Xorg Not tainted
>>>> 4.10.0-rc1-6-iniza-amd64 #1
>>>> [   29.636109] Hardware name: SAMSUNG ELECTRONICS CO., LTD.
>>>> 530U3BI/530U4BI/530U4BH/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28/2013
>>>> [   29.636111] Call Trace:
>>>> [   29.636120]  dump_stack+0x85/0xc2
>>>> [   29.636124]  ___might_sleep+0x196/0x260
>>>> [   29.636127]  __might_sleep+0x53/0xb0
>>>> [   29.636131]  __pm_runtime_resume+0x7a/0x90
>>>> [   29.636159]  intel_runtime_pm_get+0x25/0x90 [i915]
>>>> [   29.636189]  aliasing_gtt_bind_vma+0xaa/0xf0 [i915]
>>>> [   29.636220]  i915_vma_bind+0xaf/0x1e0 [i915]
>>>> [   29.636248]  i915_gem_execbuffer_relocate_entry+0x513/0x6f0 [i915]
>>>> [   29.636272]  i915_gem_execbuffer_relocate_vma.isra.34+0x188/0x250
>>>> [i915]
>>>> [   29.636275]  ? trace_hardirqs_on+0xd/0x10
>>>> [   29.636294]  ? i915_gem_execbuffer_reserve_vma.isra.31+0x152/0x1f0
>>>> [i915]
>>>> [   29.636316]  ? i915_gem_execbuffer_reserve.isra.32+0x372/0x3a0 [i915]
>>>> [   29.636342]  i915_gem_do_execbuffer.isra.38+0xa70/0x1a40 [i915]
>>>> [   29.636347]  ? __might_fault+0x4e/0xb0
>>>> [   29.636373]  i915_gem_execbuffer2+0xc5/0x260 [i915]
>>>> [   29.636376]  ? __might_fault+0x4e/0xb0
>>>> [   29.636395]  drm_ioctl+0x206/0x450 [drm]
>>>> [   29.636420]  ? i915_gem_execbuffer+0x340/0x340 [i915]
>>>> [   29.636425]  ? __fget+0x5/0x200
>>>> [   29.636429]  do_vfs_ioctl+0x91/0x6f0
>>>> [   29.636431]  ? __fget+0x111/0x200
>>>> [   29.636433]  ? __fget+0x5/0x200
>>>> [   29.636436]  SyS_ioctl+0x79/0x90
>>>> [   29.636441]  entry_SYSCALL_64_fastpath+0x23/0xc6
>>>>
>>>> On suspend/resume I see the same call trace.
>>>> [2] points to the "BUG" line.
>>>
>>> Well, this appears to be an i915 issue, but not a serious one.
>>>
>>> Clearly, a function that may sleep (pm_runtime_get_sync() in
>>> intel_runtime_pm_get()) is called with disabled interrupts.  If I
>>> understand the code correctly, though, it actually is not going to
>>> sleep in this particular case, because pm_runtime_get_sync() has
>>> already been called once for this device in the same code path which
>>> means that this particular instance will return immediately, so this
>>> is a false-positive (most likely).
>>>
>>> Let me see if I the might_sleep_if() assertion in
>>> __pm_runtime_resume(() can be moved to a better place.
>>>
>> Hi Rafael,
>>
>> did you had a chance to look at this?
>> The problem still remains in Linux v4.10-rc5.
>
>
> No, I didn't.
>
> As I said, this is not a serious issue.

Something like the attached (untested).

Please try it and let me know if it makes the splat go away.

Thanks,
Rafael

--001a113f05f85ec53205476d0c5e
Content-Type: text/x-patch; charset=US-ASCII; name="pm-runtime-assertions.patch"
Content-Disposition: attachment; filename="pm-runtime-assertions.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iym7kw0h0

LS0tCiBkcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jIHwgICAxMSArKysrKystLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCkluZGV4OiBsaW51
eC1wbS9kcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBt
Lm9yaWcvZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRpbWUuYworKysgbGludXgtcG0vZHJpdmVycy9i
YXNlL3Bvd2VyL3J1bnRpbWUuYwpAQCAtOTY2LDEzICs5NjYsMTMgQEAgaW50IF9fcG1fcnVudGlt
ZV9pZGxlKHN0cnVjdCBkZXZpY2UgKmRldgogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAJaW50IHJl
dHZhbDsKIAotCW1pZ2h0X3NsZWVwX2lmKCEocnBtZmxhZ3MgJiBSUE1fQVNZTkMpICYmICFkZXYt
PnBvd2VyLmlycV9zYWZlKTsKLQogCWlmIChycG1mbGFncyAmIFJQTV9HRVRfUFVUKSB7CiAJCWlm
ICghYXRvbWljX2RlY19hbmRfdGVzdCgmZGV2LT5wb3dlci51c2FnZV9jb3VudCkpCiAJCQlyZXR1
cm4gMDsKIAl9CiAKKwltaWdodF9zbGVlcF9pZighKHJwbWZsYWdzICYgUlBNX0FTWU5DKSAmJiAh
ZGV2LT5wb3dlci5pcnFfc2FmZSk7CisKIAlzcGluX2xvY2tfaXJxc2F2ZSgmZGV2LT5wb3dlci5s
b2NrLCBmbGFncyk7CiAJcmV0dmFsID0gcnBtX2lkbGUoZGV2LCBycG1mbGFncyk7CiAJc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmZGV2LT5wb3dlci5sb2NrLCBmbGFncyk7CkBAIC05OTgsMTMgKzk5
OCwxMyBAQCBpbnQgX19wbV9ydW50aW1lX3N1c3BlbmQoc3RydWN0IGRldmljZSAqCiAJdW5zaWdu
ZWQgbG9uZyBmbGFnczsKIAlpbnQgcmV0dmFsOwogCi0JbWlnaHRfc2xlZXBfaWYoIShycG1mbGFn
cyAmIFJQTV9BU1lOQykgJiYgIWRldi0+cG93ZXIuaXJxX3NhZmUpOwotCiAJaWYgKHJwbWZsYWdz
ICYgUlBNX0dFVF9QVVQpIHsKIAkJaWYgKCFhdG9taWNfZGVjX2FuZF90ZXN0KCZkZXYtPnBvd2Vy
LnVzYWdlX2NvdW50KSkKIAkJCXJldHVybiAwOwogCX0KIAorCW1pZ2h0X3NsZWVwX2lmKCEocnBt
ZmxhZ3MgJiBSUE1fQVNZTkMpICYmICFkZXYtPnBvd2VyLmlycV9zYWZlKTsKKwogCXNwaW5fbG9j
a19pcnFzYXZlKCZkZXYtPnBvd2VyLmxvY2ssIGZsYWdzKTsKIAlyZXR2YWwgPSBycG1fc3VzcGVu
ZChkZXYsIHJwbWZsYWdzKTsKIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkZXYtPnBvd2VyLmxv
Y2ssIGZsYWdzKTsKQEAgLTEwMjksNyArMTAyOSw4IEBAIGludCBfX3BtX3J1bnRpbWVfcmVzdW1l
KHN0cnVjdCBkZXZpY2UgKmQKIAl1bnNpZ25lZCBsb25nIGZsYWdzOwogCWludCByZXR2YWw7CiAK
LQltaWdodF9zbGVlcF9pZighKHJwbWZsYWdzICYgUlBNX0FTWU5DKSAmJiAhZGV2LT5wb3dlci5p
cnFfc2FmZSk7CisJbWlnaHRfc2xlZXBfaWYoIShycG1mbGFncyAmIFJQTV9BU1lOQykgJiYgIWRl
di0+cG93ZXIuaXJxX3NhZmUgJiYKKwkJCWRldi0+cG93ZXIucnVudGltZV9zdGF0dXMgIT0gUlBN
X0FDVElWRSk7CiAKIAlpZiAocnBtZmxhZ3MgJiBSUE1fR0VUX1BVVCkKIAkJYXRvbWljX2luYygm
ZGV2LT5wb3dlci51c2FnZV9jb3VudCk7Cg==
--001a113f05f85ec53205476d0c5e
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--001a113f05f85ec53205476d0c5e--
