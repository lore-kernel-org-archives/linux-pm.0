From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] x86, hibernate: Fix nosave_regions setup for
 hibernation
Date: Thu, 30 Aug 2018 14:45:26 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1808301441550.1210@nanos.tec.linutronix.de>
References: <cover.1535361949.git.kookoo.gu@intel.com> <73b18a8b87a465fc442366cccf5542307c4f1ae9.1535361949.git.kookoo.gu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <73b18a8b87a465fc442366cccf5542307c4f1ae9.1535361949.git.kookoo.gu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gu Zhimin <kookoo.gu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, Yu Chen <yu.c.chen@intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 27 Aug 2018, Gu Zhimin wrote:
> 
> Fix this problem by changing pfn limit from max_low_pfn to max_pfn.
> This issue should also exist on 64bits systems, if there are reserved
> regions above 4GB.

Should? Can we please have facts and not some half baken assumptions? 

On 64bit max_low_pfn is the same as max_pfn. See init_mem_mapping().

Thanks,

	tglx
