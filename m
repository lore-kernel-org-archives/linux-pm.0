From: Vasiliy Kulikov <segoon@openwall.com>
Subject: Re: [PATCH] power: disable hibernation if module loading
 is disabled
Date: Sat, 5 Mar 2011 00:10:35 +0300
Message-ID: <20110304211035.GA28842__40175.7624852054$1299273093$gmane$org@albatros>
References: <1299255084-4390-1-git-send-email-segoon@openwall.com>
	<201103042142.09247.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201103042142.09247.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, security@kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 04, 2011 at 21:42 +0100, Rafael J. Wysocki wrote:
> That "everyone" is actually the "full root" (in the case of /sys/power/state)
> or someone having CAP_SYS_ADMIN in the /dev/snapshot case, right?

Yes, sorry for my bad english.  "Everyone" is indeed misleading :-D

> Second, there's _zero_ relationship between /proc/sys/kernel/modules_disabled
> and the hibernation interface, so please find a different way to solve the
> problem (if there is any).

If modules_disabled is set to 1, then nobody, even full root may not write
to the kernel, right?  So, if something permits to indirectly pass
modules_disabled restriction, this is a bug.  Otherwise,
modules_disabled is confusing as it gives false sense of security.

-OR-

modules_disabled's documentation should be changed to note that it
doesn't prevent rootkit uploading, but only forbids modprob'ing modules
via the "official" init_module(2) gate, disallowing e.g. module autoloading.


Thanks,

-- 
Vasiliy Kulikov
http://www.openwall.com - bringing security into open computing environments
