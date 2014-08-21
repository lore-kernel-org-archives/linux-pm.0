From: =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Handling commit change logs
Date: Thu, 21 Aug 2014 12:43:31 +0200
Message-ID: <53F5CD53.8060209@suse.de>
References: <1408419205-10048-1-git-send-email-tuomas.tynkkynen@iki.fi>	<1408419205-10048-14-git-send-email-tuomas.tynkkynen@iki.fi>	<CAKohpokQOALPH13Ykz4nTBOby8J1X6_F30LNKz=gsC4wN3=3vg@mail.gmail.com>	<53F3A900.8010805@nvidia.com>	<CAKohponcZv9-MFNUQFxC_49-+P6QOhdjxsnYAyL3i4sXdCBYrw@mail.gmail.com> <CABxcv=ncm3Y7Ecfymro6TOuP=d10OV5--8n=dYmHyj6zi8hwEw@mail.gmail.com> <53F4FED4.7060408@suse.de> <53F50554.3050505@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53F50554.3050505-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tuomas Tynkkynen <tuomas.tynkkynen-X3B1VOXEql0@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Am 20.08.2014 22:30, schrieb Stephen Warren:
> On 08/20/2014 02:02 PM, Andreas F=C3=A4rber wrote:
>> Am 20.08.2014 17:39, schrieb Javier Martinez Canillas:
>>> As you already know when you apply a patch with git am, everything
>>> that is between a line with 3 dashes line (---) and the actual diff=
 is
>>> omitted since that is where the generated diffstat is placed by git
>>> format-patch.
>>>
>>> We usually rely on that behavior to put there the history of a patc=
h
>>> or any information that we think that is useful for reviewers but i=
s
>>> not suitable to end in the commit message. Now that means that you
>>> have to generate the patch and then manually edit it to add the
>>> history there.
>>>
>>> But since git am omits any text between the first "---" and the dif=
f,
>>> it means that you can add a "---" on your actual commit message and
>>> anything that follows will be discarded by git am, that way you can
>>> maintain your history on your commit message which is way less tedi=
ous
>>> than manually editing patches.
>>>
>>> So the second "---" from Tuomas patch is actually the one generated=
 by
>>> git format-patch but that gets discarded by git am just like any ot=
her
>>> text so it causes no harm when other apply the patches.
>>>
>>> If this not the correct workflow and you have a better way to manag=
e
>>> this, I would love to know about it.
>>
>> One drawback of having --- in the commit message is that you can't
>> cherry-pick but really need to use git-am for it to be stripped.
>=20
> You can, you just have to either:
>=20
> * Pass -e to git cherry-pick so you get to edit the patch description=
,
>=20
> * Run "git commit --amend" right afterwards,
>=20
> ... and then delete everything starting at ---.
>=20
> I do this reasonably often on my own patches; I send them to the list=
,
> get them reviewed, and then cherry-pick them into the Tegra maintaine=
r
> tree rather than saving them from the email client and running git am=
=2E

Sure. My point was more that the person doing the cherry-pick needs to
be aware of and correct such misuse, and in QEMU I did see people
cherry-picking from each other and committing with Signed-off-by *below=
*
the change log. ;)

Also, keeping commits and change log separate allows me to work on them
concurrently. As with editors, everyone will have their own preferences=
=2E

Cheers,
Andreas

--=20
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffer; HRB 16746 AG N=C3=
=BCrnberg
