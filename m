From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH/RFC] Runtime PM: ARM: subarch-specific
	extensions of pdev_archdata
Date: Thu, 5 Aug 2010 11:53:18 +0900
Message-ID: <AANLkTi=hZDgg5CNPG2jq5JQSO=JDHFBDP3uV5E7=q45O__13814.2874501229$1280976848$gmane$org@mail.gmail.com>
References: <1253670648-28610-1-git-send-email-khilman@deeprootsystems.com>
	<f17812d70909222153y4a0e4fc2n496ea2e6caaac847@mail.gmail.com>
	<19129.63264.653666.70492@pilspetsen.it.uu.se>
	<4ABAAF1D.6090907@deeprootsystems.com>
	<f17812d70909231630i20f64328k8d604c3436094b85@mail.gmail.com>
	<87k4yhagv4.fsf@deeprootsystems.com>
	<AANLkTinBqc11oE2SOmvXbFHmlgvZ21LngXNWkSHiJmRK@mail.gmail.com>
	<34dc79dc-0868-4401-9fa5-c7134f6d4485@email.android.com>
	<AANLkTikHUcgBcTmv+=NrYMwgn-UC_Q0Vv3ytfuJbkyRB@mail.gmail.com>
	<AANLkTinWqKz977p+-d7pxjqCUn82JLeAk_EQ0TjOGNWr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinWqKz977p+-d7pxjqCUn82JLeAk_EQ0TjOGNWr@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Eric Miao <eric.y.miao@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 5, 2010 at 7:41 AM, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> [cc'ing gregkh w.r.t. the bus notifiers in modules bit at the bottom]
>
> On Sun, Jul 25, 2010 at 7:51 PM, Magnus Damm <magnus.damm@gmail.com> wrot=
e:
>> How about using devres and platform bus notifiers?
>
> I think bus notifiers are appropriate. =A0I hadn't thought of using
> devres to attach additional behaviour, but looking at your prototype
> it seems to be sane.
>
>> For a Runtime PM prototype using devres (instead of pdev_archdata or
>> wrapping) look here:
>> https://patchwork.kernel.org/patch/113605/
>
> While I'm looking at this patch; some thoughts off the top of my head:
>
> The static symbols should still be prefixed with 'sh_pm_runtime_' or
> something similar. =A0There is a risk of things like
> "platform_bus_notify" colliding with things defined in the global
> namespace.

Sure, avoiding colliding with the global name space makes sense!

> Looking at he '#else' clause of CONFIG_PM_RUNTIME triggered a warning
> flag. =A0If the runtime PM stuff was as a module as suggested below,
> then the drivers would get probed before the clock is enabled... Maybe
> I'm misunderstanding it though because I see that the .c file is not
> set up to be a module.

Oh, I didn't intend to allow the Runtime PM code to be a module. Sorry
for the unclear wording, I meant to support being notified before the
probe() at insmod time for platform drivers built as modules.

> Also, that particular implementation is rather non-discriminant; and
> every platform_device would get this binding regardless of what the
> actual attachment to the system is. =A0For example, ASoC makes use of
> platform devices to bind together an audio complex, but those devices
> represent a set of connections, not an actual devices. =A0It probably
> wouldn't be appropriate to have bus-specific runtime pm hooks on ASoC
> devices. =A0But I understand that this is an early prototype and I
> understand the intent.

The Runtime PM code for SH-Mobile ARM does not differentiate between
various types of platform devices. The code relies on clkdev doing the
matching. So if there is no clkdev mapping for the platform device
then nothing is done. Perhaps the generic runtime pm hooks should be
called for that case instead.

>> To make it work with modules I propose adding a driver bind event:
>> https://patchwork.kernel.org/patch/113865/
>>
>> Looks pretty multi-platform friendly to me. Any suggestions?
>
> The idea sane to me (haven't dug deeply enough to comment on the
> implementation, but I suspect that there is a race condition in the
> implementation which could cause drivers getting both BIND and BOUND
> notifications). =A0I think it is entirely desirable for notifiers to be
> informed of already existing drivers.

Hm, I have not seen any race myself, but the registered bus notifiers
will receive all kinds of events - ie both BIND and BOUND.

> I had posted a somewhat related patch earlier, but never pursued it
> because I found a different way around (and I was a little worried
> about the race condition). =A0My patch to the approach of sending add
> and bind events for each driver that is already registered/bound when
> a new notifier is registered. =A0Here's the patch and the comments:
>
> http://patchwork.ozlabs.org/patch/24152/

That patch makes sense for code built as modules. I do my best to
avoid that situation by just allowing the code to be built-in. =3D)

Thanks for your comments!

/ magnus
