Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78172313E21;
	Tue, 19 May 2026 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779210917; cv=none; b=Qp1UL14whzMwgFpcj2Mi8F8bWLO3hbnYmF6BybTvmhO1vONVmXpfgMubaIpFPB0QVbZRPzbotcXDzLlYNNXzdehW23BhipGXaJhMv6FGKhTosHzgx45g2hNfDpcLwLzpVq43s1Mv1pFxwzqN0HzThXR1e11I38a6+Q/AKH+ESMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779210917; c=relaxed/simple;
	bh=2yHEqpplFeOVxUF8U8yDdYFlSqjc30iKgg96gPrY2Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dU/9DZG96EfxZOe91hc9Wl6x2J71nSdImWkq3RcbFyBCh04qn1EipUvup7oKqZSPDFcF1P3CHIySFSr1iF7Tfix1V5UUn4dzkdrvtw1bGSoL4cDYyerX/EKWA0GTbLbCvaB+XjL4ppP0y5tMfe0FYXYyEZrONvFOGzEyEHzkZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBWO61en; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBWO61en"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B69C2BCB3;
	Tue, 19 May 2026 17:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779210917;
	bh=2yHEqpplFeOVxUF8U8yDdYFlSqjc30iKgg96gPrY2Nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBWO61enma2Xv+rAP8TbfAdCXU9A8GYPe8Kk9nze/FB302KPRS0c79nq63IJcuCnc
	 1wa3eDr8LGPtkArwWjucdH0Ls9MoTwKWmItxN6Nl6UJZkk3LUBHDVfpI9/H21Gdctb
	 v9Zily5JFG0F8DLO0HPx3UblyvvJtezn2NXCsYycsuouJ4KqVDAJDUC2TEdPXgRBsy
	 7RkyXv8AtRZbeUbVSQ6dUtzXy2mLMkPKTnA31Ver8v6ysG3bsGNIl+gQBNX6hQKtU9
	 DKMJrjVC4U2ALz379ZErpio068Ekc8NyazaPKiE1drZ27ZJp+NTwLEbLqUEcNe3Dau
	 j48+yGFllz3wg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Nick <nick@kousu.ca>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 regressions@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [REGRESSION] Toshiba Fn keys + lidswitch
Date: Tue, 19 May 2026 19:15:13 +0200
Message-ID: <12896447.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0jVQyWYqPo_MiUwNQb7FLNR_Q_++Xq=xA1owcHpcjN=OA@mail.gmail.com>
References:
 <E2OXET.4X5GTP37VTNC3@kousu.ca>
 <CAJZ5v0jVQyWYqPo_MiUwNQb7FLNR_Q_++Xq=xA1owcHpcjN=OA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Tuesday, May 19, 2026 4:08:36 PM CEST Rafael J. Wysocki wrote:
> On Tue, May 12, 2026 at 7:16=E2=80=AFPM Nick <nick@kousu.ca> wrote:
> >
> > My Toshiba Tecra X40 laptop's function keys no longer send events.
> >
> > Specifically the mute ("KEY_MUTE"), lock ("KEY_COFFEE"), "power plan"
> > ("KEY_BATTERY"), sleep ("KEY_SLEEP"), mic mute (for some reason this
> > reads as "KEY_SUSPEND"), screen switch ("KEY_SWITCHVIDEOMODE"),
> > brightness ("KEY_BRIGHTNESSDOWN" and "KEY_BRIGHTNESSUP"), and rfkill
> > ("KEY_WLAN") hotkeys -- these are the Fn-shifted versions of Esc, F1,
> > F2, F3, F4, F5, F6, F7 and F8 -- keys no longer work. Neither does the
> > lid-switch.
> >
> > Fn+F9, Fn+10, Fn+F11 and Fn+12 still work; those show up on
> > /dev/input/event3 like the rest of my keyboard, but the hotkeys show up
> > on /dev/input/event6.
> >
> > I'm on ArchLinux. My keys worked on v6.19.14, I first noticed them
> > broken on v7.0.2.
> >
> > I bisected mainline and found the break is: "ACPI: scan: Use
> > acpi_setup_gpe_for_wake() for buttons"
> > <https://lore.kernel.org/all/2259694.irdbgypaU6@rafael.j.wysocki/>.
> > That is, 57c31e6d620f132dcf610b2c52b4cdbd203c6f4a is bad and
> > 88fad6ce090b395af4c654594a54589a386bf24b is good.
> >
> > #regzbot introduced: 57c31e6d620f132dcf610b2c52b4cdbd203c6f4a
> >
> > Maybe acpi_mark_gpe_for_wake was initializing something particular to
> > Toshiba hardware?
>=20
> Thanks for reporting!
>=20
> I think that the problem is acpi_setup_gpe_for_wake() doing too much,
> I'll send you a patch to test later today.

So please let me know if the patch below fixes the problem for you.

In either case, please grep the dmesg output for "ACPI GPE" and let me know
the result.

Thanks!

=2D--
 drivers/acpi/scan.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

=2D-- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1000,11 +1000,15 @@ static int acpi_bus_extract_wakeup_devic
 	return err;
 }
=20
+/* Do not use a button for S5 wakeup */
+#define ACPI_AVOID_WAKE_FROM_S5		BIT(0)
+
 static bool acpi_wakeup_gpe_init(struct acpi_device *device)
 {
 	static const struct acpi_device_id button_device_ids[] =3D {
=2D		{"PNP0C0D", 0},	/* Lid */
=2D		{"PNP0C0E", 0},	/* Sleep button */
+		{"PNP0C0C", 0},				/* Power button */
+		{"PNP0C0D", ACPI_AVOID_WAKE_FROM_S5},	/* Lid */
+		{"PNP0C0E", ACPI_AVOID_WAKE_FROM_S5},	/* Sleep button */
 		{"", 0},
 	};
 	struct acpi_device_wakeup *wakeup =3D &device->wakeup;
@@ -1014,8 +1018,21 @@ static bool acpi_wakeup_gpe_init(struct
 	wakeup->flags.notifier_present =3D 0;
=20
 	match =3D acpi_match_acpi_device(button_device_ids, device);
=2D	if (match && wakeup->sleep_state =3D=3D ACPI_STATE_S5)
=2D		wakeup->sleep_state =3D ACPI_STATE_S4;
+	if (match) {
+		acpi_event_status gpe_status =3D 0;
+
+		if (wakeup->sleep_state =3D=3D ACPI_STATE_S5 &&
+		    match->driver_data =3D=3D ACPI_AVOID_WAKE_FROM_S5)
+			wakeup->sleep_state =3D ACPI_STATE_S4;
+
+		acpi_get_gpe_status(wakeup->gpe_device, wakeup->gpe_number,
+				    &gpe_status);
+		if (gpe_status & ACPI_EVENT_FLAG_ENABLE_SET) {
+			acpi_enable_gpe(wakeup->gpe_device, wakeup->gpe_number);
+			dev_info(&device->dev, "ACPI GPE enabled for %s\n",
+				 (char *)match->id);
+		}
+	}
=20
 	status =3D acpi_setup_gpe_for_wake(device->handle, wakeup->gpe_device,
 					 wakeup->gpe_number);



