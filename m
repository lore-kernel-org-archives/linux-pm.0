From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: freeze_processes questions
Date: Fri, 8 Apr 2005 08:23:06 +0200
Message-ID: <20050408062306.GB1381@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0504071549040.1071-100000@ida.rowland.org>
	<200504072303.15502.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============98380732476828181=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504072303.15502.rjw@sisk.pl>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@cyclades.com>
List-Id: linux-pm@vger.kernel.org

--===============98380732476828181==
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id j386NMs3017390

On =C4=8Ct 07-04-05 23:03:15, Rafael J. Wysocki wrote:
> Hi,
>=20
> On Thursday, 7 of April 2005 22:00, Alan Stern wrote:
> > On Thu, 7 Apr 2005, Rafael J. Wysocki wrote:
> ]--snip--[=20
> > > > If that means waiting more than 10 seconds or so, you should just=
 give up. =20
> > > > Return an error and put a message in the log saying something lik=
e "Can't
> > > > suspend because process XXX is busy".
> > >=20
> > > OK, that's what we do now.  Except that IMO we should clear the PF_=
FREEZE flag
> > > for this process and do recalc_sigpending() for it after we give up=
, because
> > > otherwise it will enter the refrigerator sooner or later and it wil=
l stay there.
> > > Alternatively, we can disable the "freezing loop" in refrigerator()=
 as soon as
> > > thaw_processes() is started.  Also, we can avoid setting PF_FREEZE =
for
> > > processes in TASK_UNINTERRUPTIBLE, but count them as "freezable".  =
Etc.
> >=20
> > Yes, all the necessary cleanup steps should be taken.
>=20
> Pavel, which approach do you like most?

Clearing PF_FREEZE when we fail to stop some process sounds okay to
me. It would be nice if the patch was actually tested ;-).

I do not think you can deal with TASK_UNINTERRUPTIBLE in some
reasonable way... If you do something with them be sure to make it
separate patch :-).
							Pavel
--=20
Boycott Kodak -- for their patent abuse against Java.

--===============98380732476828181==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============98380732476828181==--
