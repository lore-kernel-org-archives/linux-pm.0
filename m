From: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp: which page should be saved?
Date: Fri, 17 Mar 2006 07:59:37 +0100
Message-ID: <20060317065937.GH2674@elf.ucw.cz>
References: <1142481207.26706.16.camel@sli10-desk.sh.intel.com>
	<20060315230846.GB2462@ucw.cz>
	<1142557935.26706.26.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1142557935.26706.26.camel@sli10-desk.sh.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On P=E1 17-03-06 09:12:15, Shaohua Li wrote:
> On Thu, 2006-03-16 at 07:08 +0800, Pavel Machek wrote:
> > On Thu 16-03-06 11:53:27, Shaohua Li wrote:=20
> > > I thought there was a discussion before, but I still saw many pages
> > like=20
> > > BIOS reserved are saved/restored in swsusp. Pages reserved by BIOS,
> > not=20
> > > used by OS and kernel text should be skipped in swsusp to me. Below=
=20
> > > patch works in my test. Any thought?
> >=20
> > This will need quite a lot of testing.
> >=20
> > Does it actually fix anything?
> No, it doesn't. Just want to speed up swsusp.
>=20
> > I'm afraid that some of the BIOSs state is actually shared knowledge=20
> > with kernel, and that we should better save it, so that kernel's and=20
> > BIOS's view are consistent after resume.
> Fair enough. ACPI BIOS does communicate with OS by reserved memory. But
> in the mean time, blindly save/restore such mem might be dangerous. If
> all ACPI devices have their suspend/resume method, reserved memory
> should not be saved.

Ok, I guess it is okay to go in if it stays in -mm for long enough to
get a lot of testing.

> Anyway, skipping kernel text should be safe, isn't it?

It probably is. But you need to save modules. And we do use some
self-modifying code these days, no? (Called runtime patching or
something like that.) Ouch and IIRC top-level pagedir or something
like that lives in kernel "text" -- it is in assembly and wrongly
placed.

So yes, it would be nice, but yes, it might be tricky.

								Pavel
--=20
82:        return SampleTable;
