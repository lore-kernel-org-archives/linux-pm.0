From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2/2] 2.6.22-rc4: known regressions with patches v2
Date: Sat, 9 Jun 2007 22:05:40 +0200
Message-ID: <200706092205.43420.rjw__12099.7681435712$1181419243$gmane$org@sisk.pl>
References: <466AE54A.3040902@googlemail.com> <466AE619.2000706@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <466AE619.2000706@googlemail.com>
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
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-usb-devel@lists.sourceforge.net, Jeff Garzik <jeff@garzik.org>, Greg Kroah-Hartman <gregkh@suse.de>, Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-ide@vger.kernel.org, Simon <sg02r@ecs.soton.ac.uk>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Alan Cox <alan@redhat.com>, Eric Paris <eparis@parisplace.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jean-Luc Coulon <jean.luc.coulon@gmail.com>, Paulo Pereira <pfmp.404@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, 9 June 2007 19:40, Michal Piotrowski wrote:
> Hi all,
> 
> Here is a list of some known regressions in 2.6.22-rc4
> with patches available.
> 
> Feel free to add new regressions/remove fixed etc.
> http://kernelnewbies.org/known_regressions
> 
> 
> 
> SATA/PATA
> 
> Subject    : disk on promise pdc20378 disabled at boot
> References : http://bugzilla.kernel.org/show_bug.cgi?id=8587
> Submitter  : Jean-Luc Coulon <jean.luc.coulon@gmail.com>
> Handled-By : Tejun Heo <htejun@gmail.com>
> Caused-By  : Tejun Heo <htejun@gmail.com>
>              commit 464cf177df7727efcc5506322fc5d0c8b896f545
> Patch      : http://lkml.org/lkml/2007/6/6/112
> Status     : patch available
> 
> 
> 
> SELinux
> 
> Subject    : very high non-preempt latency in context_struct_compute_av()
> References : http://lkml.org/lkml/2007/6/4/78
> Submitter  : Ingo Molnar <mingo@elte.hu>
> Handled-By : Stephen Smalley <sds@tycho.nsa.gov>
>              James Morris <jmorris@namei.org>
> Patch      : http://lkml.org/lkml/2007/6/7/334
> Status     : patch available
> 
> 
> 
> Suspend
> 
> Subject    : panic on s3 resume with uhci_hcd module
> References : http://bugzilla.kernel.org/show_bug.cgi?id=8565
> Submitter  : Simon <sg02r@ecs.soton.ac.uk>
> Handled-By : Rafael J. Wysocki <rjw@sisk.pl>
> Patch      : http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc3/patches/21-firewire-implement-suspend-resume-hooks.patch
> Status     : patch available

The patch is already in 2.6.22-rc4, AFAICS.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
