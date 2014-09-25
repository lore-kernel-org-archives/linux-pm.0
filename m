From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: NULL pointer dereference in swsusp_free with 3.17-rc5
Date: Thu, 25 Sep 2014 09:20:58 +0200
Message-ID: <87egv0i2sl.fsf@nemi.mork.no>
References: <87zjdq8k7i.fsf@nemi.mork.no> <20140924095111.GC10438@suse.de>
	<87vbodiaq9.fsf@nemi.mork.no> <19091504.rBv2mCrhao@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:58914 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbaIYHVW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Sep 2014 03:21:22 -0400
In-Reply-To: <19091504.rBv2mCrhao@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Thu, 25 Sep 2014 01:44:12 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Joerg Roedel <jroedel@suse.de>, linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> I've decided to go with a revert for 3.17, as we don't seem to have a=
n immediate
> fix and the final 3.17 may be as close as this Sunday.  So I'm going =
to send my
> final pull request for 3.17 to Linus tomorrow or early on Friday.

Sounds safest to me, FWIW.

=46or the next round of this, I think the only missing part was some te=
st
like

        if (!forbidden_pages_map || !free_pages_map)
           goto return_without_freeing_anything;

at the beginning of swsusp_free().  I think we can agree that it isn't
necessary to repeat that test for every page like the old code did :-)

But I I believe it would be useful to analyze exactly why this is
necessary, and possibly add a comment with that explanation.  I don't
have any other arguments for the test than the old code and the oops.
If this is how it is designed then that would be nice to spell out.  If
not, then maybe there is a flaw somewhere else that should be fixed
instead.

And BTW, I believe it would be useful if at least one more person in th=
e
world tested hibernation between each release ;-)


Bj=C3=B8rn

