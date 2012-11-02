From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Linux 3.7-rc3
Date: Fri, 02 Nov 2012 23:23:33 +0100
Message-ID: <2471412.ilAVQkroSv@vostro.rjw.lan>
References: <CA+55aFwwTc4QXKqiECgE9NOE2zjC6GsGHHydGP9YDbgQSbw9Aw@mail.gmail.com> <CAKMK7uENP_XWQ7UWjd+PnqTH-S-jYRjrnfY1TwocfbT6abL61w@mail.gmail.com> <1490901.1Nt8OOcfdR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:53207 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753075Ab2KBWT1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 2 Nov 2012 18:19:27 -0400
In-Reply-To: <1490901.1Nt8OOcfdR@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Airlie <airlied@linux.ie>, Michal Hocko <mhocko@suse.cz>, Jiri Kosina <jkosina@suse.cz>

On Friday, November 02, 2012 10:56:22 PM Rafael J. Wysocki wrote:
> On Friday, November 02, 2012 10:43:02 PM Daniel Vetter wrote:
> > On Fri, Nov 2, 2012 at 10:40 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > Can you point me to a range of commits worth checking?
> > 
> > 8c3f929b6147e142..57df2ae9df6e335a98969cac is the core rework (plus a
> > bit related follow-up) without any other merges interfering. Might
> > oops if you open/close the lid without a suspend/resume cycle (since
> > that's only fixed later on), should otherwise work.
> 
> Well, as it turns out, v3.6.0 doesn't work too with my .config, so never
> mind (and thanks for help :-)).
> 
> I wonder what's wrong with my .config, though ...

Well, it appears that Tumbleweed has acquired a broken s2disk binary.
Replace it with one built from upstream sources and it magically starts to
work. Grumble.

Sorry for the noise.

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
