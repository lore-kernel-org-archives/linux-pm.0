From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.37.1 s2disk regression (TPM)
Date: Tue, 22 Feb 2011 18:39:37 +0100
Message-ID: <4D63F4D9.6030505__49405.6892850951$1298396728$gmane$org@gmail.com>
References: <4D60E93D.1050205@gmail.com> <4D60F108.9000106@gmail.com>
	<201102201151.11635.rjw@sisk.pl> <201102201248.10779.rjw@sisk.pl>
	<4D628521.8000205@linux.vnet.ibm.com> <4D629427.8020500@gmail.com>
	<4D629D03.90801@linux.vnet.ibm.com> <4D62CD93.3040206@gmail.com>
	<4D62D930.8060304@linux.vnet.ibm.com> <4D62DCBA.9050609@gmail.com>
	<4D62E221.7010104@linux.vnet.ibm.com> <4D62E2F2.4060406@gmail.com>
	<4D63066D.3080701@linux.vnet.ibm.com> <4D6376A9.5060704@gmail.com>
	<4D63A4B8.8040106@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D63A4B8.8040106@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Rajiv Andrade <srajiv@linux.vnet.ibm.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, debora@linux.vnet.ibm.com, preining@logic.at, linux-pm <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/22/2011 12:57 PM, Stefan Berger wrote:
> The forthcoming patch will simply also adapt the other 2 values and
> multiply them by 1000. The reason for the suspend failure is the 2nd
> timeout with TPM_SaveState command being of medium duration.
> 
> There will be a 2nd patch for re-enabling the TPM's interrupts that the
> BIOS may (this may be BIOS-dependent) have disabled while sending a
> command (TPM_Startup) to the TPM upon resume and having used polling
> mode and leaving it with the interrupts disabled.
> 
> I'd appreciate it if you tested both of them.

I didn't get any. Could you add a pointer to them?

BTW. there is another guy who hit this. He has:
/sys/devices/pnp0/00:02/timeouts:1000000 2000 150000

like I do.

regards,
-- 
js
