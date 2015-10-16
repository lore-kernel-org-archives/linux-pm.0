From: Donald Parsons <dparsons@brightdsl.net>
Subject: Re: [PATCH/RFT 0/2] regression fix: "smpboot: do_boot_cpu
 failed(-1) to wakeup CPU#1"
Date: Fri, 16 Oct 2015 01:42:26 -0400
Message-ID: <1444974146.5774.8.camel@falcon.homelinux.org>
References: <1444968869-21435-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444968869-21435-1-git-send-email-lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, shrybman@teksavvy.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2015-10-16 at 00:14 -0400, Len Brown wrote:
> Shane, Donald,
> Please test this pair of patches.
> 
> If the default kernel still has a problem booting CPU #1 on your Core2 system,
> "cpu_init_udelay=10000" should get you back to the legacy delays.

Applied patches to Linus' 4.3-rc4 (with none of our recently discussed
changes.) 

Result missing CPU is back!

I also tried the "cpu_init_udelay=1" with rc5 and that also gave me back
the missing CPU?  Previously I had tried "cpu_init_udelay=10000" and it
did not get missing CPU back (with rc3 or rc4).

I can do more testing if you need it.

Thanks,
Don
