From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [LKP] [PATCH] x86: fix rdmsr MSR_PLATFORM_INFO unsafe warning in
 kvm guest
Date: Thu, 23 Jun 2016 16:00:09 +0800
Message-ID: <CANRm+CzXjODDjiSHeyHHeaAyLjrBBJ9QzmCtFsyxJc=Qe4KMZg@mail.gmail.com>
References: <1466558908-3524-1-git-send-email-wanpeng.li@hotmail.com>
 <alpine.DEB.2.11.1606230908140.5839@nanos> <CADjb_WRQDYKoYqmfpfhHN_5rui_90rS0DD2JxRh6d5Wp5TMsgQ@mail.gmail.com>
 <CANRm+Cwgr27rDiakOhtLcK=PB50BAU-dXLcGpa4uWO-YXqhOBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANRm+Cwgr27rDiakOhtLcK=PB50BAU-dXLcGpa4uWO-YXqhOBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu Chen <yu.chen.surf@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, kvm <kvm@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jacob Pan <jacob.jun.pan@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Rui <rui.zhang@intel.com>, lkp@01.org, Wanpeng Li <wanpeng.li@hotmail.com>
List-Id: linux-pm@vger.kernel.org

2016-06-23 15:41 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
> Hi Yu=EF=BC=8C
> 2016-06-23 15:37 GMT+08:00 Yu Chen <yu.chen.surf@gmail.com>:
>> On Thu, Jun 23, 2016 at 3:09 PM, Thomas Gleixner <tglx@linutronix.de=
> wrote:
>>> On Wed, 22 Jun 2016, Wanpeng Li wrote:
>>>> After commit (fc141535ad8 : "x86 tsc_msr: Extend to include Intel =
Core
>>>
>>> Where did you find that commit? It's neither in Linus tree nor in t=
ip.
>>>
>> It is in Len's tree, we are planing to resend the patchset with Wanp=
eng's fix
>> merged with a credit to him in commit msg, thanks for Wanpeng's effo=
rt.
>> thanks all.
>
> I prefer this patch can be applied separately instead of fold into th=
e
> bad commit since it shows the issue when access MSR_PLATFORM_INFO in
> kvm guest and other guys who want to access MSR_PLATFORM_INFO later
> can find the changelog and make better decisions.

Thomas, does it make sense to keep separate?

Regards,
Wanpeng Li
