From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 0/9] i2c: move handling of suspended adapters to the
 core
Date: Wed, 26 Dec 2018 12:46:40 +0100
Message-ID: <5ffe2d98-696e-4cc2-51d0-9cc7dc936d7e@redhat.com>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdUyxcYcT7uAhsQ0xa++yzi3TnBhNS90O6Achz3KD6E4dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUyxcYcT7uAhsQ0xa++yzi3TnBhNS90O6Achz3KD6E4dA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 26-12-18 12:01, Geert Uytterhoeven wrote:
> Hi Wolfram,
> 
> On Sat, Dec 22, 2018 at 9:26 PM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
>> Here is the new version without specific I2C helpers but using the
>> 'is_suspended' flag from the PM core. I didn't like messing with the
>> flag directly, so I did a helper in patch 1. So far, I like the
>> approach. The diffstat looks nice, and i2c-rcar.c and i2c-sh_mobile.c
>> rejected rightfully too later transfers without further modifications.
>> Tested on a Renesas Lager board (R-Car H2).
>>
>> I dropped a few Tested-by tags because I think this approach is too
>> different from V1 to keep them. I hope you guys can have a look again.
>> Thanks for all the testing, so far!
>>
>> A branch can be found here:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/reject-when-suspended
>>
>> If this series is acceptable, I'd suggest to take it via my i2c tree
>> after rc1. And then I'll provide an immutable branch for the PM tree to
>> pick. Let me know if this works for you.
> 
> This breaks resume of the CS2000 clock driver on Salvator-X(S) (and
> presumable ULCB, too):
> 
>      Accessing already suspended I2C/SMBus adapter
>      WARNING: CPU: 1 PID: 1186 at drivers/i2c/i2c-core-smbus.c:551
> __i2c_smbus_xfer+0x38/0x66c
>      Modules linked in:
>      CPU: 1 PID: 1186 Comm: s2idle Not tainted
> 4.20.0-salvator-x-08442-ge5992c41ac706409 #264
>      Hardware name: Renesas Salvator-X board based on r8a7795 ES1.x (DT)
>      pstate: 60400005 (nZCv daif +PAN -UAO)
>      pc : __i2c_smbus_xfer+0x38/0x66c
>      lr : __i2c_smbus_xfer+0x38/0x66c
>      sp : ffffff8013413880
>      x29: ffffff8013413880 x28: ffffffc6f78b4820
>      x27: 0000000000000010 x26: ffffff8010cf6178
>      x25: ffffff8013413976 x24: 0000000000000002
>      x23: 0000000000000016 x22: ffffffc6f7872088
>      x21: 0000000000000000 x20: 000000000000004f
>      x19: ffffffc6f7872088 x18: 000000000000000a
>      x17: 0000000000000000 x16: 0000000000000000
>      x15: 0000000000029c80 x14: 0720072007200720
>      x13: 0720072007200720 x12: 0720072007200720
>      x11: 0720072007200720 x10: 0720072007200720
>      x9 : ffffff801100e6d0 x8 : 6461207375424d53
>      x7 : ffffff8011c825c8 x6 : ffffff8011c82000
>      x5 : 0000000000000000 x4 : ffffff8013414000
>      x3 : ffffff80134136e0 x2 : 00000046ee875000
>      x1 : 82c6d7c720d64000 x0 : 0000000000000000
>      Call trace:
>       __i2c_smbus_xfer+0x38/0x66c
>       i2c_smbus_xfer+0x64/0x98
>       i2c_smbus_read_byte_data+0x40/0x6c
>       cs2000_bset.isra.1+0x2c/0x58
>       __cs2000_set_rate.constprop.7+0x8c/0x134
>       cs2000_resume+0x14/0x1c
>       dpm_run_callback+0x15c/0x2d8
>       device_resume_early+0x98/0xec
>       dpm_resume_early+0x3b0/0x454
>       suspend_devices_and_enter+0x7bc/0xbb0
> 
> The CS2000 driver uses SET_LATE_SYSTEM_SLEEP_PM_OPS().
> 
> Suspend/resume of the BD9571 driver works fine, as that one uses
> SET_SYSTEM_SLEEP_PM_OPS().

Ok, so this is the same thing I noticed, the approach using
the pm-core is_suspend flag only works for adapters which
suspend during the regular suspend phase and as such that
approach cannot work everywhere.

Regards,

Hans
