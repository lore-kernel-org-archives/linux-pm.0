From: "=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@bitplanet.net>
Subject: Re: fw-ohci breaks suspend-to-RAM
Date: Wed, 6 Jun 2007 18:58:22 -0400
Message-ID: <59ad55d30706061558w2787e9fby47426670374ce73d@mail.gmail.com>
References: <200705181207.45868.marcus@better.se>
	<tkrat.5b4ba1068f8b64ee@s5r6.in-berlin.de>
	<tkrat.07833adfb2306655@s5r6.in-berlin.de>
	<200705311441.14021.marcus@better.se>
	<465EDA0E.8060400@s5r6.in-berlin.de>
	<59ad55d30706061314s45c86e7eja587244a6ed37812@mail.gmail.com>
	<466723C7.3090305@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <466723C7.3090305@s5r6.in-berlin.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-pm@lists.linux-foundation.org, linux1394-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Marcus Better <marcus@better.se>
List-Id: linux-pm@vger.kernel.org

On 6/6/07, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> Kristian H=C3=B8gsberg wrote:
> > I've posted an updated version of the patch here
>                  ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^
> You mean "addition to the previous" patch. :-)

Yes, sorry about that.

> > that fixes a byteswapping problem, and should make the stack
> > actually work after resuming:
> >
> > http://marc.info/?l=3Dlinux1394-devel&m=3D118108604226326&w=3D2
>
> That is, protocols which do not involve showing the local ROM to remote
> nodes are unaffected?  In that case I would prefer to defer this new
> patch until the next merge window if you don't mind.  Nevertheless, if
> Marcus could take the time to check whether his machine keeps happily
> resuming with the new patch applied, that would be good.  I will test i=
t
> with APM suspend and SBP-2 circa tomorrow.

No there's more to it than that.  When the ohci controller processes
the bus reset, it loads back values from the config rom into a couple
of ohci registers, specifically BusOptions[1].  If we provide the
wrong value in config_rom[2], the controller will load that value
after reset and we'll typically end up with a 0 in the max_rec field,
which will prevent async receive from working.  So byteswapping this
correctly will very likely fix the problem you saw, where your box
came back from suspend, but the firewire stack was busted.

cheers,
Kristian

[1] If you look at the bus reset tasklet, you'll see that there's more
to it.  I turns out that not all controllers agree on whether or not
to byteswap the be32 value read from the config_rom map.
Specifically, the ricoh chipset in my laptop gets it right and swaps
it from be32 to le32 before writing to the ohci register, but all TI
chipsets just writes the value as is, effectively making the otherwise
well designed atomic config rom update mechanism useless.  So in the
end I manually write the BusOptions register in the bus reset tasklet,
but I also load it from the ohci->config_rom map, so this has to be
the right byte order.
