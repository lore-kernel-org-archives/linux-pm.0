From: Ido Schimmel <idosch@idosch.org>
Subject: Re: [PATCH 2/2] PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs
 interface
Date: Thu, 9 May 2019 20:43:38 +0300
Message-ID: <20190509174338.GA24432@splinter>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan>
 <1762575.ER2xjzr9E1@aspire.rjw.lan>
 <20190509102315.GA31824@splinter>
 <1627338.1fd8ofggM8@kreacher>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1627338.1fd8ofggM8@kreacher>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Simon Schricker <sschricker@suse.de>, Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thu, May 09, 2019 at 07:18:28PM +0200, Rafael J. Wysocki wrote:
> So does the patch below fix it for you?

Yes. Thanks for the fix. Feel free to add my tag:

Tested-by: Ido Schimmel <idosch@mellanox.com>
