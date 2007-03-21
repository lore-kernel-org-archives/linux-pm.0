From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] dynamic device power management proposal
Date: Wed, 21 Mar 2007 22:45:15 +0100
Message-ID: <20070321214515.GC6057@elf.ucw.cz>
References: <200703212019.l2LKJdbj029831@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200703212019.l2LKJdbj029831@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> | > > No, that's not how it works; look at hda_audio, it already has
> | > > powersave. Just power down audio card 5 seconds after its control f=
ile
> | > > is closed.
> | > It's another case of doing policy in a driver.
> | >
> | =

> | IMHO, this kind of policy is best handled inside the driver because it
> | is specific to the hardware. This will ensure that the driver will
> | just work on every distro without some userspace policy being present
> | and setup _correctly_.
> ---
> =

> On an embedded device, the knowledge of when it makes sense to keep a
> disk spinning, to avoid latency when it's needed next, versus when it
> makes sense to spin it down to save power, probably fits better in user
> space than in the kernel. In such a case there's likely to be a "master"
> application (in our case, for instance, "the phone application") that
> owns a lot of knowledge about whole-system state and user interactions.
> Not, of course, that we have a disk to spin down.

Agreed. Please use existing interfaces. Patch to spin disk down and
keep it down is available... but hdparm -y is enough for you.

> On the other hand, we also have devices that do their own power saving,
> largely in cases where they don't have latency issues large enough to
> worry about.

Yep. =


And we do not need great new handwavy framework for
this... please. Just add support for platform you care about.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
