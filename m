From: Brian W Hart <hartb@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: make table sentinal macros unsigned to match use
Date: Fri, 27 Jun 2014 16:09:39 -0500
Message-ID: <20140627210939.GB24604@oc3347516403.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:56126 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851AbaF0VJq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 17:09:46 -0400
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <hartb@linux.vnet.ibm.com>;
	Fri, 27 Jun 2014 15:09:45 -0600
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Stratos Karafotis <stratosk@semaphore.gr>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>

Commit 5eeaf1f18973 (cpufreq: Fix build error on some platforms that
use cpufreq_for_each_*) moved function cpufreq_next_valid() to a public
header.  Warnings are now generated when objects including that header
are built with -Wsign-compare (as an out-of-tree module might be):

=2E../include/linux/cpufreq.h: In function =E2=80=98cpufreq_next_valid=E2=
=80=99:
=2E../include/linux/cpufreq.h:519:27: warning: comparison between signe=
d
and unsigned integer expressions [-Wsign-compare]
  while ((*pos)->frequency !=3D CPUFREQ_TABLE_END)
                           ^
=2E../include/linux/cpufreq.h:520:25: warning: comparison between signe=
d
and unsigned integer expressions [-Wsign-compare]
   if ((*pos)->frequency !=3D CPUFREQ_ENTRY_INVALID)
                         ^

Constants CPUFREQ_ENTRY_INVALID and CPUFREQ_TABLE_END are signed, but
are used with unsigned member 'frequency' of cpufreq_frequency_table.
Update the macro definitions to be explicitly unsigned to match their
use.

This also corrects potentially wrong behavior of clk_rate_table_iter()
if unsigned long is wider than usigned int.

Signed-off-by: Brian W Hart <hartb@linux.vnet.ibm.com>
---
These macros are fairly broadly used in the kernel so I was bit leery
of changing them, but after inspection I think it's fine.  I found 102
uses of the macros, of which:

99 are uses with cpufreq_frequency_table.frequency (95) or with local
   variables of the same type as frequency (4).  These should be just
   fine with this change--we're just making explicit a conversion that
   was previously implicit.

 2 are uses with a local variable of different type (unsigned long) tha=
n
   'frequency' (in drivers/sh/clk/core.c).  One of these uses is safe;
   the other (in clk_rate_table_iter()) is broken if unsigned long
   is wider than unsigned int.  As a side-effect, this patch corrects
   the potential misbehavior there.

 1 is a use in macro cpufreq_for_each_entry() with what _should_ be the
   frequency member of a cpufreq_frequency_table, provided the caller i=
t
   well-behaved.  There are 18 callers of this macro; all are well-beha=
ved.
   So these should also be safe.

 include/linux/cpufreq.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index ec4112d..8f8ae95 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -482,8 +482,8 @@ extern struct cpufreq_governor cpufreq_gov_conserva=
tive;
  *********************************************************************=
/
=20
 /* Special Values of .frequency field */
-#define CPUFREQ_ENTRY_INVALID	~0
-#define CPUFREQ_TABLE_END	~1
+#define CPUFREQ_ENTRY_INVALID	~0u
+#define CPUFREQ_TABLE_END	~1u
 /* Special Values of .flags field */
 #define CPUFREQ_BOOST_FREQ	(1 << 0)
=20
--=20
1.7.1

