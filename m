From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
Subject: Re: [linux-pm] [RFC] userland swsusp
Date: Wed, 16 Nov 2005 06:35:30 +0200
Message-ID: <1132115730.2499.37.camel@localhost>
References: <20051115212942.GA9828@elf.ucw.cz>
	 <20051115222549.GF17023@redhat.com>  <20051115233201.GA10143@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965233AbVKPEfv@vger.kernel.org>
In-Reply-To: <20051115233201.GA10143@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Jones <davej@redhat.com>, kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

=C3=8En data de Mi, 16-11-2005 la 00:32 +0100, Pavel Machek a scris:
> ...but how do you provide nice, graphical progress bar for swsusp
> without this? People want that, and "esc to abort", compression,
> encryption. Too much to be done in kernel space, IMNSHO.

Pavel, you really should _listen_ when someone else is talking about th=
e
same things in different implementations. suspend2 has this feature
(nice graphical progress bars in userspace) for a long time now and it'=
s
compatible with the fedora kernels.

Why don't you and Nigel (of suspend2) can just work together on this ?
It's a shame that much work is wasted in duplicated effort.

--=20
Cioby
