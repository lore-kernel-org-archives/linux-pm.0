From: Len Brown <lenb@kernel.org>
Subject: idle-test patches queued for upstream
Date: Wed, 26 May 2010 22:42:23 -0400
Message-ID: <1274928151-30919-1-git-send-email-lenb__47428.5789685839$1274929191$gmane$org@kernel.org>
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
To: x86@kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Please look over and test this patch set.
(If you test linux-next, you already have it)

There are a few simple patches, leading up to a new intel_idle driver.

Note that you can get the patch series as a single patch here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/idle/patches/2.6.34/idle-test-2.6.34.diff.gz

or pull from this git branch
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-idle-2.6.git idle-test

Both are vs 2.6.34.

Why is it good to have a native intel_idle driver?

Basically, we think we can do better than ACPI.
Indeed, on my (production level commerically available) Nehalem desktop
the ACPI tables are broken and an ACPI OS idles at 100W.  With this
driver the box idles at 85W.

Thanks,
-Len
