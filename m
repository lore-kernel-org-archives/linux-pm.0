From: Vasiliy Kulikov <segoon@openwall.com>
Subject: Re: [PATCH] power: disable hibernation if module loading
 is disabled
Date: Sat, 5 Mar 2011 00:46:32 +0300
Message-ID: <20110304214630.GA29883__26845.8444079899$1299275351$gmane$org@albatros>
References: <1299255084-4390-1-git-send-email-segoon@openwall.com>
	<201103042142.09247.rjw@sisk.pl> <20110304211035.GA28842@albatros>
	<201103042221.02852.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201103042221.02852.rjw@sisk.pl>
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

On Fri, Mar 04, 2011 at 22:21 +0100, Rafael J. Wysocki wrote:
> On Friday, March 04, 2011, Vasiliy Kulikov wrote:
> > If modules_disabled is set to 1, then nobody, even full root may not write
> > to the kernel, right?  So, if something permits to indirectly pass
> > modules_disabled restriction, this is a bug.  Otherwise,
> > modules_disabled is confusing as it gives false sense of security.
> > 
> > -OR-
> > 
> > modules_disabled's documentation should be changed to note that it
> > doesn't prevent rootkit uploading, but only forbids modprob'ing modules
> > via the "official" init_module(2) gate, disallowing e.g. module autoloading.
> 
> Why not to change that documentation, then?

Because it's better to fix something (if it is possible, of course) than
simply documenting the bug.

> Also, please note that in order to "write" into memory using the hibernation
> interface you need to have write access to swap,

No, you may just "write the kernel" via write() /dev/snapshot, this is
the way uswsusp works.  I didn't check whether it really needs
temporary file to change the kernel memory or it may be done entirely
without disk iteraction.  This is irrelevant to modules_disabled policy
violation, though.

> which you can use to corrupt
> memory regardless of the modules_disabled setting AFAICS.

Please correct me if I'm wrong, but kernel memory is not swappable at
all and only userspace memory is written to the swap.  Root with
CAP_SYS_ADMIN already may do everything with all processes, so this is
not a threat.

If one may change kernel memory via swap then it is another problem with
modules_disabled.

Thanks,

-- 
Vasiliy Kulikov
http://www.openwall.com - bringing security into open computing environments
