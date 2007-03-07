From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: SATA resume slowness, e1000 MSI warning
Date: Tue, 06 Mar 2007 21:15:57 -0700
Message-ID: <m1ejo1elj6.fsf@ebiederm.dsl.xmission.com>
References: <20070227103021.GA2250@kernel.dk> <20070227103407.GA17819@elte.hu>
	<20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk>
	<20070301093450.GA8508@elte.hu> <20070302100704.GB2293@elf.ucw.cz>
	<20070305084257.GA4464@mellanox.co.il>
	<20070305101120.GA23032@elte.hu> <45ECFC5F.7000102@garzik.org>
	<45ED0BBF.1050000@intel.com> <20070306090444.GA25409@elte.hu>
	<45ED8A12.5040803@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <45ED8A12.5040803@intel.com> (Auke Kok's message of "Tue, 06 Mar
	2007 07:34:42 -0800")
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Kok, Auke" <auke-jan.h.kok@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
List-Id: linux-pm@vger.kernel.org

"Kok, Auke" <auke-jan.h.kok@intel.com> writes:

> Ingo Molnar wrote:
>> * Kok, Auke <auke-jan.h.kok@intel.com> wrote:
>>
>>>>> BUG: at drivers/pci/msi.c:611 pci_enable_msi()
>>
>>>> I would poke Eric Biederman(sp?) about this one.  Maybe its even solve=
d by
>>>> the MSI-enable-related patch he posted in the past 24-48 hours.
>>> I tried the 3-patch series "[PATCH 0/3] Basic msi bug fixes.." and they=
 fix
>>> this problem for me. Were you expecting the OOPS in the first place? [.=
..]
>>
>> the bug was the warning message (a WARN_ON()) above - not an oops. So th=
at
>> warning message is gone in your testing?
>
> yes.

Sorry for the slow delay.  I was out of town for my brothers wedding the la=
st few
days.

I wasn't exactly expecting the WARN_ON to trigger.  What I fixed was
an inconsistency in handling our state bits.  Fixing that
inconsistency appears to have fixed the e1000 usage scenario mostly by
accident.

The basic issue is that pci_save_state saves the current msi state
along with other registers, and then the e1000 driver goes and
disables the msi irq after we have saved the irq state as on.

My code notices that the msi irq was disabled before restore time, so
it skips the restore.  However we now have a leak of the msi saved cap
because we are not freeing it. =


This leaves with some basic questions.
- Does it make sense for suspend/resume methods to request/free irqs?
- Does it make sense for suspend/resume methods to allocate/free msi irqs?
- Do we want pci_save/restore_cap to save/restore msi state?

The path of least resistance is to just free the extra state and we
are good.  I'm just not quite certain that is sane and it has been a
long day.

Eric
