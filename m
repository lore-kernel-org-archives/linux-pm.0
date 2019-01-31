From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
Date: Thu, 31 Jan 2019 12:50:16 +0100
Message-ID: <CAJZ5v0iOkK+GQU8cnuH-T+futcvzPtLA5myEs=7u0WtazqaAew@mail.gmail.com>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <b631310f-93fa-ef4b-7014-d97fcfb2dcdf@nvidia.com> <s5ha7jicd4l.wl-tiwai@suse.de>
 <20190131110530.GA23438@ulmo> <s5htvhpax8s.wl-tiwai@suse.de> <CAJZ5v0i_G36Cw3ZvDxyU2F+pBpiw9i=3_wfQ3tDh3_JgOAb3zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0i_G36Cw3ZvDxyU2F+pBpiw9i=3_wfQ3tDh3_JgOAb3zw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jon Hunter <jonathanh@nvidia.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sameer Pujar <spujar@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, mkumard@nvidia.com, rlokhande@nvidia.com, sharadg@nvidia.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 31, 2019 at 12:46 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jan 31, 2019 at 12:21 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Thu, 31 Jan 2019 12:05:30 +0100,
> > Thierry Reding wrote:
> > >
> > > On Wed, Jan 30, 2019 at 05:40:42PM +0100, Takashi Iwai wrote:
>
> [cut]
>
> > > > If I understand correctly the code, the pm domain is already activated
> > > > at calling driver's probe callback.
> > >
> > > As far as I can tell, the domain will also be powered off again after
> > > probe finished, unless the device grabs a runtime PM reference. This is
> > > what happens via the dev->pm_domain->sync() call after successful probe
> > > of a driver.
> >
> > Ah, a good point.  This can be a problem with a probe work like this
> > case.
> >
> > > It seems to me like it's not a very well defined case what to do when a
> > > device needs to be powered up but runtime PM is not enabled.
> > >
> > > Adding Rafael and linux-pm, maybe they can provide some guidance on what
> > > to do in these situations.
> > >
> > > To summarize, what we're debating here is how to handle powering up a
> > > device if the pm_runtime infrastructure doesn't take care of it. Jon's
> > > proposal here was, and we use this elsewhere, to do something like this:
> > >
> > >       pm_runtime_enable(dev);
> > >       if (!pm_runtime_enabled(dev)) {
> > >               err = foo_runtime_resume(dev);
> > >               if (err < 0)
> > >                       goto fail;
> > >       }
> > >
> > > So basically when runtime PM is not available, we explicitly "resume"
> > > the device to power it up.
> > >
> > > It seems to me like that's a fairly common problem, so I'm wondering if
> > > there's something that the runtime PM core could do to help with this.
> > > Or perhaps there's already a way to achieve this that we're all
> > > overlooking?
> > >
> > > Rafael, any suggestions?
> >
> > If any, a common helper would be appreciated, indeed.
>
> I'm not sure that I understand the problem correctly, so let me
> restate it the way I understand it.
>
> What we're talking about is a driver ->probe() callback.  Runtime PM
> is disabled initially and the device is off.  It needs to be powered
> up, but the way to do that depends on some configuration of the board
> etc., so ideally
>
> pm_runtime_enable(dev);
> ret = pm_runtime_resume(dev);
>
> should just work, but the question is what to do if runtime PM doesn't
> work as expected.  That is, CONFIG_PM_RUNTIME is unset?

Well, we got rid of CONFIG_PM_RUNTIME, so that would be CONFIG_PM unset rather.

>  Or something else?
