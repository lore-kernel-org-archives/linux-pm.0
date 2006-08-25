From: "Vitaly Wool" <vitalywool@gmail.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Sat, 26 Aug 2006 03:26:36 +0400
Message-ID: <acd2a5930608251626t36fb1e79w27acd1eaa6fe5947@mail.gmail.com>
References: <221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060815010020.GA14251@kroah.com>
	<1155638115.6736.135.camel@localhost>
	<20060815190439.GI7612@redhat.com>
	<1155806337.30834.17.camel@localhost> <20060817214031.GE6450@ucw.cz>
	<acd2a5930608172242v7ba6e7eeq8ab90ea11175ef4c@mail.gmail.com>
	<20060823122849.GA23456@atrey.karlin.mff.cuni.cz>
	<acd2a5930608240558k4cc77dadxbd6175c05141fe23@mail.gmail.com>
	<20060825195543.GA9568@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060825195543.GA9568@elf.ucw.cz>
Content-Disposition: inline
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On 8/25/06, Pavel Machek <pavel@ucw.cz> wrote:
> > No. The reason is there's no _real_ difference in 'fileserver' and
> > 'webserver' from the PM POV, so this will never happen.
> > There's no reason to introduce different policies for different use
> > cases which however imply similar peripherals utilization.
> > Moreover, I never play MP3s on a fileserver/webserver. The example
> > you've given is pretty much artificial.
>
> My notebook has 23 different devices. Do you really want to have
> 8388608 policies for different perihepal utilizations?

Can you please elaborate on how this number corresponds to the reality?
Looks like you don't catch what I'm saying. I'm talking about use
case-driven model in which you will need to invent 8388608 use cases
basically in order to have 8388608 policies. IOW, not any combination
is valid within these 8388608.

Vitaly
