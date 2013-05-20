From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Revert "x86-64, init: Do not set NX bits on non-NX capable
 hardware"
Date: Mon, 20 May 2013 11:36:36 -0700
Message-ID: <519A6D34.5000005@zytor.com>
References: <20130514160108.GA5055@dhcp22.suse.cz> <1369062192-7066-1-git-send-email-mhocko@suse.cz> <519A483F.7070400@zytor.com> <20130520164335.GA9441@dhcp22.suse.cz> <CA+55aFzxdGOW=7-x+41U4SZB5par7jKU9vuuhFdsQfZOuLiLtw@mail.gmail.com> <20130520182306.GA5348@dhcp22.suse.cz> <519A6BC7.7060902@linux.intel.com> <CA+55aFzEm3=2u68_hiQc269NDXCXct7=29EaiBbmVi+-0x7zMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:58940 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755480Ab3ETShB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 20 May 2013 14:37:01 -0400
In-Reply-To: <CA+55aFzEm3=2u68_hiQc269NDXCXct7=29EaiBbmVi+-0x7zMA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@linux.intel.com>, Michal Hocko <mhocko@suse.cz>, =?UTF-8?B?RmVybmFuZG8gTHVpcyBWw6F6cXVleiBDYW8=?= <fernando@oss.ntt.co.jp>, "Rafael J. Wysocki" <rjw@sisk.pl>, the arch/x86 maintainers <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 05/20/2013 11:31 AM, Linus Torvalds wrote:
> On Mon, May 20, 2013 at 11:30 AM, H. Peter Anvin <hpa@linux.intel.com> wrote:
>>
>> I'll write it up and send a pull request to Linus.
> 
> I'm already doing it.
> 

If you prefer.  It should be __cpuinitdata and not just blank, I believe.

	-hpa

