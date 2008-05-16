From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Thu, 15 May 2008 18:35:28 -0700
Message-ID: <m1skwjghen.fsf__41010.4124261581$1210902150$gmane$org@frodo.ebiederm.org>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080514205204.GJ30469@redhat.com>
	<1210830110.23707.141.camel@caritas-dev.intel.com>
	<20080516005121.GA6926@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080516005121.GA6926@redhat.com> (Vivek Goyal's message of
	"Thu, 15 May 2008 20:51:21 -0400")
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> ioapic_suspend() is not putting APICs in Legacy mode and that's why
> we are seeing the issue. It only saves the IOAPIC routing table entries
> and these entries are restored during ioapic_resume().
>
> But I think somebody has to put APICs in legacy mode for normal 
> hibernation also. Not sure who does it. May be BIOS, so that during
> resume, second kernel can get the timer interrupts.

I doubt anything cares in the suspend to ram case. There should just
be a small BIOS trampoline to get back to linux when the processor
restarts.  And you don't need interrupts for any of that. 

Eric
