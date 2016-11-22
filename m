From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 0/5] powercap/intel_rapl: Fixes,
 hotplug conversion and simplifcation
Date: Tue, 22 Nov 2016 21:15:56 -0000
Message-ID: <20161122210518.079483154@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rafael Wysocki <rjw@sisk.pl>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

The driver fails to:

 - initialize packages which are not available at driver init time, though
   the value of that initialization is completely unclear as nothing ever
   uses these values. I fixed it up nevertheless and leave it to the
   maintainers to decide whether it should completely go away.

 - to propagate error codes in the hotplug online path, where a
   registration fails and the package data is freed, but return code is 0.

The initialization/removal code of that driver is a maze of duplicated code
which is more or less the same as the cpu hotplug code. After switching
over the driver to the hotplug statemachine, the whole init/removal
machinery can be replaced by installing/removing the hotplug state.

The total damage is:

 intel_rapl.c |  363 ++++++++++++++++-------------------------------------------
 1 file changed, 104 insertions(+), 259 deletions(-)

and the binary size shrinks as well:

   text	   data	    bss	    dec	    hex
   7996	    625	     32	   8653	   21cd	  Before
   7216	    593	     32	   7841	   1ea1	  After

Thanks,

	tglx
