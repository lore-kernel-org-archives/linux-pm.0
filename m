From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: Null suspend/resume functions
Date: Wed, 18 Nov 2009 19:09:14 +0900
Message-ID: <aec7e5c30911180209x1981978es80db2dadf7dd8ef4__36282.2868781679$1258539145$gmane$org@mail.gmail.com>
References: <ud43sjtaf.wl%morimoto.kuninori@renesas.com>
	<20091109105858.GB1245@sirena.org.uk>
	<20091109133136.GC1245@sirena.org.uk>
	<20091116153000.GB29479@sirena.org.uk>
	<aec7e5c30911170446n71031671i48aca11f5276405d@mail.gmail.com>
	<20091117125901.GF823@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091117125901.GF823@rakim.wolfsonmicro.main>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, Magnus Damm <damm@opensource.se>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 17, 2009 at 9:59 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Nov 17, 2009 at 09:46:35PM +0900, Magnus Damm wrote:
>
>> On SuperH we have Runtime PM enabled on a few platforms together with
>> a few updated drivers. The latest driver to become more power aware is
>> this FSI driver.
>
> I understand exactly what the runtime PM stuff and the driver are doing
> here, the issue is the mandatory suspend and resume functions.

Cool, but don't you think it makes sense to see how other
architectures will deal with this first?

>> At this point the SuperH specific platform bus code requires the
>> callbacks ->runtime_suspend() and ->runtime_resume() to be present. It
>> may be a good idea to allow them to be NULL in the future or maybe
>> having some shared functions, but before starting to break out stuff
>> I'd like to see how other Runtime PM implementations deal with this.
>> So unless people object I prefer to keep it as-is for now.
>
> What is the reason for requiring that the driver provide stub functions?
> For me the issue is that if it's mandatory for the driver to provide the
> functions then having stub functions in there makes the driver look like
> it is abusing the API by not implementing mandatory functionality.

I see your point, but there is another side to it as well. Having the
stubs there is a way of showing that these functions may be called as
part of the Runtime PM management. Not having them would confuse
people even more IMO.

> Given that the arch is now dealing with clocking and power for the
> device using the runtime PM system it seems fairly clear that there are
> going to be drivers like this one that can at least skip the suspend
> part and may not need to do anything at resume time either.

Right. We just need to figure out what the arch-independent solution
would be, and we're unfortunately not there yet.

I can spend some time on updating the drivers and removing the
nop-stubs if you'd like, but I'd rather not since I suspect that I'll
have to update things again when we get Runtime PM for ARM or other
non-sh architectures.

Let me know what you think!

/ magnus
