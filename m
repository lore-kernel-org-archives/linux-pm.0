From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Regression] Hibernation failure on dual core Athlon 64
	(64-bit)
Date: Mon, 3 Aug 2009 23:03:57 +0200
Message-ID: <200908032303.57859.rjw@sisk.pl>
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
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Linux PM List <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Mathieu,

As reported at

http://bugzilla.kernel.org/show_bug.cgi?id=13903

one of my test systems suffers from a hibernation regression where the second
attempt to hibernate in a row makes it hang solid right before creating the
image.

Bisection turned up your commit 3f4a782b5ce2698b1870b5a7b573cd721d4fce33
([CPUFREQ] fix (utter) cpufreq_add_dev mess) as the first bad one.

Best,
Rafael
