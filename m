From: "Preece Scott-PREECE" <scott.preece@motorola.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Tue, 19 Sep 2006 15:11:13 -0400
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DD01BB2D20@de01exm64.ds.mot.com>
References: <20060919182011.GC7099@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
In-Reply-To: <20060919182011.GC7099@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Locke <matthew.a.locke@comcast.net>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

> From: Pavel Machek [mailto:pavel@ucw.cz] =

> =

> ... because Sharp & notebook manufacturers =

> > > actually play fair.
> > ---
> > =

> > Depends, of course, on your definition of "fair". The CE =

> manufacturers =

> > are investing a lot of work in Linux, either directly or through =

> > hiring developers and working through distributors. And =

> they're giving =

> > their enhancements back to the community, which is what was =

> generally =

> > considered "fair" for open-source development. The power management
> =

> Well, CE equipment usually uses obsolete, heavily modified =

> kernels, and developed in-house (as opposed by community). =

> Yes, it is nice that Motorola uses Linux and not WindowsCE...
---

There are perfectly sensible business reasons why device manufacturers
need to freeze their development on old kernels (and other components)
for long periods of time. Are you saying this is "unfair" to the
developers? I understand that it makes the patches less useful, in
many cases, but unfair?

I do hope that Motorola, and other CE manufacturers, will start working
more closely with the community.  The CE Linux Forum was set up in part
to make that easier and more effective. I believe it would be better =

for both the manufacturers and the community.

---
> ... =

> > I expect modifiable kernels in the future, but that =

> requires a lot of =

> > extra engineering (beyond just making the device
> > work) to harden the non-open elements so that malicious =

> kernel changes =

> > couldn't compromise them. None of the
> =

> What is the issue here? I thought that GSM stack runs on =

> separate CPU, anyway? And in practice, it is probably =

> possible to flash your equipment... Like small shops offering =

> "unlocking" do it all the time.
---
[NOTE again that I do not speak for Motorola in this mailing list;
these comments are not based on direct knowledge of policy, and
IANAL!]

The issue is "due diligence" - a manufacturer could be held liable
for damage done by a modified device if they have not made a good
faith effort to make such modification either (a) safe or
(b) very difficult. Yes, this is non-value-add work, but there are
people in the world who do malicious things, and manufacturers are
very worried about courts finding that they were negligent in
not making a greater effort to stop such malicious people.

There is also a liability issue with non-malicious changes, in that
manufacturers can sometimes be held liable for things that users
do to themselves. [If you believe that disclaimers of liability or =

warranty will actually protect you in court, you're probably =

being na=EFve.]

There are also, of course, contractual issues with carriers and
content owners, who could also sue if a manufacturer didn't make a
sufficient effort to protect the terms of the contract. The
carriers and content owners are continually raising the bar on the
level of protection they require.

---
> =

> > manufacturers is going to build a cellphone or DVR that service =

> > providers won't allow on their networks...
> =

> What is the issue? I can do whatever I want (including =

> modifying phone-side firmware so that phone works without =

> SIMcard, just with Ki) with siemens ME45 already. Of course =

> Siemens will not support me doing that... That should not be =

> too different with Motorola...?
---

While legal specifics may vary from country to country, for US
Manufacturers, the same issues as above...

scott
