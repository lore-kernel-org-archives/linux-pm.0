From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Run-time PM idea (was: Re: [RFC][PATCH 0/2]
	PM:	Rearrange core suspend code)
Date: Mon, 8 Jun 2009 15:22:35 +0200
Message-ID: <20090608132235.GC13214__34603.3915797763$1244467413$gmane$org@elte.hu>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org>
	<200906072347.00580.rjw@sisk.pl> <20090608065419.GA13568@elte.hu>
	<200906081330.50045.rjw@sisk.pl> <20090608130509.GA3272@elte.hu>
	<20090608131159.GA15100@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090608131159.GA15100@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Mon, Jun 08, 2009 at 03:05:09PM +0200, Ingo Molnar wrote:
> > 
> > * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > Well, we've been discussing it for quite a while and since more 
> > > and more people are interested, I'm giving it a high priority.
> > 
> > Cool. I think that if within a few years we could achieve that every 
> > default distro (both on desktops and on servers) triggers PM 
> > functionality runtime on common hardware, we'd both have lower power 
> > consumption in general, and we'd have more robust suspend-resume 
> > code as well.
> 
> The difficulty is in determining when it's viable to autosuspend a 
> given device. There's a limit to how much we can determine purely 
> from kernel state (for instance, we could suspend ahci when 
> there's no pending disk access, but we'd lose hotplug 
> notifications) so there's going to have to be some level of 
> userspace policy determination. Having the infrastructure in the 
> kernel is an important part of this, but there'll be some distance 
> to go after that.

What will the 'user space policy' bit do what the kernel cannot?

If you mean the user has to configure something manually - that wont 
really happen in practice. We are happy if they know where to put 
those USB sticks in ;-)

	Ingo
