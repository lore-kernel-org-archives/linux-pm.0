From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH -mm 2/2] kexec jump -v11: save/restore device
 state
Date: Wed, 11 Jun 2008 04:21:23 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806110418370.4233__42109.4247526073$1213172673$gmane$org@localhost.localdomain>
References: <1213082106.22608.30.camel@caritas-dev.intel.com>
	<alpine.LFD.1.10.0806101400090.14381@localhost.localdomain>
	<1213146074.21923.10.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1213146074.21923.10.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org



On Wed, 11 Jun 2008, Huang, Ying wrote:

> On Tue, 2008-06-10 at 14:01 -0400, Len Brown wrote:
> > 
> > On Tue, 10 Jun 2008, Huang, Ying wrote:
> > 
> > > This patch implements devices state save/restore before after kexec.
> > > 
> > > 
> > > This patch together with features in kexec_jump patch can be used for
> > > following:
> > > 
> > > - A simple hibernation implementation without ACPI support. You can
> > >   kexec a hibernating kernel, save the memory image of original system
> > >   and shutdown the system. When resuming, you restore the memory image
> > >   of original system via ordinary kexec load then jump back.
> > 
> > What part of ACPI's role in hibernation are you trying to avoid
> > 1. enabling wake devices
> > 2. removing power from the system
> > 3. something else?
> 
> ACPI S5 is used instead of S4 for this simple hibernation
> implementation. That is, before creating the hibernation image, the ACPI
> _PTS is not executed, devices are not put into low power state and wake
> devices are not enabled. After creating the hibernation image, the image
> is saved to disk and system is shutdown (go to S5). When resuming from
> hibernated image, ACPI _BFS and _WAK are not executed too.

Doesn't that resume the devices and their drivers into an unknown state?

-Len
