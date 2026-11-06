Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990788;
	b=I38izjmPErTvt1TQWbRji1Em81Qvh0v0MuSVhW6QKKpLht/LfkxL2rlPPRMd9NIGUsl+
	 vfV5Un0vmKhmHQpITXSTXvHvG4L9EiDl3Opmd5voGdLvtaqKe6OBfKpv8CkirC5IJ/Hjs
	 +6xWHl7wr/zaB/NgoWDiKjMmkfZhzCFMIsU1gg19SZtsN2LqUFfrvRzuwGUBKpvgdeSF2
	 i681cb+JPFMOlWmi4C/QMqPov7tfd80uGTrmWV7WuAf5QDH+j6TdxMtowkeVjnporBMsx
	 z/qCnJLzVAXMTreRFzljw75pk3dzzXFtjooY8VZB6p4VQzTLkyPHDgCRuz/tNdQ+WkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990788;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kvlZTeuGbWU9PNhLC0edg6qGMEBjJAa+7sDS1JPc3bo=;
	b=mAkdLayHBKkCSs5ICO1HBmlvoLbwDJaKAW9fDWL885KKoigpShq1asN9J9p7sbi9dx/X
	 xKDxyE0RQCEHDCCjomjTKMxblgIfJlIB4KFF/D+Ks1PBw1IM7z8fLx/IsyWhhlSzQa2Cm
	 AJ7VOo3YdEiMJ0BqYEM+mJ7IWd/HdcOJ1nsrOM1Iy19uUET37OvQvXDKO+5ArXQNZVYS1
	 nxXq8ZoZCfa8qcpNMQ25mRob6U5ZMVeypxjexIw1l1kxKwOvvWNBxT4MvsR5jUibnPrgT
	 wPQ29gsNAfwO/SmTofcAJSoKNhJ2w5xDNJsnxjSdEQjnDcSjdhNJcwbGZjiMlpoaHnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dZs5fun0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6830B606D812
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dZs5fun0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3504D1F00903
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990788;
	bh=kvlZTeuGbWU9PNhLC0edg6qGMEBjJAa+7sDS1JPc3bo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dZs5fun0un/Yx94GA5Cyywhj0d0G5t5hA30nD7DFMDv5Rpdgh/jNfoQKW84xvnYUy
	 g+UUZfVd+Nebx3J4dgj9JfOBkPGy1n9WNmYXGKQFvSeorASlprb23KJA9RbAIGjhFj
	 W5cHSUABSZ8uESJZbShJ7B11yBRJRI4O3he55wRRpANjA5bAcmYsznQy6vOJ2jJ36D
	 bIOYsW/KsT/6eqUQbBpB+TzdkLk6+Nh4w12F0t0edaxzhRKhJ79WonwleDBqE7sEAN
	 c6O3hPtEAULRQgQ3zrRZ7ZuwJ6Sjff4XphX6FT+YF3KCer2i+9mKK0SjYWLtxh0jMt
	 I/y1h774UowbQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bff8fc7cf2so1026504e87.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 10:46:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFsuYDOa2OpTueQ4vA30/wpWn8Fw6t/9g3bf7sejfWztSdhjvUbo3Jn3IV/wCnmWDXAcaEmSgM4Sg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/yusqQ+yy5jxSqLlKLqt95B6Ixh2kW9W112uF9tN/6MpKPuiuj
	zgijLdnlwnjUEYo0bCHl4U5nxzldLhNsOK3vi8Lwta2v34a3qTGQMSsgSFORUP9C23i5dL7sWQY
	uZ6eeOTMEhZZuy2cInBByK+oJRm50fBw=
X-Received: by 2002:a05:6512:124e:b0:5bf:ec93:5a1e with SMTP id
 2adb3069b0e04-5c003aadad3mr952697e87.32.1793990786529; Fri, 06 Nov 2026
 10:46:26 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-b4-pm-sleep-hibernation-fixes-v1-0-51fac96d080d@oss.qualcomm.com>
 <20261102-b4-pm-sleep-hibernation-fixes-v1-1-51fac96d080d@oss.qualcomm.com>
In-Reply-To: <20261102-b4-pm-sleep-hibernation-fixes-v1-1-51fac96d080d@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 6 Nov 2026 19:46:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i4ZpQJQ_9kgfdT=h=UQj6L83G4d3_eqtxLGhjidwLr-A@mail.gmail.com>
X-Gm-Features: AclHuK9hshrDYSytMfZAEWpJCHllS7oAiyNatjF67iwMDI7sm5v9aviMYoNn9B0
Message-ID: <CAJZ5v0i4ZpQJQ_9kgfdT=h=UQj6L83G4d3_eqtxLGhjidwLr-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: sleep: Do not mark devices without PM callbacks
 active on resume
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Ulf Hansson <ulfh@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 3:47=E2=80=AFPM Abel Vesa <abel.vesa@oss.qualcomm.co=
m> wrote:
>
> Devices without system sleep callbacks get power.smart_suspend set in
> device_prepare_smart_suspend(), unless their parent or a supplier
> prevents it, so device_resume_noirq() sets their runtime PM status to
> "active" whenever dev_pm_skip_resume() returns false. That is always
> the case for PM_EVENT_RESTORE.
>
> Nothing resumes such a device, though.

Too bad because it should be resumed in the "restore" phase of
hibernation.  The concept of keeping devices in runtime suspend across
hibernation is just fundamentally broken.

> If its bus or driver manages
> resources from runtime PM callbacks, those resources stay off while the
> device is now reported as active, and the next runtime suspend releases
> them a second time.
>
> AMBA devices are an example, since the AMBA bus only has runtime PM
> callbacks, which enable and disable the APB clock. After restoring from
> hibernation on a Qualcomm Glymur CRD, the runtime-suspended CoreSight
> devices are marked active, and the following runtime suspend of each of
> them hits:
>
>   qdss already disabled
>   WARNING: drivers/clk/clk.c:1259 at clk_core_disable+0xa4/0xac
>   Call trace:
>    clk_core_disable+0xa4/0xac (P)
>    clk_disable+0x30/0x4c
>    amba_pm_runtime_suspend+0x58/0x74
>    __rpm_callback+0x48/0x1e0
>    rpm_callback+0x58/0x64
>    rpm_suspend+0x10c/0x5a4
>    pm_runtime_work+0xc8/0xd8
>
> followed by "qdss already unprepared".
>
> On suspend-to-RAM this does not happen, because such devices take the
> direct_complete path and device_resume_noirq() returns early for them.
>
> Leave the runtime PM status of devices without PM callbacks as it is.

If I'm not mistaken, doing so may break the cases in which a device
without PM callbacks and runtime PM enabled is the parent of a device
with smart_suspend set because there will be a runtime-active device
under a runtime-suspended parent.

> Fixes: bca84a7b93fd ("PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally=
")
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  drivers/base/power/main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 88a31e09e4f3..16a1f017051e 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -839,10 +839,15 @@ static void device_resume_noirq(struct device *dev,=
 pm_message_t state, bool asy
>          * Otherwise, the device is going to be resumed, so set its PM-ru=
ntime
>          * status to "active" unless its power.smart_suspend flag is clea=
r, in
>          * which case it is not necessary to update its PM-runtime status=
.
> +        *
> +        * A device without system sleep callbacks is not going to be res=
umed
> +        * by anyone, though, so leave its PM-runtime status as is. Other=
wise,
> +        * resources managed by its runtime PM callbacks, like the bus cl=
ock of
> +        * an AMBA device, would end up unbalanced on the next runtime su=
spend.
>          */
>         if (skip_resume)
>                 pm_runtime_set_suspended(dev);
> -       else if (dev_pm_smart_suspend(dev))
> +       else if (dev_pm_smart_suspend(dev) && !dev->power.no_pm_callbacks=
)
>                 pm_runtime_set_active(dev);
>
>         if (dev->pm_domain) {
>
> --
> 2.54.0
>
