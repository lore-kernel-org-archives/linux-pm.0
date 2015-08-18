From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH] x86, suspend: Save/restore THERM_CONTROL register for
 suspend
Date: Tue, 18 Aug 2015 16:54:05 +0800
Message-ID: <55D2F2AD.20208@intel.com>
References: <1439800192-3034-1-git-send-email-yu.c.chen@intel.com> <20150817101115.GA27204@gmail.com> <20150817132726.GA11047@amd> <55D2972C.3030709@intel.com> <20150818080218.GA17017@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150818080218.GA17017@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Ingo Molnar <mingo@kernel.org>, rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rui.zhang@intel.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!
On 08/18/2015 04:02 PM, Pavel Machek wrote:
> Hi!
>
>>>>> A bug is reported(https://bugzilla.redhat.com/show_bug.cgi?id=1227208)
>>>
>>> Access denied :-(
>>>
>> Might need to register for accessing.
>>>
>>> What HW is this on?
>>>
>> Intel Braswell and Broadwell, detail for Broadwell:
>> Platform: MayanCity
>> Processor: 2x BROADWELL BDX_EP A0 QHPR
>> Chipset: Wellsburg B1 QR7E
>
> So it is desktop board?
>
It is a server of Xeon family.

>>> Doing this unconditionally is asking for trouble. Blacklist entry with
>>> affected BIOS info might be acceptable, but...
>>>
>> you mean a quirk here(accroding to dmi info ,etc)?
>
> Yes, please.
Will do. thanks
> 									Pavel
>

Best Regards,
Yu
