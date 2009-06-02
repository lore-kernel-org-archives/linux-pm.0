From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Date: Tue, 2 Jun 2009 23:37:22 +0200
Message-ID: <20090602213722.GA1972__29911.3988563933$1243978705$gmane$org@ucw.cz>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
	<877i01p2t8.fsf@deeprootsystems.com>
	<aec7e5c30905290217s651e5785s2ceaebbe1856d120@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <aec7e5c30905290217s651e5785s2ceaebbe1856d120@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: paul@pwsan.com, gregkh@suse.de, linux-pm@lists.linux-foundation.org, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!


> > In the process of discussing a similar interface for OMAP, we dicussed
> > that having 3 states would be more useful. =A0Specifically, and
> > _enable(), _idle() and _disable() hook. =A0The _enable() and _idle()
> > hooks being exactly what you proposed above, but with the addition of
> > a _disable() hook which says not only can the device go idle, but that
> > the driver is really finished with the device. =A0In this case, more
> > aggresive PM measures could be taken, such as turning of regulators
> > that may have long latencies that may not be appropriate to turn off
> > in idle.
> =

> Hm.. I wonder when the driver is really finished with the device
> though. Only when the module is unloaded? If so then we could deal
> with the hard disable using platform bus notifiers (like in [04/04]).

I'd guess that they call disable() when /dev node is closed... and
idle() when device is opened but inactive.

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
