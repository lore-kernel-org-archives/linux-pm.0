From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: [patch 0/2] cpuidle: Time accounting fix
Date: Mon, 29 Sep 2008 15:24:26 -0700
Message-ID: <20080929222426.914988000@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: lenb@kernel.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

As noted in PM minisummit notes here
http://lwn.net/Articles/292447/

Richard Woodruff <r-woodruff2@ti.com> reported a bug
"the CPUIDLE bug that if target is avoided due to BM activity the original
target state is still accounted the time."

Following provides a mechanism to fix the problem for all drivers and fixes
the problem for acpi cpuidle driver.

-- 
