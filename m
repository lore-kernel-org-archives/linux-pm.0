From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Tue, 11 Mar 2008 23:18:27 +0100
Message-ID: <200803112318.28120.rjw__32063.6675846346$1205274217$gmane$org@sisk.pl>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080311211004.GA30164@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 11 of March 2008, Vivek Goyal wrote:
> On Thu, Mar 06, 2008 at 11:13:08AM +0800, Huang, Ying wrote:
> > This is a minimal patch with only the essential features. All
> > additional features are split out and can be discussed later. I think
> > it may be easier to get consensus on this minimal patch.
> > 
> 
> Hi Huang,
> 
> This patchset is slowly getting better. True that first we need to come
> up with minimal infrastructure patch and then think of building more
> functionality on top of it.
> 
> 
> > This patch provides an enhancement to kexec/kdump. It implements
> > the following features:
> > 
> > - Jumping between the original kernel and the kexeced kernel.
> > 
> > - Backup/restore memory used by both the original kernel and the
> >   kexeced kernel.
> > 
> > - Save/restore CPU and devices state before after kexec.
> > 
> > 
> > The features of this patch can be used for as follow:
> > 
> > - A simple hibernation implementation without ACPI support. You can
> >   kexec a hibernating kernel, save the memory image of original system
> >   and shutdown the system. When resuming, you restore the memory image
> >   of original system via ordinary kexec load then jump back.
> > 
> 
> The main usage of this functionality is for hibernation. I am not sure
> what has been the conclusion of previous discussions.
> 
> Rafael/Pavel, does the approach of doing hibernation using a separate
> kernel holds promise?

Well, what can I say?

I haven't been a big fan of doing hibernation this way since the very beginning
and I still have the same reservations.  Namely, my opinion is that the
hibernation-related problems we have are not just solvable this way.  For one
example, in order to stop using the freezer for suspend/hibernation we first
need to revamp the suspending/resuming of devices (uder way) and the
kexec-based approach doesn't help us here.  I wouldn't like to start another
discussion about it though.

That said, I can imagine some applications of the $subject functionality
not directly related to hibernation.  For example, one can use it for kernel
debgging (jump to a new kernel, change something in the old kernel's
data, jump back and see what happens etc.).  Also, in principle it may be used
for such things as live migration of VMs.

Thanks,
Rafael
