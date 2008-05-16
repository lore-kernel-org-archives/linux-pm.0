From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Fri, 16 May 2008 09:55:02 +0800
Message-ID: <1210902902.23707.164.camel__45005.9729083025$1210902764$gmane$org@caritas-dev.intel.com>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080514205204.GJ30469@redhat.com>
	<1210830110.23707.141.camel@caritas-dev.intel.com>
	<20080516005121.GA6926@redhat.com> <m1skwjghen.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m1skwjghen.fsf@frodo.ebiederm.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2008-05-15 at 18:35 -0700, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
> > ioapic_suspend() is not putting APICs in Legacy mode and that's why
> > we are seeing the issue. It only saves the IOAPIC routing table entries
> > and these entries are restored during ioapic_resume().
> >
> > But I think somebody has to put APICs in legacy mode for normal 
> > hibernation also. Not sure who does it. May be BIOS, so that during
> > resume, second kernel can get the timer interrupts.
> 
> I doubt anything cares in the suspend to ram case. There should just
> be a small BIOS trampoline to get back to linux when the processor
> restarts.  And you don't need interrupts for any of that. 

As far as I know, in suspend to ram, interrupt is used as waking up
event, such as, keyboard interrupt.

Best Regards,
Huang Ying
