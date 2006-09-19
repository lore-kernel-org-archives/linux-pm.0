From: Pavel Machek <pavel@ucw.cz>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Tue, 19 Sep 2006 20:20:11 +0200
Message-ID: <20060919182011.GC7099@elf.ucw.cz>
References: <20060917124639.GE2741@elf.ucw.cz>
	<ADE4D9DBCFC3A345AAA95C195F62B6DD01BB2484@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <ADE4D9DBCFC3A345AAA95C195F62B6DD01BB2484@de01exm64.ds.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Preece Scott-PREECE <scott.preece@motorola.com>
Cc: Matthew Locke <matthew.a.locke@comcast.net>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Of course I am unfair. It is nice that motorola ships =

> > linux-based cellphones, but they made really sure that users =

> > can't hack them... which is considered anti-social by the community. =

> > =

> > So it would be nice if kernel matched requirements by =

> > Motorola, but it is *way* more important that it matches =

> > requirements by Sharp and notebook requirements... because =

> > Sharp & notebook manufacturers actually play fair.
> ---
> =

> Depends, of course, on your definition of "fair". The CE =

> manufacturers are investing a lot of work in Linux, either
> directly or through hiring developers and working through
> distributors. And they're giving their enhancements back
> to the community, which is what was generally considered
> "fair" for open-source development. The power management

Well, CE equipment usually uses obsolete, heavily modified kernels,
and developed in-house (as opposed by community). Yes, it is nice that
Motorola uses Linux and not WindowsCE...

> stuff may be too narrow to be interesting to laptop-based
> developers,but things like reduced boot time ought to be
> Of more general interest.

Yep, boottime reductions are always nice... if they are not too specialized.

> I expect modifiable kernels in the future, but that requires
> a lot of extra engineering (beyond just making the device
> work) to harden the non-open elements so that malicious
> kernel changes couldn't compromise them. None of the

What is the issue here? I thought that GSM stack runs on separate CPU,
anyway? And in practice, it is probably possible to flash your
equipment... Like small shops offering "unlocking" do it all the time.

> manufacturers is going to build a cellphone or DVR that
> service providers won't allow on their networks...

What is the issue? I can do whatever I want (including modifying
phone-side firmware so that phone works without SIMcard, just with Ki)
with siemens ME45 already. Of course Siemens will not support me doing
that... That should not be too different with Motorola...?
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
