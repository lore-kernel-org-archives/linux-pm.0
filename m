From: Avi Kivity <avi@qumranet.com>
Subject: Re: [patch] KVM: T60 resume fix
Date: Mon, 05 Mar 2007 10:50:04 +0200
Message-ID: <45EBD9BC.4030801@qumranet.com>
References: <20070227111515.GA4271@kernel.dk> <20070301093450.GA8508@elte.hu>
	<20070301104117.GA22788@elte.hu> <20070301145204.GA25304@elte.hu>
	<Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org>
	<20070302072100.GB30634@elte.hu> <20070302080441.GA12785@elte.hu>
	<20070302102018.GA11549@elte.hu> <20070302102216.GA13575@elte.hu>
	<45E93012.4000100@qumranet.com> <20070305082251.GA23366@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070305082251.GA23366@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Walker <dwalker@mvista.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Ingo Molnar wrote:
> * Avi Kivity <avi@qumranet.com> wrote:
>
>   =

>>> my T60 laptop does not resume correctly due to KVM attempting to =

>>> send an IPI to a CPU that might be down (or not up yet). (Doing so =

>>> also triggers the send_IPI_mask_bitmask() warning in =

>>> arch/i386/kernel/smp.c, line 732.)
>>>
>>> with this fix applied my laptop does not hang during resume.
>>>
>>> [ KVM will have to disable/enable virtualization on the CPU itself =

>>>  that goes down / comes up, not via an IPI sent from the requesting
>>> CPU. ]
>>>       =

>
>   =

>> That is already CPU_ONLINE in my tree (and in the pull request sent to =

>> Linus a couple of days ago).
>>     =

>
> that solves the resume problem - but doesnt solve the CPU_DEAD issue of =

> sending an IPI to an already offline CPU. Might be a better idea to do =

> it in CPU_DOWN_PREPARE? (and then to also add a CPU_DOWN_FAILED branch?)
>
> 	=


Mainline now has DOWN_PREPARE and UP_CANCELED calling =

->hardware_disable(), and ONLINE calling ->hardware_enabled().  What =

tree are you looking at?

[but I do see the need for DOWN_FAILED now. Off to find a resumable =

machine...]


-- =

Do not meddle in the internals of kernels, for they are subtle and quick to=
 panic.
