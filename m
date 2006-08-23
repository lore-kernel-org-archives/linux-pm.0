From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Wed, 23 Aug 2006 18:26:26 +0300
Message-ID: <1156346786.20566.36.camel@Dogbert.NOE.nokia.com>
References: <c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com><20060815010020.GA14251@kroah.com>
	<1155638115.6736.135.camel@localhost><20060815190439.GI7612@redhat.com>
	<1155806337.30834.17.camel@localhost><20060817214031.GE6450@ucw.cz>
	<acd2a5930608172242v7ba6e7eeq8ab90ea11175ef4c@mail.gmail.com>
	<20060823122849.GA23456@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060823122849.GA23456@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ext Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2006-08-23 at 15:28 +0300, ext Pavel Machek wrote:
> > On 8/18/06, Pavel Machek <pavel@ucw.cz> wrote:
> > >> Then, we will be able to use names like 'video', 'mp3', 'fast',
> > >> 'powersave', 'usb' to switch to the relevant operating point
> based on
> > >> configuration of the policy manager.
> > >
> > >This seems to be too specific to embedded machine.
> > >
> > >If userspace wants to work with usb and play mp3s at the same time,
> > >what does it do?
> >
> > I guess it just defines an appropriate policy. You can call it
> > 'usb_mp3' if you wish ;)
> > I don't think it's too embedded-specific.
> =

> Well, it leads to exponential number of policies -- not nice. Having
> usb_mp3_fileserver_webserver is not nice.

The whole idea is that you have generic "good enough" policies for
unknown cases-combinations, plus specific policies for well known cases.
This tends to be simpler for embedded systems, of course.

But even for your laptops you can identify few major use cases, that
incidentally tend to overlap with embedded devices use cases:
-mp3
-video
-browsing
-name your own
...

-- =

Cheers,
           Igor

Igor Stoppa (Nokia M - OSSO / Tampere)
