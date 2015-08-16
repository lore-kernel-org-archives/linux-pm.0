From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/7] tools/power turbostat: update turbostat(8)
Date: Sat, 15 Aug 2015 23:25:42 -0400
Message-ID: <75fd7ffa7fab91c2c3234bd3e465ba4f366733f4.1439695194.git.len.brown@intel.com>
References: <1439695548-21174-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439695548-21174-1-git-send-email-lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Len Brown <len.brown@intel.com>

Remove reference to the original Nehalem Turbo white paper,
since it has moved, and these mechanisms have now long since
been documented in the Software Developer's Manual.

Reported-by: Jeremie Lagraviere <jeremie@simula.no>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/tu=
rbostat/turbostat.8
index 05b8fc3..622db68 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -251,11 +251,6 @@ Although it is not guaranteed by the architecture,=
 turbostat assumes
 that they count at TSC rate, which is true on all processors tested to=
 date.
=20
 .SH REFERENCES
-"Intel=C2=AE Turbo Boost Technology
-in Intel=C2=AE Core=E2=84=A2 Microarchitecture (Nehalem) Based Process=
ors"
-http://download.intel.com/design/processor/applnots/320354.pdf
-
-"Intel=C2=AE 64 and IA-32 Architectures Software Developer's Manual
 Volume 3B: System Programming Guide"
 http://www.intel.com/products/processor/manuals/
=20
--=20
2.5.0.330.g130be8e
