From: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
Date: Mon, 4 Feb 2019 13:46:20 +0530
Message-ID: <e7597220-2be7-ca29-50b7-c515c06cbed7@nvidia.com>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
 <20190131143024.GO23438@ulmo> <2034694.JE9CgBysmF@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2034694.JE9CgBysmF@aspire.rjw.lan>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <thierry.reding@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, Jon Hunter <jonathanh@nvidia.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, mkumard@nvidia.com, rlokhande@nvidia.com, sharadg@nvidia.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


On 2/1/2019 4:54 AM, Rafael J. Wysocki wrote:
> On Thursday, January 31, 2019 3:30:24 PM CET Thierry Reding wrote:
>> --Pk/CTwBz1VvfPIDp
>> Content-Type: text/plain; charset=3Dus-ascii
>> Content-Disposition: inline
>> Content-Transfer-Encoding: quoted-printable
>>
>> On Thu, Jan 31, 2019 at 01:10:01PM +0100, Rafael J. Wysocki wrote:
>>> On Thu, Jan 31, 2019 at 12:59 PM Takashi Iwai <tiwai@suse.de> wrote:
>>>> On Thu, 31 Jan 2019 12:46:54 +0100,
>>>> Rafael J. Wysocki wrote:
>>>>> On Thu, Jan 31, 2019 at 12:21 PM Takashi Iwai <tiwai@suse.de> wrote:
>>>>>> On Thu, 31 Jan 2019 12:05:30 +0100,
>>>>>> Thierry Reding wrote:
>>>>>>> On Wed, Jan 30, 2019 at 05:40:42PM +0100, Takashi Iwai wrote:
>>>>> [cut]
>>>>>
>>>>>>>> If I understand correctly the code, the pm domain is already ac=3D
>> tivated
>>>>>>>> at calling driver's probe callback.
>>>>>>> As far as I can tell, the domain will also be powered off again a=
=3D
>> fter
>>>>>>> probe finished, unless the device grabs a runtime PM reference. T=
=3D
>> his is
>>>>>>> what happens via the dev->pm_domain->sync() call after successful=
=3D
>>   probe
>>>>>>> of a driver.
>>>>>> Ah, a good point.  This can be a problem with a probe work like this
>>>>>> case.
>>>>>>
>>>>>>> It seems to me like it's not a very well defined case what to do =
=3D
>> when a
>>>>>>> device needs to be powered up but runtime PM is not enabled.
>>>>>>>
>>>>>>> Adding Rafael and linux-pm, maybe they can provide some guidance =
=3D
>> on what
>>>>>>> to do in these situations.
>>>>>>>
>>>>>>> To summarize, what we're debating here is how to handle powering =
=3D
>> up a
>>>>>>> device if the pm_runtime infrastructure doesn't take care of it. =
=3D
>> Jon's
>>>>>>> proposal here was, and we use this elsewhere, to do something lik=
=3D
>> e this:
>>>>>>>        pm_runtime_enable(dev);
>>>>>>>        if (!pm_runtime_enabled(dev)) {
>>>>>>>                err =3D3D foo_runtime_resume(dev);
>>>>>>>                if (err < 0)
>>>>>>>                        goto fail;
>>>>>>>        }
>>>>>>>
>>>>>>> So basically when runtime PM is not available, we explicitly "res=
=3D
>> ume"
>>>>>>> the device to power it up.
>>>>>>>
>>>>>>> It seems to me like that's a fairly common problem, so I'm wonder=
=3D
>> ing if
>>>>>>> there's something that the runtime PM core could do to help with =
=3D
>> this.
>>>>>>> Or perhaps there's already a way to achieve this that we're all
>>>>>>> overlooking?
>>>>>>>
>>>>>>> Rafael, any suggestions?
>>>>>> If any, a common helper would be appreciated, indeed.
>>>>> I'm not sure that I understand the problem correctly, so let me
>>>>> restate it the way I understand it.
>>>>>
>>>>> What we're talking about is a driver ->probe() callback.  Runtime PM
>>>>> is disabled initially and the device is off.  It needs to be powered
>>>>> up, but the way to do that depends on some configuration of the board
>>>>> etc., so ideally
>>>>>
>>>>> pm_runtime_enable(dev);
>>>>> ret =3D3D pm_runtime_resume(dev);
>>>>>
>>>>> should just work, but the question is what to do if runtime PM doesn'=
t
>>>>> work as expected.  That is, CONFIG_PM_RUNTIME is unset?  Or something
>>>>> else?
>>>> Yes, the question is how to write the code for both with and without
>>>> CONFIG_PM (or CONFIG_PM_RUNTIME).
>>> =3D20
>>> This basically is about setup, because after that point all should
>>> just work in both cases.
>>> =3D20
>>> Personally, I would do
>>> =3D20
>>> if (IS_ENABLED(CONFIG_PM)) {
>>>    do setup based on pm-runtime
>>> } else {
>>>    do manual setup
>>> }
>>> =3D20
>>>> Right now, we have a code like below, pushing the initialization in an
>>>> async work and let the probe returning quickly.
>>>>
>>>>          hda_tegra_probe() {
>>>>                  ....
>>> =3D20
>>> So why don't you do
>>> =3D20
>>> if (!IS_ENABLED(CONFIG_PM)) {
>>>    do manual clock setup
>>> }
>>> =3D20
>>> here?
>> I think that's exactly what Jon and Sameer were proposing, although the
>> discussion started primarily because of the way it was done.
>>
>> So basically the idea was to do:
>>
>> 	pm_runtime_enable()
>> 	if (!pm_runtime_enabled())  /* basically !IS_ENABLED(CONFIG_PM) */
> But why is it any better than checking !IS_ENABLED(CONFIG_PM) directly?
>
>> 		hda_runtime_resume()
>>
>> So we're not calling pm_runtime_resume() but rather the driver's
>> implementation of it. This is to avoid duplicating the code, which under
>> some circumstances can be fairly long. Duplicating is also error prone
>> because both instances may not always be in sync.
>>
>> My understanding is that Takashi had reservations about using this kind
>> of construct because, well, frankly, it looks a little weird.
> Yes, the way it was originally written above was weird, but is checking
> IS_ENABLED(CONFIG_PM) directly really so weird?
>
>> We'd also likely want to have a similar construct again in the ->remove(=
)
>> callback to make sure we properly power off the device when it is no lon=
ger
>> needed.
> Sure.  Again, why don't you make it conditional on IS_ENABLED(CONFIG_PM)?
>
>> I'm just wondering if perhaps there should be a mechanism in the
>> core to take care of this,
> How exactly?  How's the core going to know what to do when CONFIG_PM is
> disabled?
>
>> because this is basically something that we'd need to do for every singl=
e
>> driver.
> That is not true.  If the device is alwyas "on" to start with, you don't
> need to do anything.  That's the case on many systems.
>
>> For example, if !CONFIG_PM couldn't the pm_runtime_enable() function be
>> modified to do the above?
> But you'd need to pass a pointer to your hda_runtime_resume() to it at le=
ast
> and how's that simpler than using a simple conditional directly?
>
>> This would be somewhat tricky because drivers
>> usually use SET_RUNTIME_PM_OPS to populate the struct dev_pm_ops and
>> that would result in an empty structure if !CONFIG_PM, but we could
>> probably work around that by adding a __SET_RUNTIME_PM_OPS that would
>> never be compiled out for this kind of case. Or such drivers could even
>> manually set .runtime_suspend and .runtime_resume to make sure they're
>> always populated.
>>
>> Another way out of this would be to make sure we never run into the case
>> where runtime PM is disabled. If we always "select PM" on Tegra, then PM
>> should always be available. But is it guaranteed that runtime PM for the
>> devices is functional in that case? From a cursory look at the code it
>> would seem that way.
> If you select PM, then all of the requisite code should be there.
>
> Alternatively, you can make the driver depend on PM.
Objective is to have things working with or without CONFIG_PM enabled.
 From previous comments and discussions it appears that there is mixed=20
response
for calling hda_tegra_runtime_resume() or runtime PM APIs in probe()=20
call. Need
to have consensus regarding the best practice to be followed, which=20
would eventually
can be used in other drivers too.

Rafael is suggesting to use CONFIG_PM check to do manual setup or=20
runtime PM setup in probe,
which would bring back the earlier above mentioned concern.

if (IS_ENABLED(CONFIG_PM)) {
do setup based on pm-runtime
} else {
 =C2=A0=C2=A0=C2=A0 do manual setup
}
Both if/else might end up doing the same here.
Do we really need CONFIG_PM check here?

Instead does below proposal appear fine?

probe() {
 =C2=A0=C2=A0=C2=A0 hda_tegra_enable_clock();
}

probe_work() {
 =C2=A0=C2=A0=C2=A0 /* hda setup */
 =C2=A0=C2=A0=C2=A0 . . .
 =C2=A0=C2=A0=C2=A0 pm_runtime_set_active(); /* initial state as active */
 =C2=A0=C2=A0=C2=A0 pm_runtime_enable();
 =C2=A0=C2=A0=C2=A0 return;
}

remove() {
 =C2=A0=C2=A0=C2=A0 pm_runtime_disable();
 =C2=A0=C2=A0=C2=A0 if (!pm_runtime_status_suspended())
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 hda_tegra_runtime_suspend(); /* take=
s care of both CONFIG_PM=20
enable/disable case */
}

One of the other concern was, remove() and probe() do not appear to be=20
in sync, because in probe() hda_tegra_enable_clock()
is called and in remove() there is hda_tegra_runtime_suspend() to=20
effectively disable clock.
IMO, this should be ok since it can avoid duplication and proper comment=20
can be added here for clarity.
Alternatively we can call hda_tegra_runtime_resume() in probe()=20
unconditionally to avoid confusion.

Another point Thierry mentioned was, after successful probe()=20
power-domain would be turned OFF. It seems Rafael had a different
view. I am little confused here. Kindly clarify if above proposal seems=20
fine.

Thanks,
Sameer.

> Cheers,
> Rafael
>
