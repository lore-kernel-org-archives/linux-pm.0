From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [patch[ epoll_ctl.2, epoll.7: document EPOLLWAKEUP
Date: Mon, 07 Jul 2014 13:26:49 +0200
Message-ID: <17155391.vo4GYroE0r@vostro.rjw.lan>
References: <20140706190351.423e9a93@notabene.brown> <53BA4244.30502@gmail.com> <20140707210157.1aa38ed0@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140707210157.1aa38ed0-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Monday, July 07, 2014 09:01:57 PM NeilBrown wrote:
> 
> --Sig_/ryAieyiS4Xod5WCxzxhl62b
> Content-Type: text/plain; charset=US-ASCII
> Content-Transfer-Encoding: quoted-printable
> 
> 
> (adding lkml and linux-pm and I probably should have done from the start).

First off, thanks a lot for taking care of this!

> On Mon, 07 Jul 2014 08:46:28 +0200 "Michael Kerrisk (man-pages)"
> <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> > Hi Neil,
> >=20
> > On 07/06/2014 11:03 AM, NeilBrown wrote:
> > >=20
> > >=20
> > > Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
> > > --
> > >=20
> > > I noticed that this was missing so had a go at writing something.
> >=20
> > Thanks. I applied this, and also added the additional piece shown=20
> > at the end of this mail.
> >=20
> > > Is there / Should there be a section 7 man page describing suspend and
> > > autosuspend and wakelocks etc??
> >=20
> > Sounds like it might be useful, but I don't know for sure. On the=20
> > assumption that it might be possible to convince you to write one,
> > could you briefly list what you think should be covered in the page?
> 
> I was particularly thinking of "/sys/power/autosleep" because my change to
> epoll.7 mentioned autosleep, but there was no man page to reference.
> The interaction of /sys/power/wakeup_count" with suspend/resume is also wor=
> th
> documenting as is the use of wake_locks via /sys/power/wake_{,un}lock (which
> could also usefully be referenced by epoll(7)).
> 
> Given the number of filenames here, maybe this belongs in section 5 rather
> than section 7.  Similar to proc(5) we could have power(5) which
> documents /sys/power ???
> (OK, I can see this might be opening a can of worms - we'll be having
> class(5) and bus(5) and devices(5) next... but maybe this is a good thing.
> And seeing these are all part of the kernel API, maybe they should be in
> section 2 with the systemcalls.  Or do with need a new section of API virtu=
> al
> files ....)
> 
> So I guess "ls /sys/power" is a brief list of what should be included in the
> page :-)

That probably is a good estimation.

Please note that there is some documentation of these things in
Documentation/ABI/testing/sysfs-power in the kernel tree that may be useful
for creating that page.

Also please let me know if I can help.

Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-man" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
