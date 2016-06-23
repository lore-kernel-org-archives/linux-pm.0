From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [LKP] [PATCH] x86: fix rdmsr MSR_PLATFORM_INFO unsafe warning in
 kvm guest
Date: Thu, 23 Jun 2016 15:41:10 +0800
Message-ID: <CANRm+Cwgr27rDiakOhtLcK=PB50BAU-dXLcGpa4uWO-YXqhOBg@mail.gmail.com>
References: <1466558908-3524-1-git-send-email-wanpeng.li@hotmail.com>
 <alpine.DEB.2.11.1606230908140.5839@nanos> <CADjb_WRQDYKoYqmfpfhHN_5rui_90rS0DD2JxRh6d5Wp5TMsgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CADjb_WRQDYKoYqmfpfhHN_5rui_90rS0DD2JxRh6d5Wp5TMsgQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Yu Chen <yu.chen.surf@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, kvm <kvm@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jacob Pan <jacob.jun.pan@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Rui <rui.zhang@intel.com>, lkp@01.org, Wanpeng Li <wanpeng.li@hotmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Yu=EF=BC=8C
2016-06-23 15:37 GMT+08:00 Yu Chen <yu.chen.surf@gmail.com>:
> On Thu, Jun 23, 2016 at 3:09 PM, Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>> On Wed, 22 Jun 2016, Wanpeng Li wrote:
>>> After commit (fc141535ad8 : "x86 tsc_msr: Extend to include Intel C=
ore
>>
>> Where did you find that commit? It's neither in Linus tree nor in ti=
p.
>>
> It is in Len's tree, we are planing to resend the patchset with Wanpe=
ng's fix
> merged with a credit to him in commit msg, thanks for Wanpeng's effor=
t.
> thanks all.

I prefer this patch can be applied separately instead of fold into the
bad commit since it shows the issue when access MSR_PLATFORM_INFO in
kvm guest and other guys who want to access MSR_PLATFORM_INFO later
can find the changelog and make better decisions.

Regards,
Wanpeng Li
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
