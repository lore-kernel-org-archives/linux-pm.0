From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PowerOP, Intro 0/3
Date: Sat, 26 Aug 2006 10:28:48 +0200
Message-ID: <20060826082848.GC8538@elf.ucw.cz>
References: <44ECFC0E.10803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <44ECFC0E.10803@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> The PowerOP Core provides completely arch independent interface
> to create and control operating points which consist of arbitrary
> subset of power parameters available on a certain platform.
> =

> PowerOP Core upper layer interface provides the following capabilities:
> - to register an operating point by passing an idenificator of the point
> represened by a string and arbitrary substet of power paremeters availabl=
e on a
> certain platform by a string (parameter name) and value pairs.
> - to unregister operating point by name
> - to set operating point by name
> - to get values of arbitrary subset of platform power parameters associat=
ed
> this  a point (point is passed by name or NULL to get current parameter v=
alues
> from hw)

I do not think this can work in notebook world, sorry. You'll just get
way too many operating points.

Workable solution would be to create power domains, and group devices
into power domains.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
