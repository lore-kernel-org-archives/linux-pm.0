From: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp3: system suspend/resume from userspace
Date: Thu, 1 Sep 2005 17:11:06 +0200
Message-ID: <20050901151105.GA1561@openzaurus.ucw.cz>
References: <20050901110539.GA1926@elf.ucw.cz>
	<1125575747.4785.20.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============016939743361600312=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1125575747.4785.20.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============016939743361600312==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > This is preview of what I'm doing. I call it swsusp3 for the
> > moment. Idea is to push image reading and writing to userspace, so it
> > can be compressed, can have nice progress bar etc.
> > 
> > In the current state I do not write image anywhere, and user <->
> > kernel interface is *very* ugly, but you get the idea. It should allow
> > us to do most of stuff suspend2 does _and_ shrink kernel a bit at the
> > same time.
> > 
> > Warning: Preview only. Code is ugly and probably broken.
> 
> Ummm... it's really hard to know what to say. I guess I'll just have to
> wait and see how you progress.
> 
> A few general comments:
> 
> - I don't see any indication of support for storing a complete image of memory. Planning it?

I was afraid you would ask. This is the area where I don't know how to
do it cleanly. I could only free as much memory as strictly neccessary;
that should leave pagecache "mostly intact". Perhaps that would be good enough?

> - Aren't new syscalls generally viewed as pretty undesirable?

Well, yes, they are, except when alternatives are worse.

> - Should comments be in English?

Is there some czech comment in there? Well code is very ugly at places, "first
make it work, then make it cleaner".

				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============016939743361600312==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============016939743361600312==--
