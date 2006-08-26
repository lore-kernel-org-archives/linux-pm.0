From: Pavel Machek <pavel@suse.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Sat, 26 Aug 2006 15:46:53 +0200
Message-ID: <20060826134653.GQ10257@elf.ucw.cz>
References: <20060815190439.GI7612@redhat.com>
	<1155806337.30834.17.camel@localhost>
	<20060817214031.GE6450@ucw.cz>
	<acd2a5930608172242v7ba6e7eeq8ab90ea11175ef4c@mail.gmail.com>
	<20060823122849.GA23456@atrey.karlin.mff.cuni.cz>
	<acd2a5930608240558k4cc77dadxbd6175c05141fe23@mail.gmail.com>
	<20060825195543.GA9568@elf.ucw.cz>
	<acd2a5930608251626t36fb1e79w27acd1eaa6fe5947@mail.gmail.com>
	<20060826101820.GI10257@elf.ucw.cz>
	<acd2a5930608260630l52c914c0h207866a32a3def4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <acd2a5930608260630l52c914c0h207866a32a3def4a@mail.gmail.com>
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

On Sat 2006-08-26 17:30:40, Vitaly Wool wrote:
> Hi Pavel,
> =

> On 8/26/06, Pavel Machek <pavel@suse.cz> wrote:
> >Hi!
> >
> >> >> No. The reason is there's no _real_ difference in 'fileserver' and
> >> >> 'webserver' from the PM POV, so this will never happen.
> >> >> There's no reason to introduce different policies for different use
> >> >> cases which however imply similar peripherals utilization.
> >> >> Moreover, I never play MP3s on a fileserver/webserver. The example
> >> >> you've given is pretty much artificial.
> >> >
> >> >My notebook has 23 different devices. Do you really want to have
> >> >8388608 policies for different perihepal utilizations?
> >>
> >> Can you please elaborate on how this number corresponds to the reality?
> >> Looks like you don't catch what I'm saying. I'm talking about use
> >> case-driven model in which you will need to invent 8388608 use cases
> >> basically in order to have 8388608 policies. IOW, not any combination
> >> is valid within these 8388608.
> >
> >I'm saying that usecase-driven model is not acceptable for a
> >kernel. It is not kernel's business to limit user to particular usage
> >models.
> >
> >That's why your model works for closed machines like a cellphones, but
> >is totally broken for notebook. Sorry.
> =

> Who talks about kernel? A policy is an userspace thing. I guess we're
> not quite understanding each other :)

You upload policies to kernel. You want 5 policies for your cellphone,
and thats fine, but I'm telling you I'd need 8388608 policies for my
notebook, because devices are independent and users want separate
control.

Because 8388608 policies is clearly not reasonable, powerop can not
help here, and something better should be developed... like power
domains someone proposed here.

(Or to say it in another words, powerop forces one big power domain,
which is bad model for notebook-style machine).
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
