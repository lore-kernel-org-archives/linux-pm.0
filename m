From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH/RFC] Runtime PM: ARM: subarch-specific
	extensions of pdev_archdata
Date: Wed, 4 Aug 2010 16:41:30 -0600
Message-ID: <AANLkTinWqKz977p+-d7pxjqCUn82JLeAk_EQ0TjOGNWr__34019.887893419$1280961886$gmane$org@mail.gmail.com>
References: <1253670648-28610-1-git-send-email-khilman@deeprootsystems.com>
	<f17812d70909222153y4a0e4fc2n496ea2e6caaac847@mail.gmail.com>
	<19129.63264.653666.70492@pilspetsen.it.uu.se>
	<4ABAAF1D.6090907@deeprootsystems.com>
	<f17812d70909231630i20f64328k8d604c3436094b85@mail.gmail.com>
	<87k4yhagv4.fsf@deeprootsystems.com>
	<AANLkTinBqc11oE2SOmvXbFHmlgvZ21LngXNWkSHiJmRK@mail.gmail.com>
	<34dc79dc-0868-4401-9fa5-c7134f6d4485@email.android.com>
	<AANLkTikHUcgBcTmv+=NrYMwgn-UC_Q0Vv3ytfuJbkyRB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikHUcgBcTmv+=NrYMwgn-UC_Q0Vv3ytfuJbkyRB@mail.gmail.com>
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
Cc: Mikael Pettersson <mikpe@it.uu.se>, Eric Miao <eric.y.miao@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

[cc'ing gregkh w.r.t. the bus notifiers in modules bit at the bottom]

On Sun, Jul 25, 2010 at 7:51 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Sun, Jul 25, 2010 at 5:24 AM, Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>> "Magnus Damm" <magnus.damm@gmail.com> wrote:
>>>On Tue, Oct 27, 2009 at 8:13 AM, Kevin Hilman
>>><khilman@deeprootsystems.com> wrote:
>>>> Eric Miao <eric.y.miao@gmail.com> writes:
>>>>> On Thu, Sep 24, 2009 at 7:28 AM, Kevin Hilman
>>>>> <khilman@deeprootsystems.com> wrote:
>>>>>> Mikael Pettersson wrote:
>>>>>>> Eric Miao writes:
>>>>>>> =A0> On Wed, Sep 23, 2009 at 9:50 AM, Kevin Hilman
>>>>>>> =A0> <khilman@deeprootsystems.com> wrote:
>>>>>>> =A0> > On ARM platforms, power management can be very platform spec=
ific.
>>>>>>> =A0> > This patch allows ARM subarches to extend the platform_device
>>>>>>> =A0> > pdev_archdata for each subarch by creating a new struct pdev=
_machdata
>>>>>>> =A0> > and allowing each subarch to customize it as needed.
>
>>>Do you remember what happened with this patch?
>>
>> I don't have all the details in front of me because I'm on my phone, but=
 I advised against pdev_archdata because it is multiplatform-unfriendly.
>
> Ok, I did not expect that. =3D) But after thinking a bit it does make
> sense. I wonder what my options are. I'm not so fond of the idea to
> wrap the platform devices - that's not more multi-platform friendly,
> is it?
>
> How about using devres and platform bus notifiers?

I think bus notifiers are appropriate.  I hadn't thought of using
devres to attach additional behaviour, but looking at your prototype
it seems to be sane.

> For a Runtime PM prototype using devres (instead of pdev_archdata or
> wrapping) look here:
> https://patchwork.kernel.org/patch/113605/

While I'm looking at this patch; some thoughts off the top of my head:

The static symbols should still be prefixed with 'sh_pm_runtime_' or
something similar.  There is a risk of things like
"platform_bus_notify" colliding with things defined in the global
namespace.

Looking at he '#else' clause of CONFIG_PM_RUNTIME triggered a warning
flag.  If the runtime PM stuff was as a module as suggested below,
then the drivers would get probed before the clock is enabled... Maybe
I'm misunderstanding it though because I see that the .c file is not
set up to be a module.

Also, that particular implementation is rather non-discriminant; and
every platform_device would get this binding regardless of what the
actual attachment to the system is.  For example, ASoC makes use of
platform devices to bind together an audio complex, but those devices
represent a set of connections, not an actual devices.  It probably
wouldn't be appropriate to have bus-specific runtime pm hooks on ASoC
devices.  But I understand that this is an early prototype and I
understand the intent.

> To make it work with modules I propose adding a driver bind event:
> https://patchwork.kernel.org/patch/113865/
>
> Looks pretty multi-platform friendly to me. Any suggestions?

The idea sane to me (haven't dug deeply enough to comment on the
implementation, but I suspect that there is a race condition in the
implementation which could cause drivers getting both BIND and BOUND
notifications).  I think it is entirely desirable for notifiers to be
informed of already existing drivers.

I had posted a somewhat related patch earlier, but never pursued it
because I found a different way around (and I was a little worried
about the race condition).  My patch to the approach of sending add
and bind events for each driver that is already registered/bound when
a new notifier is registered.  Here's the patch and the comments:

http://patchwork.ozlabs.org/patch/24152/

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
