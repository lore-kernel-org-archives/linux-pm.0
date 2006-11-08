From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19-rc5: known regressions
Date: Wed, 8 Nov 2006 07:47:07 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611080745150.3667@g5.osdl.org>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<20061108085235.GT4729@stusta.de>
	<m1y7qm425l.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <m1y7qm425l.fsf@ebiederm.dsl.xmission.com>
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
Cc: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>, gregkh@suse.de, Thierry Vignaud <tvignaud@mandriva.com>, discuss@x86-64.org, Ernst Herzberg <earny@net4u.de>, Aaron Durbin <adurbin@google.com>, Olivier Mondoloni <olivier.mondoloni@waika9.com>, Alex Romosan <romosan@sycorax.lbl.gov>, ak@suse.de, linux-ide@vger.kernel.org, oprofile-list@lists.sourceforge.net, Jens Axboe <jens.axboe@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Bryan O'Sullivan <bos@serpentine.com>, linux-pm@osdl.org, Tim Chen <tim.c.chen@linux.intel.com>, Jeff Chua <jeff.chua.linux@gmail.com>, Paolo Ornati <ornati@fastwebnet.it>, phil.el@wanadoo.fr, Matthew Wilcox <matthew@wil.cx>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, mingo@redhat.comK
List-Id: linux-pm@vger.kernel.org



On Wed, 8 Nov 2006, Eric W. Biederman wrote:
> =

> I haven't seen anyone reproduce this but Tim Chen, and Tim wasn't
> able to root cause the problem so I believe we are going to have
> this regression :(

Note that you really shouldn't look too closely at lmbench scheduling =

fluctuations. They can fluctuate a _lot_, especially under SMP, and it can =

depend on things like cache layout that has nothing to do with the =

scheduler (ie just code movement can make the lmbench numbers change).

So there are "regressions" and there are "shit happens". It can sometimes =

be hard to tell the two apart, of course ;)

		Linus
