Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189707;
	b=tdW8sN5vADGZbkpM/prMP2QpDW1gRyuT7xfT0c1gL3N0263g7w/Sl4f/IUHzKXgHP6ns
	 eM6670EC8WPP4+uQpl3O9QuYtEd1JP5y9/4IGBFhdOXjchZABrUavk8oZSqYy51VUhKZ8
	 wWQTNu+s+gKIktB1lCyK3MxeXdi+wypX6AM7wjCPi/QhfdRPAClDIZZS8xNB+94j63PaU
	 yLOUSp9rBPqi4rwaBoEsdZfrClK9lTJsSlDkGB6Nqfmm3sXR/MwNPMgmzYc2fH7rguhky
	 qpEgtMbZRBbjLtMbHPYOaSYMjQosVTVrX8gJjVRcTuAk/GpzecqYVqkW1KB+7+t19ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189707;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uoCLXlIyzTuVjcKkec7UtFiflj2Avxbg288tSQZ5p04=;
	b=rTI/IMofzv4lRWmHTJORIdHfhxgiJAVfX22DdB0vFU7meW/wofUzHfltBCj3wUlvZvfq
	 ljeKHTuYJ5nNP00N2kU98l0+iEvUZ5Zi9XUy1o7LSxpBquxmGFipnEi/LOL0zF237YntG
	 l413mYTIKasYTS355AFNSkmpx0ell9Ua+mOZMTWbF0WGe4lqBLgBK/1/1Qx0fcp6JMMZP
	 zprdM6WPSSMYYXeE//+1JNXnVNNQ45cRaIC49R/H5hYXrdm562usJDlaj1HzVifK31aCE
	 heZQvKDgx8CVFWfdAyLoh/1VANQ+fj6b9TC9LN4UdASjcg3VYtbhNAMtZYMohyK7Mnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQh0VJwT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B0E606A32C
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQh0VJwT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FC21F000ED
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 15:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795189707;
	bh=uoCLXlIyzTuVjcKkec7UtFiflj2Avxbg288tSQZ5p04=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nQh0VJwTgDgdrEhJmK1lo+HQXM7C78ahzsguFe+Ayghpa8C8GxU32GQIIq8lSPBr2
	 tBRZEbSLo0q/x+kPfxKl6d/xHuBTZKbvUODjOpS1KQvWvDeUBmg1fyv+6vGiwcgSjZ
	 0XYwchPNFp0yZSMwrckMI5nv/rLvUvhAKvBBOY8odnSvX+IZJZkdS98nAcaQk1/I2m
	 VuCVJQ5ZidOry1A4ewKgBpbnqRr2KaWmOUoHBpXsLMnRH+mglNymSRw9SXuptPkywM
	 ISAOoSPlvOSr1TsLcIlRO4KJoB9aA04LDI/ms2XPczGEcORqCwYe9kbdzvt93ue/s8
	 /AI2GHYgWKeJQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3adef977ad9so8380581fa.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 07:48:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEG4TLv/iN6R/liiTy96cS4fWUtA1nTVbfhQz0ftjc+hLG3tEUvbcMrQ3glQfn2M9Mu4C7Nr9BvOg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/E8dRUBa4Kip48YWtSvj10Q8rA99wfpGDW9JyMuqgI47+NTNZ5
	PraW8t2wgK9iE8vEPGfrqy3ro9anb+LXsSXOmnjJ//BMCVygZ30HcN4k499KtnZWSA81YmHTyIK
	Yadob0jbyuEylBn8lyQGcPWdIyl998U0=
X-Received: by 2002:a2e:ac0c:0:b0:3a9:811d:3a58 with SMTP id
 38308e7fff4ca-3ae7f9da2admr11520241fa.14.1795189705315; Fri, 20 Nov 2026
 07:48:25 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-pm-clk-resume-report-errors-v1-1-ba6e1dddd522@oss.qualcomm.com>
 <CAFEp6-3GKHmc4y_mTTVMO6iPdnpmxEmRokpki4uVGoBuXTj6Hg@mail.gmail.com>
In-Reply-To: <CAFEp6-3GKHmc4y_mTTVMO6iPdnpmxEmRokpki4uVGoBuXTj6Hg@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 16:48:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hftga=t4QGoc8C3iY-zVYwewXi9BK3xnEdTm5KuOsNOQ@mail.gmail.com>
X-Gm-Features: Aa3M54q_rzvZFVXpc28f17CurETrF5JEsNbmkva9b4j9EDron5Ym5vF04rjyMSA
Message-ID: <CAJZ5v0hftga=t4QGoc8C3iY-zVYwewXi9BK3xnEdTm5KuOsNOQ@mail.gmail.com>
Subject: Re: [PATCH] PM: clk: Report clock enable failures from pm_clk_resume()
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 7:37=E2=80=AFPM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> On Mon, Nov 2, 2026 at 11:23=E2=80=AFAM Abel Vesa <abel.vesa@oss.qualcomm=
.com> wrote:
> >
> > pm_clk_resume() logs a clock that fails to start but always returns
> > success, so the runtime resume of a device using the PM clock helpers
> > succeeds without its clocks, and its driver goes on and accesses the
> > hardware.
> >
> > This happens to the devices in the Qualcomm LPASS, whose clocks are
> > provided by the ADSP: after the ADSP is gone, like right after a
> > hibernation image is restored, a sound card opened by user space
> > resumes the LPASS LPI pin controller without clocks, and the access to
> > its registers then brings the whole machine down:
> >
> >   qcom-prm gprsvc:service:2:2: CMD timeout for [100100f] opcode
> >   qcom-sm8550-lpass-lpi-pinctrl 6e80000.pinctrl: __pm_clk_enable: faile=
d to enable clk 00000000b90a5151, error -110
> >
> > Stop at the first clock that fails to start, stop the ones started
> > before it, and return the error, so that the resume fails and the
> > device stays suspended with its clocks off.
> >
> > The callers of pm_clk_resume() check what it returns, including genpd
> > and pm_clk_runtime_resume(), except the MMP2 audio clock controller,
> > which keeps ignoring it. A device with a clock that fails to start no
> > longer resumes though, even if it used to work without that clock.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Applied as 7.5 material, thanks!

> > ---
> > pm_clk_resume() always returns success, even when a clock fails to
> > start, so a device using the PM clock helpers resumes without its clock=
s
> > and its driver goes on accessing the hardware.
> >
> > I hit this on the Qualcomm Hamoa CRD while working on hibernation: the =
LPASS
> > devices get their clocks from the ADSP, and when the ADSP is gone, like
> > right after a hibernation image is restored, a sound card opened by use=
r
> > space resumes the LPASS LPI pin controller without clocks and the whole
> > machine resets on the first register access. With this patch, the
> > resume fails, the open fails, and the machine stays up until the ADSP i=
s
> > restarted.
> >
> > The LPASS macro drivers already check what pm_clk_resume() returns, but
> > never saw an error so far.
> >
> > Prepared with help from an LLM-based assistant.
> > ---
> >  drivers/base/power/clock_ops.c | 56 ++++++++++++++++++++++++++++++----=
--------
> >  1 file changed, 40 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_=
ops.c
> > index 3b8ba27802a8..a978eb3d5479 100644
> > --- a/drivers/base/power/clock_ops.c
> > +++ b/drivers/base/power/clock_ops.c
> > @@ -143,8 +143,10 @@ static void pm_clk_op_unlock(struct pm_subsys_data=
 *psd, unsigned long *flags)
> >   * __pm_clk_enable - Enable a clock, reporting any errors
> >   * @dev: The device for the given clock
> >   * @ce: PM clock entry corresponding to the clock.
> > + *
> > + * Return: 0 on success or the error from enabling the clock.
> >   */
> > -static inline void __pm_clk_enable(struct device *dev, struct pm_clock=
_entry *ce)
> > +static inline int __pm_clk_enable(struct device *dev, struct pm_clock_=
entry *ce)
> >  {
> >         int ret;
> >
> > @@ -156,13 +158,29 @@ static inline void __pm_clk_enable(struct device =
*dev, struct pm_clock_entry *ce
> >                 ret =3D clk_enable(ce->clk);
> >                 break;
> >         default:
> > -               return;
> > +               return 0;
> >         }
> >         if (!ret)
> >                 ce->status =3D PCE_STATUS_ENABLED;
> >         else
> >                 dev_err(dev, "%s: failed to enable clk %p, error %d\n",
> >                         __func__, ce->clk, ret);
> > +
> > +       return ret;
> > +}
> > +
> > +static inline void __pm_clk_disable(struct pm_clock_entry *ce)
> > +{
> > +       if (ce->status !=3D PCE_STATUS_ENABLED)
> > +               return;
> > +
> > +       if (ce->enabled_when_prepared) {
> > +               clk_disable_unprepare(ce->clk);
> > +               ce->status =3D PCE_STATUS_ACQUIRED;
> > +       } else {
> > +               clk_disable(ce->clk);
> > +               ce->status =3D PCE_STATUS_PREPARED;
> > +       }
> >  }
> >
> >  /**
> > @@ -483,17 +501,8 @@ int pm_clk_suspend(struct device *dev)
> >         if (ret)
> >                 return ret;
> >
> > -       list_for_each_entry_reverse(ce, &psd->clock_list, node) {
> > -               if (ce->status =3D=3D PCE_STATUS_ENABLED) {
> > -                       if (ce->enabled_when_prepared) {
> > -                               clk_disable_unprepare(ce->clk);
> > -                               ce->status =3D PCE_STATUS_ACQUIRED;
> > -                       } else {
> > -                               clk_disable(ce->clk);
> > -                               ce->status =3D PCE_STATUS_PREPARED;
> > -                       }
> > -               }
> > -       }
> > +       list_for_each_entry_reverse(ce, &psd->clock_list, node)
> > +               __pm_clk_disable(ce);
> >
> >         pm_clk_op_unlock(psd, &flags);
> >
> > @@ -504,6 +513,9 @@ EXPORT_SYMBOL_GPL(pm_clk_suspend);
> >  /**
> >   * pm_clk_resume - Enable clocks in a device's PM clock list.
> >   * @dev: Device to enable the clocks for.
> > + *
> > + * Return: 0 on success or a negative error code. If a clock fails to =
start,
> > + * the clocks started before it are stopped again.
> >   */
> >  int pm_clk_resume(struct device *dev)
> >  {
> > @@ -521,12 +533,24 @@ int pm_clk_resume(struct device *dev)
> >         if (ret)
> >                 return ret;
> >
> > -       list_for_each_entry(ce, &psd->clock_list, node)
> > -               __pm_clk_enable(dev, ce);
> > +       list_for_each_entry(ce, &psd->clock_list, node) {
> > +               ret =3D __pm_clk_enable(dev, ce);
> > +               if (ret)
> > +                       break;
> > +       }
> > +
> > +       /*
> > +        * A device whose clocks are not running cannot be accessed. Do=
 not
> > +        * pretend it resumed, and leave its clocks off as it stays sus=
pended.
> > +        */
> > +       if (ret) {
> > +               list_for_each_entry_continue_reverse(ce, &psd->clock_li=
st, node)
> > +                       __pm_clk_disable(ce);
> > +       }
> >
> >         pm_clk_op_unlock(psd, &flags);
> >
> > -       return 0;
> > +       return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(pm_clk_resume);
> >
> >
> > ---
> > base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
> > change-id: 20261029-pm-clk-resume-report-errors-b5d538eb27de
> >
> > Best regards,
> > --
> >
> > Abel
> >
> >
