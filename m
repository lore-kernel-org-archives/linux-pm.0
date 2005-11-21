From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] userland swsusp
Date: Mon, 21 Nov 2005 15:19:54 +0100
Message-ID: <20051121141954.GB1655@elf.ucw.cz>
References: <20051115212942.GA9828@elf.ucw.cz>
	<20051120214832.GC28918@redhat.com>
	<20051120220904.GB24132@elf.ucw.cz>
	<200511211247.45558.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2525613012467629=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200511211247.45558.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

--===============2525613012467629==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > With what we have in-kernel, and a restricted /dev/mem, achieving the
> > > attack you mention is a lot less feasible, as the attacker has no access
> > > to the memory being written out to the suspend partition, even as root.
> > > Even if they did, people tend to notice boxes shutting down pretty quickly
> > > making this a not-very-stealthy attack.
> > 
> > Can I read somewhere about security model you are using? Would it be
> > enough to restrict /dev/[k]mem to those people that have right to
> > update kernel anyway? Or your approach is "noone, absolutely noone has
> > right to modify running kernel"? [Do you still use loadable modules?]
> 
> The problem is that, whatever the security model, if you have access to the
> kernel memory (eg. via /dev/kmem), you can modify the security rules
> themselves, so this should better be avoided.

Well, under current linux security model, root has all permissions,
including inserting modifying running kernel, touching hardware
directly, and installing rootkits. Fedora may be trying to change
that... but if so, I'd like to know what they are planning.
								Pavel
-- 
Thanks, Sharp!

--===============2525613012467629==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============2525613012467629==--
