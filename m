From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 1/23] Add missing
	device_suspsend(PMSG_FREEZE) calls.
Date: Wed, 27 Jul 2005 19:12:30 -0600
Message-ID: <m1k6jb7myp.fsf@ebiederm.dsl.xmission.com>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<1122400462.4382.13.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============85253204871967481=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1122400462.4382.13.camel@localhost> (Nigel Cunningham's
	message of "Wed, 27 Jul 2005 03:54:23 +1000")
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ncunningham@cyclades.com
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============85253204871967481==
Content-Type: text/plain; charset=us-ascii

Nigel Cunningham <ncunningham@cyclades.com> writes:

> Hi.
>
> Could you please send PMSG_* related patches to linux-pm at
> lists.osdl.org as well?

I'll try.  My goal was not to add or change not functionality but to
make what the kernel was already doing be consistent.

It turns out the device_suspend(PMSG_FREEZE) is a major pain
sitting in the reboot path and I will be submitting a patch to
remove it from the reboot path in 2.6.13 completely.

At the very least the ide driver breaks, and the e1000 driver
is affected.

And there is of course the puzzle of why there exists simultaneously
driver shutdown() and suspend(PMSG_FREEZE) methods as I believed they
are defined to do exactly the same thing.

Eric


--===============85253204871967481==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============85253204871967481==--
