From: Robert =?ISO-8859-1?Q?Sch=F6ne?= <robert.schoene@tu-dresden.de>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Fri, 10 Oct 2014 16:05:26 +0200
Message-ID: <1412949926.13463.47.camel@x200t>
References: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com>
	 <54353223.7080704@redhat.com>
	 <CAKohpok+z+bPySa+Kzh2zW+2L8CCG29q6wANe3jd+o80+PnASA@mail.gmail.com>
	 <5437C12D.1070803@redhat.com>
	 <CAKohpokDG1_r7eJ5Yykea4orcuEicCUFCrnSo1uTgKW1iJGwRA@mail.gmail.com>
	 <5437C535.3070707@redhat.com>
	 <CAKohpo=_vgxvtJYA_53jdicnRivihAVQuEgoKk7S7MhZctyZkw@mail.gmail.com>
	 <5437C778.4040108@redhat.com> <1412942496.13463.28.camel@x200t>
	 <CAKohpomvrKxnk3ZOtZxZEO+fVWSr5gB1AadtFUib8jsqndDgtg@mail.gmail.com>
	 <1412947425.13463.37.camel@x200t>
	 <CAKohpokag-ppE7WH=jPS6-i_T-5PyaDKyKS8uC+Xt2QGxLHYkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.zih.tu-dresden.de ([141.30.67.73]:57936 "EHLO
	mailout2.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751917AbaJJOFh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Oct 2014 10:05:37 -0400
In-Reply-To: <CAKohpokag-ppE7WH=jPS6-i_T-5PyaDKyKS8uC+Xt2QGxLHYkw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Prarit Bhargava <prarit@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>

+AEA-all:
I have to leave now and will not be available for a week.

+AEA-Viresh:
The line you are looking for is 2c8 (260h+-68h, length check passed).
Here it is with the surrounding instructions:


static inline void +AF8AXw-gov+AF8-queue+AF8-work(int cpu, struct dbs+AF8-data +ACo-dbs+AF8-data,
                unsigned int delay)
+AHs
        struct cpu+AF8-dbs+AF8-common+AF8-info +ACo-cdbs +AD0 dbs+AF8-data-+AD4-cdata-+AD4-get+AF8-cpu+AF8-cdbs(cpu)+ADs
 2c0:   49 8b 06                mov    (+ACU-r14),+ACU-rax
 2c3:   89 df                   mov    +ACU-ebx,+ACU-edi
 2c5:   ff 50 20                callq  +ACo-0x20(+ACU-rax)
/fastfs/rschoene/linux-git/drivers/cpufreq/cpufreq+AF8-governor.c:168

        mod+AF8-delayed+AF8-work+AF8-on(cpu, system+AF8-wq, +ACY-cdbs-+AD4-work, delay)+ADs
 2c8:   48 8b 35 00 00 00 00    mov    0x0(+ACU-rip),+ACU-rsi        +ACM 2cf +ADw-gov+AF8-queue+AF8-work+-0x6f+AD4
                        2cb: R+AF8-X86+AF8-64+AF8-PC32      system+AF8-wq-0x4
 2cf:   48 8d 50 30             lea    0x30(+ACU-rax),+ACU-rdx
 2d3:   4c 89 f9                mov    +ACU-r15,+ACU-rcx
 2d6:   89 df                   mov    +ACU-ebx,+ACU-edi
 2d8:   e8 00 00 00 00          callq  2dd +ADw-gov+AF8-queue+AF8-work+-0x7d+AD4
                        2d9: R+AF8-X86+AF8-64+AF8-PC32      mod+AF8-delayed+AF8-work+AF8-on-0x4
cpumask+AF8-next():
/fastfs/rschoene/linux-git/include/linux/cpumask.h:182 (discriminator 1)
 2dd:   41 83 c4 01             add    +ACQ-0x1,+ACU-r12d
 2e1:   be 00 01 00 00          mov    +ACQ-0x100,+ACU-esi
 2e6:   4c 89 ef                mov    +ACU-r13,+ACU-rdi
 2e9:   49 63 d4                movslq +ACU-r12d,+ACU-rdx
 2ec:   e8 00 00 00 00          callq  2f1 +ADw-gov+AF8-queue+AF8-work+-0x91+AD4
                        2ed: R+AF8-X86+AF8-64+AF8-PC32      find+AF8-next+AF8-bit-0x4



+AD4 If you are using x86 then simply use objdump, otherwise your toolchain will
+AD4 have a command for this..
+AD4 
+AD4 Then search for gov+AF8-queue+AF8-work in this and confirm the length of routine is
+AD4 0xd0 (Came from gov+AF8-queue+AF8-work+-0x68/0xd0) and then tell us what's there
+AD4 at 0x68 ...
+AD4 
+AD4 Sorry if you already knew all this, just for completeness I am sharing this :)
+AD4 
+AD4 If you find some difficulty with this, just attach the file and send it to me +-
+AD4 let me know what compiler you used, +- system architecture.


