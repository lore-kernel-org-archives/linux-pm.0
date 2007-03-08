From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 0/2] Repair pci_restore_state when used with
	device resets
Date: Thu, 08 Mar 2007 12:58:02 -0700
Message-ID: <m1tzwv5wz9.fsf_-_@ebiederm.dsl.xmission.com>
References: <20070227103021.GA2250@kernel.dk> <20070227103407.GA17819@elte.hu>
	<20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk>
	<20070301093450.GA8508@elte.hu> <20070302100704.GB2293@elf.ucw.cz>
	<20070305084257.GA4464@mellanox.co.il>
	<20070305101120.GA23032@elte.hu> <45ECFC5F.7000102@garzik.org>
	<45ED0BBF.1050000@intel.com> <20070306090444.GA25409@elte.hu>
	<45ED8A12.5040803@intel.com>
	<m1ejo1elj6.fsf@ebiederm.dsl.xmission.com>
	<45EEE8CF.1060803@intel.com> <45EEEC2C.5090609@intel.com>
	<m1649cdfas.fsf@ebiederm.dsl.xmission.com>
	<20070307185317.5601d452.akpm@linux-foundation.org>
	<m1wt1s6x2p.fsf@ebiederm.dsl.xmission.com>
	<45EFDD8C.3070702@garzik.org>
	<m1abyn7iin.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <m1abyn7iin.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Thu, 08 Mar 2007 10:27:28 -0700")
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Kok, Auke" <auke-jan.h.kok@intel.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Jeff Garzik <jeff@garzik.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, michael@ellerman.id.au, linux-pci@atrey.karlin.mff.cuni.cz, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org


Well this is clearly a weird tangent from the topic of this thread but
it looks to have found some real bugs even if they aren't the ones we
are looking for.

In short pci_save_state and pci_restore_state are used to two primary
was:  As a pair called from the suspend and restore routines.  One save
to multiple restores usually present in hardware reset routines.

The additions to save/restore msi, pci-e and pci-x state failed to take
this second usage scenario into account.

The next two patches address this problem.

This should directly fix the issue observed with the tg3, with multiple
saves and a single restore.

It happens that to handle the reset case cleanly we also need to support
the odd usage model of the current e1000 driver.  =


I have never have figured out how to get suspend/resume actually
working on any of my machines so the code path is untested.   But the
patches are trivial and pretty much obviously correct.

So if a couple people could do a quick suspend/resume test on these
patches to confirm I'm not blind that would be great.

Eric
