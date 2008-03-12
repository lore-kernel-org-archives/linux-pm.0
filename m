From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Tue, 11 Mar 2008 20:02:55 -0600
Message-ID: <m1ejagzokw.fsf__28504.5264209204$1205287703$gmane$org@ebiederm.dsl.xmission.com>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com> <200803112318.28120.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803112318.28120.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Tue, 11 Mar 2008 23:18:27 +0100")
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> Well, what can I say?
>
> I haven't been a big fan of doing hibernation this way since the very beginning
> and I still have the same reservations.  Namely, my opinion is that the
> hibernation-related problems we have are not just solvable this way.  For one
> example, in order to stop using the freezer for suspend/hibernation we first
> need to revamp the suspending/resuming of devices (uder way) and the
> kexec-based approach doesn't help us here.  I wouldn't like to start another
> discussion about it though.

Agreed.  At best all this does is moving the policy on how to save the kernel
image from the kernel itself out to user space, and it not a cure all.

> That said, I can imagine some applications of the $subject functionality
> not directly related to hibernation.  For example, one can use it for kernel
> debgging (jump to a new kernel, change something in the old kernel's
> data, jump back and see what happens etc.).  Also, in principle it may be used
> for such things as live migration of VMs.

Also such things as calling BIOS services or EFI services on x86_64.  Where
vm86 is not useful.

So in principle I think a kexec with return is a logical extension to
the current kexec functionality.  

That said it looks like next month before I will have time to do a reasonable
job of reviewing the current patches.  

Eric
