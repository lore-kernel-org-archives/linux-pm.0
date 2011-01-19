From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Resume from Memory very slow on 2.6.37+
Date: Wed, 19 Jan 2011 22:19:07 +0100
Message-ID: <201101192219.07569.rjw__20762.8895914697$1295472600$gmane$org@sisk.pl>
References: <AANLkTimBEnKTuR5aQyXvpZX8grQPw1eCaVgP-k9yBXhv@mail.gmail.com>
	<201101190238.18529.rjw@sisk.pl>
	<AANLkTimf3B=z1DCA2q+yi-ccyAJwmjkB_g8EP=ZTehmn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimf3B=z1DCA2q+yi-ccyAJwmjkB_g8EP=ZTehmn@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Jack Steiner <steiner@sgi.com>, Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, January 19, 2011, Jeff Chua wrote:
> On Wed, Jan 19, 2011 at 9:38 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Wednesday, January 19, 2011, Jeff Chua wrote:
> >> On Wed, Jan 19, 2011 at 4:20 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > Please apply the appended patch (without the previous one) and post a dmesg
> >> > log containing a suspend-resume cycle with the delay.  I wonder where exactly
> >> > the delay occurs.
> >> > +       pr_info("%s: synchronize_rcu()\n", __func__);
> >> >        synchronize_rcu();
> >> > +       pr_info("%s: iounmap(%p), physaddr: %llx, size: %u\n", __func__,
> >> > +               map->virt, map->phys, map->size);
> >>
> >> Rafael,
> >>
> >> The 30 seconds is due to this ...
> >>
> >> PM: Syncing filesystems ... done.
> >> Freezing user space processes ... _memory: synchronize_rcu()
> >> acpi_os_unmap_memory: iounmap(ffffc90001c22000), physaddr: bb398000, size: 4096
> >> acpi_os_unmap_memory: synchronize_rcu()
> >> acpi_os_unmap_memory: iounmap(ffffc90001c26000), physaddr: bb399000, size: 4096
> 00), physaddr: bb79e000, size: 4096
> >> Restarting tasks ... done.
> >>
> >> After this, I see my X windows.
> >
> > Are you able to say whether the synchronize_rcu() or the iounmap() calls block?
> 
> It's "synchronize_rcu()" that's causing the slow down. Removing it
> solves the problem.

That confirms my theory, thanks.

> Does synchronize_rcu() triggers the limiting update rate as described
> in Documentation/RCU/whatisRCU.txt?
> 
>         In addition, the synchronize_rcu() API has the nice property
>         of automatically limiting update rate should grace periods
>         be delayed.  This property results in system resilience in face
>         of denial-of-service attacks.

Well, I'm not sure.  Anyway, it apparently is better to avoid calling it so
many times in a row and, quite frankly, unnecessarily.

OK, I'd like you to test the two patches I'll send in replies to this
message.

[1/2] - It will go back to using ioremap_cache() for NVS pages allocations.
[2/2] - This one will move suspend_nvs_free() before device drivers' resume
        callbacks (should avoid conflicts with the drivers' mappings).

Thanks,
Rafael
