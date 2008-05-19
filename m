From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/7] Patches for 2.6.27
Date: Tue, 20 May 2008 01:29:19 +0200
Message-ID: <200805200129.19904.rjw__7568.20091414756$1211241356$gmane$org@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Len,

The following series of patches is targeted at 2.6.27.  They have already been
discussed on mailing lists a bit and tested on my systems, but they certainly
require more testing.

Patches 1/7 - 6/7 should apply on top of the current -git, but the patch 7/7
depends on one patch in the Greg's tree (should apply to linux-next, though).

Thanks,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
