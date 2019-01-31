From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during
	probe
Date: Thu, 31 Jan 2019 13:10:01 +0100
Message-ID: <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <b631310f-93fa-ef4b-7014-d97fcfb2dcdf@nvidia.com>
 <s5ha7jicd4l.wl-tiwai@suse.de>
 <20190131110530.GA23438@ulmo> <s5htvhpax8s.wl-tiwai@suse.de>
 <CAJZ5v0i_G36Cw3ZvDxyU2F+pBpiw9i=3_wfQ3tDh3_JgOAb3zw@mail.gmail.com>
 <s5hh8dpavhw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hh8dpavhw.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, sharadg@nvidia.com, rlokhande@nvidia.com, mkumard@nvidia.com
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 31, 2019 at 12:59 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 31 Jan 2019 12:46:54 +0100,
> Rafael J. Wysocki wrote:
> >
> > On Thu, Jan 31, 2019 at 12:21 PM Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > On Thu, 31 Jan 2019 12:05:30 +0100,
> > > Thierry Reding wrote:
> > > >
> > > > On Wed, Jan 30, 2019 at 05:40:42PM +0100, Takashi Iwai wrote:
> >
> > [cut]
> >
> > > > > If I understand correctly the code, the pm domain is already activated
> > > > > at calling driver's probe callback.
> > > >
> > > > As far as I can tell, the domain will also be powered off again after
> > > > probe finished, unless the device grabs a runtime PM reference. This is
> > > > what happens via the dev->pm_domain->sync() call after successful probe
> > > > of a driver.
> > >
> > > Ah, a good point.  This can be a problem with a probe work like this
> > > case.
> > >
> > > > It seems to me like it's not a very well defined case what to do when a
> > > > device needs to be powered up but runtime PM is not enabled.
> > > >
> > > > Adding Rafael and linux-pm, maybe they can provide some guidance on what
> > > > to do in these situations.
> > > >
> > > > To summarize, what we're debating here is how to handle powering up a
> > > > device if the pm_runtime infrastructure doesn't take care of it. Jon's
> > > > proposal here was, and we use this elsewhere, to do something like this:
> > > >
> > > >       pm_runtime_enable(dev);
> > > >       if (!pm_runtime_enabled(dev)) {
> > > >               err = foo_runtime_resume(dev);
> > > >               if (err < 0)
> > > >                       goto fail;
> > > >       }
> > > >
> > > > So basically when runtime PM is not available, we explicitly "resume"
> > > > the device to power it up.
> > > >
> > > > It seems to me like that's a fairly common problem, so I'm wondering if
> > > > there's something that the runtime PM core could do to help with this.
> > > > Or perhaps there's already a way to achieve this that we're all
> > > > overlooking?
> > > >
> > > > Rafael, any suggestions?
> > >
> > > If any, a common helper would be appreciated, indeed.
> >
> > I'm not sure that I understand the problem correctly, so let me
> > restate it the way I understand it.
> >
> > What we're talking about is a driver ->probe() callback.  Runtime PM
> > is disabled initially and the device is off.  It needs to be powered
> > up, but the way to do that depends on some configuration of the board
> > etc., so ideally
> >
> > pm_runtime_enable(dev);
> > ret = pm_runtime_resume(dev);
> >
> > should just work, but the question is what to do if runtime PM doesn't
> > work as expected.  That is, CONFIG_PM_RUNTIME is unset?  Or something
> > else?
>
> Yes, the question is how to write the code for both with and without
> CONFIG_PM (or CONFIG_PM_RUNTIME).

This basically is about setup, because after that point all should
just work in both cases.

Personally, I would do

if (IS_ENABLED(CONFIG_PM)) {
  do setup based on pm-runtime
} else {
  do manual setup
}

> Right now, we have a code like below, pushing the initialization in an
> async work and let the probe returning quickly.
>
>         hda_tegra_probe() {
>                 ....

So why don't you do

if (!IS_ENABLED(CONFIG_PM)) {
  do manual clock setup
}

here?

>                 pm_runtime_enable();
>                 schedule_work();
>                 return;
>         }
>
>         hda_tegra_probe_work() {
>                 pm_runtime_get_sync();
>                 ....
>                 pm_runtime_put_sync();
>         }
>
> Then it truned outhis code lacks of the clock initialization when
> runtime PM isn't enabled.  Normally it's done via runtime resume
>
>         hda_tegra_runtime_resume() {
>                 hda_tegra_enable_clocks();
>                 ....
>         }
>
> And now the question is what is the standard idiom in such a case.
>
> IMO, calling pm_runtime_resume() inside the probe function looks
> weird, and my preference was to initialize the clocks explicitly, then
> enable runtime PM.  But if using pm_runtime_resume() in the proc
> should be seen as a standard procedure, I'm fine with that.

Well, people do pm_runtime_resume() in ->probe() too, but
pm_runtime_resume() returns 1 for CONFIG_PM unset, so that won't give
you what you want anyway. :-)

Cheers,
Rafael
