From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: SATA resume slowness, e1000 MSI warning
Date: Sun, 11 Mar 2007 13:50:01 -0600
Message-ID: <m1mz2jv9ue.fsf@ebiederm.dsl.xmission.com>
References: <20070311180342.GE24475@mellanox.co.il>
	<m1mz2jws83.fsf@ebiederm.dsl.xmission.com>
	<20070311183709.GB19601@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070311183709.GB19601@mellanox.co.il> (Michael S. Tsirkin's
	message of "Sun, 11 Mar 2007 20:37:09 +0200")
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: "Kok, Auke" <auke-jan.h.kok@intel.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Jeff Garzik <jeff@garzik.org>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> OK I guess. I gather we assume writing read-only registers has no side ef=
fects?
> Are there rumors circulating wrt to these?

I haven't heard anything about that, and if we are writing the same value b=
ack
it should be pretty safe.

I have heard it asserted that at least one version of the pci spec
only required 32bit accesses to be supported by the hardware.  One of
these days I will have to look that and see if it is true.  I do know
it can be weird for hardware developers to support multiple kinds of
decode.   As I recall for pci and pci-x at the hardware level the only
difference in between 32bit transactions and smaller ones is the state
of the byte-enable lines.

Eric
