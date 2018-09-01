From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH 1/3] x86, hibernate: Fix nosave_regions setup for
 hibernation
Date: Sat, 1 Sep 2018 23:38:54 +0800
Message-ID: <20180901153853.GA16196@chenyu-desktop>
References: <cover.1535361949.git.kookoo.gu@intel.com>
 <73b18a8b87a465fc442366cccf5542307c4f1ae9.1535361949.git.kookoo.gu@intel.com>
 <alpine.DEB.2.21.1808301441550.1210@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808301441550.1210@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Gu Zhimin <kookoo.gu@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,
On Thu, Aug 30, 2018 at 02:45:26PM +0200, Thomas Gleixner wrote:
> On Mon, 27 Aug 2018, Gu Zhimin wrote:
> > 
> > Fix this problem by changing pfn limit from max_low_pfn to max_pfn.
> > This issue should also exist on 64bits systems, if there are reserved
> > regions above 4GB.
> 
> Should? Can we please have facts and not some half baken assumptions? 
> 
> On 64bit max_low_pfn is the same as max_pfn. See init_mem_mapping().
>
Thanks for pointing this out, we've overlooked the reassignment of max_low_pfn,
but just take a glance within setup_arch().
Best,
Yu

> Thanks,
> 
> 	tglx
