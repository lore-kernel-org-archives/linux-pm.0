From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: NULL pointer dereference in swsusp_free with 3.17-rc5
Date: Thu, 25 Sep 2014 22:26:03 +0200
Message-ID: <3373215.T4kTmy0SBC@vostro.rjw.lan>
References: <87zjdq8k7i.fsf@nemi.mork.no> <20140925091318.GA4269@suse.de> <87sijg6kcf.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53343 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750933AbaIYUGN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Sep 2014 16:06:13 -0400
In-Reply-To: <87sijg6kcf.fsf@nemi.mork.no>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: Joerg Roedel <jroedel@suse.de>, linux-pm@vger.kernel.org

On Thursday, September 25, 2014 12:54:56 PM Bj=C3=B8rn Mork wrote:
> Joerg Roedel <jroedel@suse.de> writes:
> > On Thu, Sep 25, 2014 at 09:20:58AM +0200, Bj=C3=B8rn Mork wrote:
> >> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

[cut]

>=20
> > Anyway, it would be great if you could test the patch below :)
>=20
> The patch works fine for me.  Thanks.  I look forward to the next
> revision of this set.  It looks like a really nice cleanup. And I am
> sorry that I didn't catch the bug earlier in the 3.17 cycle.

I'm only going to revert the commit in question as the rest should just
work without this one, only less efficiently.

So I'll be waiting for a resend of it with the patch that you've just t=
ested
folded in after 3.18-rc is out.

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
