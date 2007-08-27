From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 0/4] Hibernation: Arbitrary boot kernel
	support on x86_64 (rev. 2)
Date: Mon, 27 Aug 2007 23:31:27 +0200
Message-ID: <200708272331.28584.rjw@sisk.pl>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>, Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The first two patches in this series make it possible to restore the memory
state from a hibernation image with the help of a kernel different from the
image one.

The first patch adds the generic, platform independent code needed for that.
The second patch implements the idea on x86_64.

The remaining two patches remove some implicit assumptions about the boot and
image kernels from the x86_64 restore code.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
