From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] PM: Remove legacy PM
Date: Thu, 13 Mar 2008 23:51:18 +0100
Message-ID: <200803132351.19794.rjw__2417.64780735156$1205449121$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Len,

The first of the following two patches removes the legacy PM infrastructure
and the second one removes some of its remnants from the MIPS tree.

Please add them to the suspend branch.

Thanks,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
