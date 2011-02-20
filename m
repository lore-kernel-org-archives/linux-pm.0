From: Jiri Slaby <jirislaby@gmail.com>
Subject: 2.6.37.1 s2disk regression (TPM)
Date: Sun, 20 Feb 2011 11:13:17 +0100
Message-ID: <4D60E93D.1050205__1000.38035675443$1298196955$gmane$org@gmail.com>
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
To: stefanb@linux.vnet.ibm.com
Cc: srajiv@linux.vnet.ibm.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>, debora@linux.vnet.ibm.com, tpmdd-devel@lists.sourceforge.net, linux-pm <linux-pm@lists.linux-foundation.org>, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

I'm unable to hibernate 2.6.37.1 unless I rmmod tpm_tis:
[10974.074587] Suspending console(s) (use no_console_suspend to debug)
[10974.103073] tpm_tis 00:0c: Operation Timed out
[10974.103089] legacy_suspend(): pnp_bus_suspend+0x0/0xa0 returns -62
[10974.103095] PM: Device 00:0c failed to freeze: error -62

2.6.37 worked fine. Going to revert 9b29050f8f7 (tpm_tis: Use timeouts
returned from TPM) for testing.

regards,
-- 
js
