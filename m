From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [patch] KVM: T60 resume fix
Date: Mon, 5 Mar 2007 12:40:13 +0200
Message-ID: <20070305104013.GC5029@mellanox.co.il>
References: <20070302102018.GA11549@elte.hu> <20070302102216.GA13575@elte.hu>
	<45E93012.4000100@qumranet.com> <20070305082251.GA23366@elte.hu>
	<45EBD9BC.4030801@qumranet.com> <20070305084449.GA1706@elte.hu>
	<20070305085718.GA2513@elte.hu> <45EBE288.8010101@qumranet.com>
	<20070305100537.GA9175@elte.hu> <45EBF1E3.4030003@qumranet.com>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45EBF1E3.4030003@qumranet.com>
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
Cc: Daniel Walker <dwalker@mvista.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

> Quoting Avi Kivity <avi@qumranet.com>:
> Subject: Re: [patch] KVM: T60 resume fix
> =

> Ingo Molnar wrote:
> > * Avi Kivity <avi@qumranet.com> wrote:
> >
> >   =

> >>> suspend/resume works fine now and there are no warning messages =

> >>> whatsoever (with suspend simulation). Thanks Avi!
> >>>       =

> >> Where do I find this suspend simulation?  Sounds like a great suspend =

> >> debugging tool.
> >>     =

> >
> > it's just the simple hack below.
> >
> >
> >   =

> =

> Thanks, I'll put it to good use.  Are you planning to upstream it?  Not =

> for 2.6.21, presumably ;)

I think Pavel wants it triggerable through /sys/power/state:
http://lkml.org/lkml/2007/1/25/99

-- =

MST
