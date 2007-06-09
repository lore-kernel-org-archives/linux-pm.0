From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/2] 2.6.22-rc4: known regressions with patches v2
Date: Sat, 09 Jun 2007 19:40:41 +0200
Message-ID: <466AE619.2000706@googlemail.com>
References: <466AE54A.3040902@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <466AE54A.3040902@googlemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-usb-devel@lists.sourceforge.net, Jeff Garzik <jeff@garzik.org>, Greg Kroah-Hartman <gregkh@suse.de>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-ide@vger.kernel.org, Simon <sg02r@ecs.soton.ac.uk>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Alan Cox <alan@redhat.com>, Eric Paris <eparis@parisplace.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Smalley <sds@tycho.nsa.gov>, Jean-Luc Coulon <jean.luc.coulon@gmail.com>, Paulo Pereira <pfmp.404@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi all,

Here is a list of some known regressions in 2.6.22-rc4
with patches available.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



SATA/PATA

Subject    : disk on promise pdc20378 disabled at boot
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8587
Submitter  : Jean-Luc Coulon <jean.luc.coulon@gmail.com>
Handled-By : Tejun Heo <htejun@gmail.com>
Caused-By  : Tejun Heo <htejun@gmail.com>
             commit 464cf177df7727efcc5506322fc5d0c8b896f545
Patch      : http://lkml.org/lkml/2007/6/6/112
Status     : patch available



SELinux

Subject    : very high non-preempt latency in context_struct_compute_av()
References : http://lkml.org/lkml/2007/6/4/78
Submitter  : Ingo Molnar <mingo@elte.hu>
Handled-By : Stephen Smalley <sds@tycho.nsa.gov>
             James Morris <jmorris@namei.org>
Patch      : http://lkml.org/lkml/2007/6/7/334
Status     : patch available



Suspend

Subject    : panic on s3 resume with uhci_hcd module
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8565
Submitter  : Simon <sg02r@ecs.soton.ac.uk>
Handled-By : Rafael J. Wysocki <rjw@sisk.pl>
Patch      : http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc3=
/patches/21-firewire-implement-suspend-resume-hooks.patch
Status     : patch available



USB

Subject    : list_add corruption. prev->next should be next (f7d28794), b=
ut was f0df8ed4 (prev=3Df0df8ed4) Kernel Bug at lib/list_debug.c:33
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8561
Submitter  : Paulo Pereira <pfmp.404@gmail.com>
Handled-By : Alan Stern <stern@rowland.harvard.edu>
Patch      : http://bugzilla.kernel.org/show_bug.cgi?id=3D8561#c8
Status     : patch was suggested



Regards,
Michal

--
"Najbardziej brakowa=B3o mi twojego milczenia."
-- Andrzej Sapkowski "Co=B6 wi=EAcej"
