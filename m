From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: PowerOp Design and working patch
Date: Tue, 8 Aug 2006 08:54:58 -0500 (CDT)
Message-ID: <200608081354.k78DswXq003628@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: "Scott E. Preece"'s message of Tue, 8 Aug 2006 08:44:34 -0500
	(CDT)
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: preece@motorola.com
Cc: daviado@gmail.com, linux-pm@lists.osdl.org, pavel@ucw.cz, dsingleton@mvista.com
List-Id: linux-pm@vger.kernel.org


Note that I concur with Pavel and Tim that it would be better
to get the functionality working first, and worry about this after
we're sure the basic mechanisms work. However, it would make sense for
people reviewing the code to have in their minds the idea that it needs
to be dynamic in the future.

scott


| From preece@urbana.css.mot.com Tue Aug  8 08:44:35 2006
| Date: Tue, 8 Aug 2006 08:44:34 -0500 (CDT)
| From: "Scott E. Preece" <preece@motorola.com>
| CC: tim.bird@am.sony.com, daviado@gmail.com, linux-pm@lists.osdl.org,
| =

| =

| If you're a device manufacturer, and you build, say 50 devices that all
| use the same hardware but, because they are optimized for different
| functional use cases, have different preferred operating points and
| DVFS policies, it's *highly* desirable to not have to maintain 50
| separate builds for those devices.  Putting configuration information
| in places that can be changed independently of compilation is very
| important to us.
| =

| scott
| =

| =

| | From: Pavel Machek<pavel@ucw.cz>
| | =

| | Hi!
| | =

| | > >> Often, in the embedded world, the person defining the operating
| | > >> states will not be a kernel developer, and may not be comfortable
| | > >> with, or capable of, creating a kernel module.  (There are
| | > > =

| | > > That's okay, we can create HOWTO or something. 'System designed is =
too
| | > > stupid to hack kernel' should not be an argument.
| | > =

| | > It's not a matter of stupidity.  The example I gave of not being
| | > able to create a kernel module was the situation where loadable
| | > module support is not available.  A HOWTO wouldn't alter this.
| | =

| | So they need to recompile the kernel. Not a big deal when you are
| | developing new machine.
| | =

| | > > Maybe operating points need to be changed at runtime -- I do not th=
ink
| | > > so -- but *please* get the basic stuff in/merged ASAP and then add
| | > > features one-by-one.
| | > =

| | > I agree. :-)
| | =

| | Yes, I believe we are actually in agreement. Maybe features you want
| | will indeed be useful, but we want to get basics right, first.
| | 								Pavel
| | -- =

| | (english) http://www.livejournal.com/~pavelmachek
| | (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
| | _______________________________________________
| | linux-pm mailing list
| | linux-pm@lists.osdl.org
| | https://lists.osdl.org/mailman/listinfo/linux-pm
| | =

| =

| -- =

| scott preece
| motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

| e-mail:	preece@motorola.com	fax:	+1-217-384-8550
| phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
| =

| =

| =


-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
