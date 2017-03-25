From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] hibernation: on 32-bit x86, disabled in favor of KASLR
Date: Sat, 25 Mar 2017 10:02:43 -0700
Message-ID: <CAGXu5jLehyQA_WZEsk66WMchm+nyGT8HOtto7GoEX_J=LHsLfA@mail.gmail.com>
References: <20170323002701.GA90470@beast> <58D3CC61.8080609@yandex.ru>
 <CAJZ5v0ipWcaRhKueF_0w+kXHXRLD7qvqxhk3RcWHeyWv=GV5Mw@mail.gmail.com> <58D6849B.1090106@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58D6849B.1090106@yandex.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Evgenii Shatokhin <eugene.shatokhin@yandex.ru>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Yu Chen <yu.chen.surf@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Sat, Mar 25, 2017 at 7:54 AM, Evgenii Shatokhin
<eugene.shatokhin@yandex.ru> wrote:
> On 23.03.2017 18:30, Rafael J. Wysocki wrote:
>>
>> On Thu, Mar 23, 2017 at 2:23 PM, Evgenii Shatokhin
>> <eugene.shatokhin@yandex.ru> wrote:
>>>
>>> On 23.03.2017 03:27, Kees Cook wrote:
>>>>
>>>>
>>>> This is a modified revert of commit 65fe935dd238 ("x86/KASLR, x86/power:
>>>> Remove x86 hibernation restrictions"), since it appears that 32-bit
>>>> hibernation still can't support KASLR. 64-bit is fine. Since people have
>>>> been running with KASLR by default on 32-bit since v4.8, this disables
>>>> hibernation (with a warning). Booting with "nokaslr" will disable KASLR
>>>> and enable hibernation.
>>>>
>>>> Reported-by: Evgenii Shatokhin <eugene.shatokhin@yandex.ru>
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>> Cc: stable@vger.kernel.org # v4.8+
>>>
>>>
>>>
>>> The patch does not work as intended on my system, unfortunately.
>>>
>>> I tried the mainline kernel v4.11-rc3 and added this patch. With
>>> "nokaslr"
>>> in the kernel command line, the system fails to hibernate. It complains
>>> this
>>> way in the log:
>>>
>>> <...>
>>> kernel: PM: writing image.
>>> kernel: PM: Cannot find swap device, try swapon -a.
>>> kernel: PM: Cannot get swap writer
>>> kernel: PM: Basic memory bitmaps freed
>>> kernel: Restarting tasks ... done.
>>> systemd[1]: Time has been changed
>>> systemd[3948]: Time has been changed
>>> systemd[14825]: Time has been changed
>>> systemd[1]: systemd-hibernate.service: main process exited, code=exited,
>>> status=1/FAILURE
>>> systemd[1]: Failed to start Hibernate.
>>> <...>
>>>
>>> The swap device (swap file, actually) is available, however:
>>> -------------
>>> # swapon -s
>>> Filename  Type  Size    Used  Priority
>>> /swap     file  6297596 0     -1
>>> -------------
>>>
>>> I built the same kernel without this patch then, added "nokaslr" in the
>>> kernel command line again, and the system hibernates and resumes fine.
>>
>>
>> With the patch applied and "nokaslr" in the kernel command line, what
>> shows up when you do
>>
>> $ cat /sys/power/state
>>
>> ?
>
>
> freeze standby mem disk
>
> However, I think now that the patch itself is OK.
>
> I experimented with the patched kernel a bit more and found that hibernate
> does work when I place "nokaslr" before "resume=xxx resume_offset=xxx" in
> the kernel command line and does not work when I place "nokaslr" after these
> options. So I guess there is an issue with parsing of the kernel command
> line somewhere (dracut scripts? systemd? I do not know). If resume= or
> resume_offset= were corrupted, that might have been the reason why the
> system could not find the swap file when hibernating.
>
> Anyway, that issue is clearly unrelated to this patch and the patch itself
> works OK for me.
>
> Thanks a lot!
>
> Tested-by: Evgenii Shatokhin <eugene.shatokhin@yandex.ru>

Ah, right. Hm, that is kind of the fault of the patch (and the prior
disabling too). Let me see if I can find a better solution...

-Kees

-- 
Kees Cook
Pixel Security
