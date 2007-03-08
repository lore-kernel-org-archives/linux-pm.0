From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA resume slowness, e1000 MSI warning
Date: Thu, 08 Mar 2007 04:55:24 -0500
Message-ID: <45EFDD8C.3070702@garzik.org>
References: <20070227103021.GA2250@kernel.dk>
	<20070227103407.GA17819@elte.hu>	<20070227105922.GD2250@kernel.dk>
	<20070227111515.GA4271@kernel.dk>	<20070301093450.GA8508@elte.hu>
	<20070302100704.GB2293@elf.ucw.cz>	<20070305084257.GA4464@mellanox.co.il>	<20070305101120.GA23032@elte.hu>
	<45ECFC5F.7000102@garzik.org>	<45ED0BBF.1050000@intel.com>
	<20070306090444.GA25409@elte.hu>	<45ED8A12.5040803@intel.com>	<m1ejo1elj6.fsf@ebiederm.dsl.xmission.com>	<45EEE8CF.1060803@intel.com>
	<45EEEC2C.5090609@intel.com>	<m1649cdfas.fsf@ebiederm.dsl.xmission.com>	<20070307185317.5601d452.akpm@linux-foundation.org>
	<m1wt1s6x2p.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <m1wt1s6x2p.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Kok, Auke" <auke-jan.h.kok@intel.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Eric W. Biederman wrote:
> Until I get the best scenario I can come up with is a tg3 hardware bug
> that doesn't renable the pci-X capability after a restore of power state.


Speaking of tg3, make sure you are aware that the number of calls to =

save-state functions may not match the number of calls to the =

restore-state functions.  ISTR seeing some memleak bugs in PCI related =

to this.

	Jeff
