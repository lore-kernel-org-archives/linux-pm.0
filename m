From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: Null suspend/resume functions
Date: Tue, 17 Nov 2009 21:46:35 +0900
Message-ID: <aec7e5c30911170446n71031671i48aca11f5276405d__19317.8424299278$1258462322$gmane$org@mail.gmail.com>
References: <ud43sjtaf.wl%morimoto.kuninori@renesas.com>
	<20091109105858.GB1245@sirena.org.uk>
	<20091109133136.GC1245@sirena.org.uk>
	<20091116153000.GB29479@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091116153000.GB29479@sirena.org.uk>
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

Hi Mark,

On Tue, Nov 17, 2009 at 12:30 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Nov 09, 2009 at 01:31:36PM +0000, Mark Brown wrote:
>> On Mon, Nov 09, 2009 at 10:58:58AM +0000, Mark Brown wrote:
>> > On Mon, Nov 09, 2009 at 11:54:47AM +0900, Kuninori Morimoto wrote:
>
> Any chance someone from the PM side could comment on the issue below?
>
>> > > +static int fsi_runtime_nop(struct device *dev)
>> > > +{
>> > > + /* Runtime PM callback shared between ->runtime_suspend()
>> > > + =A0* and ->runtime_resume(). Simply returns success.
>> > > + =A0*
>> > > + =A0* This driver re-initializes all registers after
>> > > + =A0* pm_runtime_get_sync() anyway so there is no need
>> > > + =A0* to save and restore registers here.
>> > > + =A0*/
>> > > + return 0;
>> > > +}
>> >
>> > This sets off alarm bells but it's perfectly reasonable, especially wi=
th
>> > platforms able to put things into a low power state with no explicit
>> > driver code now they can do power domain style things like SH. =A0I've
>> > CCed in the PM folks since this seems like a perfectly reasonable use
>> > case which ought to be handled more nicely.

On SuperH we have Runtime PM enabled on a few platforms together with
a few updated drivers. The latest driver to become more power aware is
this FSI driver.

It's all quite simple, in the FSI driver we enable the clock to the
FSI hardware using Runtime PM functions, and whenever the clock is
turned off the SuperH specific bus code _may_ decide to call
->runtime_suspend() and turn off the power domain. The "_may_" comes
from the fact that multiple hardware blocks may be grouped together
into a single power domain, and all devices in the power domain must
support Runtime PM and have their clocks disabled before we can turn
off the power.

At this point the SuperH specific platform bus code requires the
callbacks ->runtime_suspend() and ->runtime_resume() to be present. It
may be a good idea to allow them to be NULL in the future or maybe
having some shared functions, but before starting to break out stuff
I'd like to see how other Runtime PM implementations deal with this.
So unless people object I prefer to keep it as-is for now.

/ magnus
