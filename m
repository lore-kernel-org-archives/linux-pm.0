From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Fri, 25 Aug 2006 21:55:43 +0200
Message-ID: <20060825195543.GA9568@elf.ucw.cz>
References: <221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com>
	<20060815010020.GA14251@kroah.com>
	<1155638115.6736.135.camel@localhost>
	<20060815190439.GI7612@redhat.com>
	<1155806337.30834.17.camel@localhost>
	<20060817214031.GE6450@ucw.cz>
	<acd2a5930608172242v7ba6e7eeq8ab90ea11175ef4c@mail.gmail.com>
	<20060823122849.GA23456@atrey.karlin.mff.cuni.cz>
	<acd2a5930608240558k4cc77dadxbd6175c05141fe23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <acd2a5930608240558k4cc77dadxbd6175c05141fe23@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thu 2006-08-24 16:58:50, Vitaly Wool wrote:
> On 8/23/06, Pavel Machek <pavel@ucw.cz> wrote:
> >> >
> >> >This seems to be too specific to embedded machine.
> >> >
> >> >If userspace wants to work with usb and play mp3s at the same time,
> >> >what does it do?
> >>
> >> I guess it just defines an appropriate policy. You can call it
> >> 'usb_mp3' if you wish ;)
> >> I don't think it's too embedded-specific.
> >
> >Well, it leads to exponential number of policies -- not nice. Having
> >usb_mp3_fileserver_webserver is not nice.
> =

> No. The reason is there's no _real_ difference in 'fileserver' and
> 'webserver' from the PM POV, so this will never happen.
> There's no reason to introduce different policies for different use
> cases which however imply similar peripherals utilization.
> Moreover, I never play MP3s on a fileserver/webserver. The example
> you've given is pretty much artificial.

My notebook has 23 different devices. Do you really want to have
8388608 policies for different perihepal utilizations?

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
