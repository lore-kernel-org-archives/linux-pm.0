From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
Date: Mon, 4 Feb 2019 10:04:50 +0000
Message-ID: <80a45aa3-8a22-959c-0c73-03ad2d6b1f8c@nvidia.com>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
 <20190131143024.GO23438@ulmo> <2034694.JE9CgBysmF@aspire.rjw.lan>
 <e7597220-2be7-ca29-50b7-c515c06cbed7@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e7597220-2be7-ca29-50b7-c515c06cbed7@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sameer Pujar <spujar@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <thierry.reding@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, mkumard@nvidia.com, rlokhande@nvidia.com, sharadg@nvidia.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


On 04/02/2019 08:16, Sameer Pujar wrote:

...

> Objective is to have things working with or without CONFIG_PM enabled.
> From previous comments and discussions it appears that there is mixed
> response
> for calling hda_tegra_runtime_resume() or runtime PM APIs in probe()
> call. Need
> to have consensus regarding the best practice to be followed, which
> would eventually
> can be used in other drivers too.
>=20
> Rafael is suggesting to use CONFIG_PM check to do manual setup or
> runtime PM setup in probe,
> which would bring back the earlier above mentioned concern.
>=20
> if (IS_ENABLED(CONFIG_PM)) {
> do setup based on pm-runtime
> } else {
> =C2=A0=C2=A0=C2=A0 do manual setup
> }
> Both if/else might end up doing the same here.
> Do we really need CONFIG_PM check here?
>=20
> Instead does below proposal appear fine?
>=20
> probe() {
> =C2=A0=C2=A0=C2=A0 hda_tegra_enable_clock();
> }
>=20
> probe_work() {
> =C2=A0=C2=A0=C2=A0 /* hda setup */
> =C2=A0=C2=A0=C2=A0 . . .
> =C2=A0=C2=A0=C2=A0 pm_runtime_set_active(); /* initial state as active */
> =C2=A0=C2=A0=C2=A0 pm_runtime_enable();
> =C2=A0=C2=A0=C2=A0 return;
> }

I believe that this still does not work, because if there is a
power-domain that needs to be turned on, this does not guarantee this.
So I think that you need to call pm_runtime_get ...

 probe() {
 	if (!IS_ENABLED(CONFIG_PM))
 		hda_tegra_enable_clock();
 }


 probe_work() {
    	/* hda setup */
    	. . .
	pm_runtime_enable();
	pm_runtime_get_sync();
	return;
 }

The alternative here could just be ...

 probe() {
	pm_runtime_enable();
 	if (!pm_runtime_enabled())
 		ret =3D hda_tegra_enable_clock();
	else
		ret =3D pm_runtime_get_sync();

	if (ret < 0) {
		...
	}
 }

Very similar to what I was saying to begin with but not call the
pm_runtime_resume handler directly. Which I believe was Iwai-san's dislike.

Cheers
Jon

--=20
nvpublic
