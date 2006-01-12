From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC: -mm patch] swsusp: make some code static
Date: Thu, 12 Jan 2006 16:29:35 +0100
Message-ID: <20060112152935.GD9752@elf.ucw.cz>
References: <20060111042135.24faf878.akpm@osdl.org> <20060112104812.GR29663@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751250AbWALP3p@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060112104812.GR29663@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On =C4=8Ct 12-01-06 11:48:12, Adrian Bunk wrote:
> On Wed, Jan 11, 2006 at 04:21:35AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.15-mm2:
> >...
> > +swsusp-low-level-interface-rev-2.patch
> >...
> >  swsusp updates
> >...
>=20
> After this patch, we can make some code static.
>=20
>=20
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Rafael should comment here. It is okay, but Rafael has some patches in
the queue, and it would be better if there were to clashes.
								Pavel

--=20
Thanks, Sharp!
