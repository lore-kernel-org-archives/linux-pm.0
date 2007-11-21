From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] Freezer fixes for 2.6.24 (rev. 2)
Date: Wed, 21 Nov 2007 23:22:01 +0100
Message-ID: <200711212322.02340.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Nigel Cunningham <nigel@suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Len,

This is the second iteration of the patches are intended to fix two recent
regressions related to the freezer.

The first one fixes http://bugzilla.kernel.org/show_bug.cgi?id=9345 and has
been tested by the reporter.

The second one is intended to fix the APM emulation breakage caused before
2.6.23.

Please apply.

Thanks,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
