From: Borislav Petkov <bp@alien8.de>
Subject: Re: pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x50
 [snd_hda_intel] returns -11
Date: Wed, 12 Dec 2012 13:13:45 +0100
Message-ID: <20121212121345.GB8760@liondog.tnic>
References: <20121211170315.GC28827@liondog.tnic>
 <2487425.bAQggRZzC4@vostro.rjw.lan>
 <20121211175508.GE28827@liondog.tnic>
 <15066310.xXEWfqCuJc@vostro.rjw.lan>
 <s5hhanrh6zi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hhanrh6zi.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, lkml <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 12, 2012 at 11:58:41AM +0100, Takashi Iwai wrote:
> Borislav, could you test the patch below?

[ =E2=80=A6 ]

> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Move runtime PM check to runtime_idle ca=
llback
>=20
> The runtime_idle callback is the right place to check the suspend
> capability, but currently we do it wrongly in the runtime_suspend
> callback.  This leads to a kernel error message like:
>    pci_pm_runtime_suspend(): azx_runtime_suspend+0x0/0x50 [snd_hda_in=
tel] returns -11
> and the runtime PM core would even repeat the attempts.
>=20
> Reported-by: Borislav Petkov <bp@alien8.de>

	  -and-tested-by: ...

Thanks Takashi.

--=20
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
