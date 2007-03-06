From: Ingo Molnar <mingo@elte.hu>
Subject: Re: SATA resume slowness, e1000 MSI warning
Date: Tue, 6 Mar 2007 10:04:44 +0100
Message-ID: <20070306090444.GA25409@elte.hu>
References: <20070227103021.GA2250@kernel.dk> <20070227103407.GA17819@elte.hu>
	<20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk>
	<20070301093450.GA8508@elte.hu> <20070302100704.GB2293@elf.ucw.cz>
	<20070305084257.GA4464@mellanox.co.il>
	<20070305101120.GA23032@elte.hu> <45ECFC5F.7000102@garzik.org>
	<45ED0BBF.1050000@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45ED0BBF.1050000@intel.com>
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
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Kok, Auke <auke-jan.h.kok@intel.com> wrote:

> >>BUG: at drivers/pci/msi.c:611 pci_enable_msi()

> >I would poke Eric Biederman(sp?) about this one.  Maybe its even =

> >solved by the MSI-enable-related patch he posted in the past 24-48 =

> >hours.
> =

> I tried the 3-patch series "[PATCH 0/3] Basic msi bug fixes.." and =

> they fix this problem for me. Were you expecting the OOPS in the first =

> place? [...]

the bug was the warning message (a WARN_ON()) above - not an oops. So =

that warning message is gone in your testing?

	Ingo
