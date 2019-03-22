From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/2] PM / arch: x86: Rework the
 MSR_IA32_ENERGY_PERF_BIAS handling
Date: Fri, 22 Mar 2019 09:52:03 -0700
Message-ID: <aa5e2a093bf1c2d7ef024348065249bb6e4518b2.camel@perches.com>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan>
         <1605148.8jT99SsvVP@aspire.rjw.lan> <20190322142828.GA12472@zn.tnic>
         <alpine.DEB.2.21.1903221531080.1729@nanos.tec.linutronix.de>
         <20190322143525.GB12472@zn.tnic>
         <alpine.DEB.2.21.1903221712020.1729@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1903221712020.1729@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Simon Schricker <sschricker@suse.de>, Hannes Reinecke <hare@suse.de>
List-Id: linux-pm@vger.kernel.org

On Fri, 2019-03-22 at 17:12 +0100, Thomas Gleixner wrote:
> On Fri, 22 Mar 2019, Borislav Petkov wrote:
> 
> > On Fri, Mar 22, 2019 at 03:31:54PM +0100, Thomas Gleixner wrote:
> > > We have no proper decision/recommendation about documentation
> > > licensing. That's being worked on.
> > 
> > Ok, I'm ignoring this checkpatch warning from now on.
> 
> Only for Documentation/* files please.

Perhaps
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d0001fd1112d..00c1457fe79b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3058,7 +3058,8 @@ sub process {
 					     "Improper SPDX comment style for '$realfile', please use '$comment' instead\n" . $herecurr);
 				}
 
-				if ($comment !~ /^$/ &&
+				if ($realfile !~ m@^Documentation/@ &&
+				    $comment !~ /^$/ &&
 				    $rawline !~ m@^\+\Q$comment\E SPDX-License-Identifier: @) {
 					WARN("SPDX_LICENSE_TAG",
 					     "Missing or malformed SPDX-License-Identifier tag in line $checklicenseline\n" . $herecurr);
