From: Yu Chen <yu.chen.surf@gmail.com>
Subject: Re: [PATCH] hibernation: on 32-bit x86, disabled in favor of KASLR
Date: Fri, 24 Mar 2017 00:38:30 +0800
Message-ID: <CADjb_WRD4b2sEfKMb4BOAAVUKyEVprju2+Hz_JPtm0EH4Oq6cQ@mail.gmail.com>
References: <20170323002701.GA90470@beast> <58D3CC61.8080609@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33133 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932113AbdCWQiw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 12:38:52 -0400
In-Reply-To: <58D3CC61.8080609@yandex.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Evgenii Shatokhin <eugene.shatokhin@yandex.ru>
Cc: Kees Cook <keescook@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-doc@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

Hi,

On Thu, Mar 23, 2017 at 9:23 PM, Evgenii Shatokhin
<eugene.shatokhin@yandex.ru> wrote:
> On 23.03.2017 03:27, Kees Cook wrote:
>>
>> This is a modified revert of commit 65fe935dd238 ("x86/KASLR, x86/power:
>> Remove x86 hibernation restrictions"), since it appears that 32-bit
>> hibernation still can't support KASLR. 64-bit is fine. Since people have
>> been running with KASLR by default on 32-bit since v4.8, this disables
>> hibernation (with a warning). Booting with "nokaslr" will disable KASLR
>> and enable hibernation.
>>
>> Reported-by: Evgenii Shatokhin <eugene.shatokhin@yandex.ru>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Cc: stable@vger.kernel.org # v4.8+
>
>
> The patch does not work as intended on my system, unfortunately.
>
> I tried the mainline kernel v4.11-rc3 and added this patch. With "nokaslr"
> in the kernel command line, the system fails to hibernate. It complains this
> way in the log:
Could you please send me your kernel config? I've built a 4.11-rc3
image and runs
it on my 32bit laptop and hibernate works on CONFIG_RANDOMIZE_BASE=y

Yu
