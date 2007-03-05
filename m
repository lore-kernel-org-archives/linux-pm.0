From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] KVM: T60 resume fix
Date: Mon, 5 Mar 2007 09:44:49 +0100
Message-ID: <20070305084449.GA1706@elte.hu>
References: <20070301104117.GA22788@elte.hu> <20070301145204.GA25304@elte.hu>
	<Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org>
	<20070302072100.GB30634@elte.hu> <20070302080441.GA12785@elte.hu>
	<20070302102018.GA11549@elte.hu> <20070302102216.GA13575@elte.hu>
	<45E93012.4000100@qumranet.com> <20070305082251.GA23366@elte.hu>
	<45EBD9BC.4030801@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45EBD9BC.4030801@qumranet.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Avi Kivity <avi@qumranet.com>
Cc: Daniel Walker <dwalker@mvista.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Avi Kivity <avi@qumranet.com> wrote:

> >> That is already CPU_ONLINE in my tree (and in the pull request sent =

> >> to Linus a couple of days ago).
> >
> > that solves the resume problem - but doesnt solve the CPU_DEAD issue =

> > of sending an IPI to an already offline CPU. Might be a better idea =

> > to do it in CPU_DOWN_PREPARE? (and then to also add a =

> > CPU_DOWN_FAILED branch?)
> =

> Mainline now has DOWN_PREPARE and UP_CANCELED calling =

> ->hardware_disable(), and ONLINE calling ->hardware_enabled().  What =

> tree are you looking at?

oh, i just hand-fixed it. I'll check current-git now.

> [but I do see the need for DOWN_FAILED now. Off to find a resumable =

> machine...]

yeah, both DOWN_FAILED and UP_FAILED might trigger when some other bug =

prevents a resume.

	Ingo
