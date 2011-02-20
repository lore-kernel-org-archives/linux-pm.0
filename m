From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.37.1 s2disk regression (TPM)
Date: Sun, 20 Feb 2011 12:48:10 +0100
Message-ID: <201102201248.10779.rjw__10801.2896650054$1298202579$gmane$org@sisk.pl>
References: <4D60E93D.1050205@gmail.com> <4D60F108.9000106@gmail.com>
	<201102201151.11635.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102201151.11635.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: stefanb@linux.vnet.ibm.com, srajiv@linux.vnet.ibm.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>, debora@linux.vnet.ibm.com, linux-pm <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, February 20, 2011, Rafael J. Wysocki wrote:
> On Sunday, February 20, 2011, Jiri Slaby wrote:
> > On 02/20/2011 11:44 AM, Rafael J. Wysocki wrote:
> > > On Sunday, February 20, 2011, Jiri Slaby wrote:
> > >> Hi,
> > >>
> > >> I'm unable to hibernate 2.6.37.1 unless I rmmod tpm_tis:
> > >> [10974.074587] Suspending console(s) (use no_console_suspend to debug)
> > >> [10974.103073] tpm_tis 00:0c: Operation Timed out
> > >> [10974.103089] legacy_suspend(): pnp_bus_suspend+0x0/0xa0 returns -62
> > >> [10974.103095] PM: Device 00:0c failed to freeze: error -62
> > >>
> > >> 2.6.37 worked fine. Going to revert 9b29050f8f7 (tpm_tis: Use timeouts
> > >> returned from TPM) for testing.
> > > 
> > > Yes, this has been confirmed to cause suspend regressions to happen
> > 
> > OK, the revert works for me too... Are there any fixes?
> 
> No, and the author and maintainer have not been responding.  If that contiunes,
> I'll simply ask Linus to revert it.

BTW, the first hunk from that commit in drivers/char/tpm/tpm.c seems to be
completely broken:

@@ -577,9 +577,11 @@ duration:
        if (rc)
                return;
 
-       if (be32_to_cpu(tpm_cmd.header.out.return_code)
-           != 3 * sizeof(u32))
+       if (be32_to_cpu(tpm_cmd.header.out.return_code) != 0 ||
+           be32_to_cpu(tpm_cmd.header.out.length)
+           != sizeof(tpm_cmd.header.out) + sizeof(u32) + 3 * sizeof(u32))
                return;
+
        duration_cap = &tpm_cmd.params.getcap_out.cap.duration;
        chip->vendor.duration[TPM_SHORT] =
            usecs_to_jiffies(be32_to_cpu(duration_cap->tpm_short));

Namely, either the old code always returned as a result of the conditional
being removed, or the new code will always return as a result of
the (... != 0) check.  I wonder if there's supposed to be (... == 0) instead?
[And why not to simply use 4*sizeof(u32) FWIW?]

Anyway, it looks like a good revert candidate to me.

Thanks,
Rafael
