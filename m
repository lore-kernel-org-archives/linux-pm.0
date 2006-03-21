From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: swsusp: which page should be saved?
Date: Tue, 21 Mar 2006 10:19:28 +0800
Message-ID: <1142907568.11430.16.camel@sli10-desk.sh.intel.com>
References: <1142481207.26706.16.camel@sli10-desk.sh.intel.com>
	<20060315230846.GB2462@ucw.cz>
	<1142557935.26706.26.camel@sli10-desk.sh.intel.com>
	<20060317065937.GH2674@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============29260072303490636=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060317065937.GH2674@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============29260072303490636==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k2L2KgDZ029991

On Fri, 2006-03-17 at 14:59 +0800, Pavel Machek wrote:
> On P=C3=A1 17-03-06 09:12:15, Shaohua Li wrote:=20
> > On Thu, 2006-03-16 at 07:08 +0800, Pavel Machek wrote:=20
> > > On Thu 16-03-06 11:53:27, Shaohua Li wrote: =20
> > > > I thought there was a discussion before, but I still saw many
> pages=20
> > > like =20
> > > > BIOS reserved are saved/restored in swsusp. Pages reserved by
> BIOS,=20
> > > not =20
> > > > used by OS and kernel text should be skipped in swsusp to me.
> Below =20
> > > > patch works in my test. Any thought?=20
> > > =20
> > > This will need quite a lot of testing.=20
> > > =20
> > > Does it actually fix anything?=20
> > No, it doesn't. Just want to speed up swsusp.=20
> > =20
> > > I'm afraid that some of the BIOSs state is actually shared
> knowledge =20
> > > with kernel, and that we should better save it, so that kernel's
> and =20
> > > BIOS's view are consistent after resume.=20
> > Fair enough. ACPI BIOS does communicate with OS by reserved memory.
> But=20
> > in the mean time, blindly save/restore such mem might be dangerous.
> If=20
> > all ACPI devices have their suspend/resume method, reserved memory=20
> > should not be saved.
>=20
> Ok, I guess it is okay to go in if it stays in -mm for long enough to=20
> get a lot of testing.
I'll do more tests and back to you. BTW, I wonder if BIOS already saved
reserved memory (those doing communication with OS) in the 'platform'
method of S4.

> > Anyway, skipping kernel text should be safe, isn't it?
>=20
> It probably is. But you need to save modules.=20
I just consider the region from kernel start(1M) to the end of rodata.
In my test, the region is about 4M memory. Just adding several lines to
save 4M memory is worthy.

> And we do use some=20
> self-modifying code these days, no? (Called runtime patching or=20
> something like that.)=20
Alternative instructions? The resume OS will do the same modification
anyway.
> Ouch and IIRC top-level pagedir or something=20
> like that lives in kernel "text" -- it is in assembly and wrongly=20
> placed.
i386 does the right thing and put the pagedir in data segment. x86_64
not, I think we could clean it up.

Thanks,
Shaohua



--===============29260072303490636==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============29260072303490636==--
