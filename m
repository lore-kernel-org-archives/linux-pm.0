From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Null suspend/resume functions
Date: Wed, 18 Nov 2009 12:05:47 +0000
Message-ID: <20091118120547.GB6592__4181.99139317057$1258743821$gmane$org@rakim.wolfsonmicro.main>
References: <ud43sjtaf.wl%morimoto.kuninori@renesas.com>
	<20091109105858.GB1245@sirena.org.uk>
	<20091109133136.GC1245@sirena.org.uk>
	<20091116153000.GB29479@sirena.org.uk>
	<aec7e5c30911170446n71031671i48aca11f5276405d@mail.gmail.com>
	<20091117125901.GF823@rakim.wolfsonmicro.main>
	<aec7e5c30911180209x1981978es80db2dadf7dd8ef4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <aec7e5c30911180209x1981978es80db2dadf7dd8ef4@mail.gmail.com>
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
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, Magnus Damm <damm@opensource.se>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 18, 2009 at 07:09:14PM +0900, Magnus Damm wrote:
> On Tue, Nov 17, 2009 at 9:59 PM, Mark Brown

> > I understand exactly what the runtime PM stuff and the driver are doing
> > here, the issue is the mandatory suspend and resume functions.

> Cool, but don't you think it makes sense to see how other
> architectures will deal with this first?

Of course, the other way of looking at it would be that it'd be good to
provide the best possible implementation in the first architecture so
that others can draw inspiration from it.

Looking at what you've got it seems clearly sane as-is modulo this issue
and I can see how it maps onto the Samsung/OMAP style hardware so it
doesn't set off any alarm bells for me on that front.  The only thing
I'm a bit unsure about with your implementation is mixing in the clock
gating but to be honest that's something that could be changed on a per
device basis anyway.

> > What is the reason for requiring that the driver provide stub functions?
> > For me the issue is that if it's mandatory for the driver to provide the
> > functions then having stub functions in there makes the driver look like
> > it is abusing the API by not implementing mandatory functionality.

> I see your point, but there is another side to it as well. Having the
> stubs there is a way of showing that these functions may be called as
> part of the Runtime PM management. Not having them would confuse
> people even more IMO.

Given that they're part of dev_pm_ops which already does such things as
routine I'm not sure that it's particularly confusing.  To me it's
confusing that one might be required to do something at runtime suspend
time - since the driver has to explicitly tell the PM core that the
device is idle so it seems reasonable to expect that the hardware would
already be quiesced and all that'd be needed would be to power down the
block.

> I can spend some time on updating the drivers and removing the
> nop-stubs if you'd like, but I'd rather not since I suspect that I'll
> have to update things again when we get Runtime PM for ARM or other
> non-sh architectures.

Like I say, the SH doesn't sound fundamentally different to the ARMs
here.
