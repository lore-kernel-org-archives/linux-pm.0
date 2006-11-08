From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: 2.6.19-rc5: known regressions
Date: Wed, 08 Nov 2006 04:18:46 -0700
Message-ID: <m1y7qm425l.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<20061108085235.GT4729@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061108085235.GT4729@stusta.de> (Adrian Bunk's message of "Wed,
	8 Nov 2006 09:52:35 +0100")
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>, gregkh@suse.de, Thierry Vignaud <tvignaud@mandriva.com>, discuss@x86-64.org, Ernst Herzberg <earny@net4u.de>, Aaron Durbin <adurbin@google.com>, Olivier Mondoloni <olivier.mondoloni@waika9.com>, Alex Romosan <romosan@sycorax.lbl.gov>, ak@suse.de, linux-ide@vger.kernel.org, oprofile-list@lists.sourceforge.net, Jens Axboe <jens.axboe@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Bryan O'Sullivan <bos@serpentine.com>, Linus Torvalds <torvalds@osdl.org>, linux-pm@osdl.org, Tim Chen <tim.c.chen@linux.intel.com>, Jeff Chua <jeff.chua.linux@gmail.com>, Paolo Ornati <ornati@fastwebnet.it>, phil.el@wanadoo.fr, Matthew Wilcox <matthew@wil.cx>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, mingo@redhat.com
List-Id: linux-pm@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> Subject    : x86_64: NR_IRQ increase causes 11.5% slowdown
>                      in lmbench's fork benchmark
> References : http://lkml.org/lkml/2006/11/2/192
> Submitter  : Tim Chen <tim.c.chen@linux.intel.com>
> Caused-By  : Eric W. Biederman <ebiederm@xmission.com>
>              commit 550f2299ac8ffaba943cf211380d3a8d3fa75301
> Status     : unknown

I'm not really certain who to cc on this one.

It appears the problem sequence is:
fork()
sched_setaffinity()

It got worse just because NR_IRQS doubled (and all of the associated
arrays doubled in size).

I haven't seen anyone reproduce this but Tim Chen, and Tim wasn't
able to root cause the problem so I believe we are going to have
this regression :(

Eric
