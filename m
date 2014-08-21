From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: Re: Handling commit change logs (was: [PATCH v3 13/15] cpufreq: Add
 cpufreq driver for Tegra124)
Date: Thu, 21 Aug 2014 12:34:30 +0200
Message-ID: <CABxcv===wmDEs58_9s--EgvRBfhQP_ctawP_Bvb1y_B_3EGjmQ@mail.gmail.com>
References: <1408419205-10048-1-git-send-email-tuomas.tynkkynen@iki.fi>
	<1408419205-10048-14-git-send-email-tuomas.tynkkynen@iki.fi>
	<CAKohpokQOALPH13Ykz4nTBOby8J1X6_F30LNKz=gsC4wN3=3vg@mail.gmail.com>
	<53F3A900.8010805@nvidia.com>
	<CAKohponcZv9-MFNUQFxC_49-+P6QOhdjxsnYAyL3i4sXdCBYrw@mail.gmail.com>
	<CABxcv=ncm3Y7Ecfymro6TOuP=d10OV5--8n=dYmHyj6zi8hwEw@mail.gmail.com>
	<53F4FED4.7060408@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53F4FED4.7060408-l3A5Bk7waGM@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Tuomas Tynkkynen <tuomas.tynkkynen-X3B1VOXEql0@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello Andreas,

On Wed, Aug 20, 2014 at 10:02 PM, Andreas F=C3=A4rber <afaerber-l3A5Bk7waGM@public.gmane.org=
> wrote:
>>
>> So the second "---" from Tuomas patch is actually the one generated =
by
>> git format-patch but that gets discarded by git am just like any oth=
er
>> text so it causes no harm when other apply the patches.
>>
>> If this not the correct workflow and you have a better way to manage
>> this, I would love to know about it.
>
> One drawback of having --- in the commit message is that you can't
> cherry-pick but really need to use git-am for it to be stripped.
>

It depends on your workflow really, I don't consider the fact that git
cherry-pick does not omit that part a drawback but a feature ;-)

And as Stephen said you can do a git cherry-pick -e or amend the
commit and remove that part.

> I resorted to a scripted way of handling change logs: Per patch serie=
s I
> maintain a shell script that after git-format-patch essentially runs
> sed -i "/---/ r /dev/stdin" $OUTDIR/0001-*.patch <<EOCL
> ...
> EOCL
> to insert my text after ---. (sed syntax is not POSIX-compliant FWIW.=
)
> Similarly I fill in the blurbs for the cover letter.
>

Yes I used to use sed before indeed. Heiko also suggested patman which
looks quite interesting and may fit my workflow as well.

>
> Cheers,
> Andreas
>
> --

Best regards,
Javier
