From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH] x86: Kill E820_RESERVED_KERN
Date: Wed, 19 Aug 2015 14:37:03 +0800
Message-ID: <55D4240F.80407@intel.com>
References: <1438111315-2230-1-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1438111315-2230-1-git-send-email-yinghai@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Richard L Maliszewski <richard.l.maliszewski@intel.com>, Gang Wei <gang.wei@intel.com>, Shane Wang <shane.wang@intel.com>, tboot-devel@lists.sourceforge.net, stable@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lenb@kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,
On 07/29/2015 03:21 AM, Yinghai Lu wrote:
> E820_RESERVED_KERN was introduced to do early allocation for
> setup_data when we were using original early_res with e820 map.
>
> Now we are using memblock to do early resource reserve/allocation, and
> setup_data is reserved in memblock early already.
>
> For kexec path, kexec generate setup_data (Now kexec-tools create SETUP_EFI
> and SETUP_E820_EXT), and pass pointer to second kernel, and
> second kernel reserve setup_data by their own without using e820 map.
>
> So we do not need to touch e820 map at all, and we can kill
> E820_RESERVED_KERN.
>
> That make the code simpler, and at same time that will fix bug with
> hibernation:
>    mark_nonsave_region that can not handle that case:
>      E820_RAM and E820_RESERVED_KERN ranges are continuous and
>      boundary is not page aligned.
>
> Link: https://bugzilla.opensuse.org/show_bug.cgi?id=913885
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96111

I've tested Hibernation on latest 4.2.-rc7 and encountered panic when
resuming, so I guess this patch has not been merged upstream:

BUG: unable to handle kernel paging request at ffff880085894000
IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70

With current patch and Lee, Chun-Yi's patch applied, the panic
disappeared, would someone please have a look at this patch,
thanks a lot.

Best Regards,
Yu
