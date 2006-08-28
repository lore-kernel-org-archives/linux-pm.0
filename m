From: Pavel Machek <pavel@suse.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Tue, 29 Aug 2006 00:18:37 +0200
Message-ID: <20060828221837.GB1335@elf.ucw.cz>
References: <20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com>
	<20060815010020.GA14251@kroah.com>
	<b324b5ad0608182319y307210a3w6389c83482e43ab8@mail.gmail.com>
	<20060819184843.GB15644@redhat.com>
	<b324b5ad0608192020n6584f749h501e05e141b1f557@mail.gmail.com>
	<20060820033044.GA24928@redhat.com>
	<b324b5ad0608262137y24cfb843kb03476a22e462516@mail.gmail.com>
	<c55240ed0608271354o7224c903l8b9eae6de22ca8c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <c55240ed0608271354o7224c903l8b9eae6de22ca8c6@mail.gmail.com>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

Okay, I never liked opPoint framework... so your critism seems okay,
but do your patches really solve all the points you raised?

On Sun 2006-08-27 13:54:31, Eugeny S. Mints wrote:
> 2006/8/26, David Singleton <daviado@gmail.com>:
> > On 8/19/06, Dave Jones <davej@redhat.com> wrote:
> > > On Sat, Aug 19, 2006 at 08:20:45PM -0700, David Singleton wrote:
...
> >        1) I believe I now have the right kernel interface for a common
> >        power management infrastructure.

> - md_data has an issue from OO design paradigm perspective.  OpPoint
> requires an entity above PowerOP to know internals of arch md_data (see
> centrino-dynamic-powerop.c implementation) and thus requires an arch

Is that what you were trying to solve with string parsing?
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
