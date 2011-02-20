From: Jiri Slaby <jirislaby@gmail.com>
Subject: [REVERT request stable-2.6.36/37] Re: 2.6.37.1 s2disk
 regression (TPM)
Date: Sun, 20 Feb 2011 11:57:16 +0100
Message-ID: <4D60F38C.5050704__42813.4081339978$1298199872$gmane$org@gmail.com>
References: <4D60E93D.1050205@gmail.com> <201102201144.34043.rjw@sisk.pl>
	<4D60F108.9000106@gmail.com> <201102201151.11635.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: stefanb@linux.vnet.ibm.com, srajiv@linux.vnet.ibm.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>, debora@linux.vnet.ibm.com, tpmdd-devel@lists.sourceforge.net, linux-pm <linux-pm@lists.linux-foundation.org>, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/20/2011 11:51 AM, Rafael J. Wysocki wrote:
> On Sunday, February 20, 2011, Jiri Slaby wrote:
>> On 02/20/2011 11:44 AM, Rafael J. Wysocki wrote:
>>> On Sunday, February 20, 2011, Jiri Slaby wrote:
>>>> Hi,
>>>>
>>>> I'm unable to hibernate 2.6.37.1 unless I rmmod tpm_tis:
>>>> [10974.074587] Suspending console(s) (use no_console_suspend to debug)
>>>> [10974.103073] tpm_tis 00:0c: Operation Timed out
>>>> [10974.103089] legacy_suspend(): pnp_bus_suspend+0x0/0xa0 returns -62
>>>> [10974.103095] PM: Device 00:0c failed to freeze: error -62
>>>>
>>>> 2.6.37 worked fine. Going to revert 9b29050f8f7 (tpm_tis: Use timeouts
>>>> returned from TPM) for testing.
>>>
>>> Yes, this has been confirmed to cause suspend regressions to happen
>>
>> OK, the revert works for me too... Are there any fixes?
> 
> No, and the author and maintainer have not been responding.  If that contiunes,
> I'll simply ask Linus to revert it.

Ok then, stable team, please revert that from 2.6.37 stable.

I guess the same problem is in 2.6.36, so reverting it in 2.6.36 should
be done too...

thanks,
-- 
js
