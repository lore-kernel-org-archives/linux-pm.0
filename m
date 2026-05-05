Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DDD47F2CF
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990590; cv=pass; b=J59PPwvwSfJRrPBk+QzVI3SqWZGVLy9Uh93XLS3E+ZCb8AnHM61Mu0jO2H6RKSvl8hjf/TMgKqkSXT0mrD9Ovjz0GnHDfVcGLrbmsKjAvZi5qKySl5j7cPXigAgCr6Q3IR0JUfjV++K8EqnTDVpXQ1SdpqHPOmMzYRFO+UC3gz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990590; c=relaxed/simple;
	bh=kdL3pnqejRELK0jNVjnayG+VYLvtXvdrz73QwxHzyUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItRyAD8Bs2WBL9rF/L2SO7NQEC9E5gsb9/+GuxBb0YEdRNXNogzzKE+websnBtDh8jA06BoKWMcCbZTaCdFIGOIv+2BLhAJtudiQ+PFmO+jvJSzA31eJcH42AgxLuvr+l2y7Sxw7sxc6sbzy+VFf4xntas73B2cdoS3KJSQc6Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fz+bRqya; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fz+bRqya"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a4113ab355so5080891e87.1
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 07:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777990586; cv=none;
        d=google.com; s=arc-20240605;
        b=KsIN6ulXR59wq0AFL/L55C25SC2ykpaKLaVMQ/gnOhLhakeh5pKKmL9xQjyZmtAzCo
         9E9EH3JisZ0gepUO/e+CQwMtI5v1u7V/VMPR/bvW+M0CkOCsy63OBpYUUF2yvuzauRZN
         vJuL4/i+V2nURSsP2uZDBbQ23MyeEwr1IcWH+PNniJPiusZOkLx7qNMQj1IzRMFN7g+f
         v87zH1swIeaRPh3ZvEbLjYTLdB08WQUnebtEDsawEpCZwj9p+bxIlHvAyoBa06MMuy6f
         p14+gAEgwi8NJz/3jctzsv75yPKDqCVA93AQAPgbPBjDHupgD0fHzsjxZCcRIC8hAuV/
         WX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3n1BHwbT6sLMZPQ5Ra5Z4Dc4Gq+q3b4+gKTchSYDuYg=;
        fh=HEISWWJtK1o36gojNOKjtp8cd55+0NBkOm9NkDHb720=;
        b=fa8M0RJx089rrggAw77WDAnVCRCRgwV6KRZxuNPxjCm/k8+X2dYOWyB0pZf+9TWjM4
         UgTgAyfkt956D4mjqifI4rwpZHR34hOzW1lNYjPNOELA2kXGp/htXaVGnFy87LUs22f+
         gpV4dZuOjdTlZs5pqeBiJKLEcVWDBdmAXLOdxIIBXvOLjpfjgyBqJ6GKKl9uqqJRiP1f
         Uo+rKRBQdiNuX5Q9/1tqcS3JZdd+5+5qlDvmKsy93CPZ/G6agyJsWl2g2I/UejVQf67l
         hoSj/P32yZ/Wh9ccKkv1kIQn+V2djnXNoERQhpLsHJEvI10l+VC7bdl8DMTds9PxAyOn
         9D9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777990586; x=1778595386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3n1BHwbT6sLMZPQ5Ra5Z4Dc4Gq+q3b4+gKTchSYDuYg=;
        b=Fz+bRqyaolYxWH7bzXlOIzF+bWvRDKr/MnZ1qhn1o1kNe3ZHRl/dXMm+g+r04mWIJq
         rXSrsSF9LcytRkOPPmPrQcS3SnWN/Kt1qENuRipXtAWrurWZ6z9YfAaAYNZtUQiIGVDg
         M79WGwJWjo06Vh1MAWCtHmBcTclsYHR4llMI/XPh6yq0+XbpCz/gPgLN7tPiuR8V3bBj
         BSuDxgbPiJVKMDveIO0fqIo2LpnF9jwqvzP9AgMnJ59CCZlLhSins9rGK58uz6TSuwe1
         rFj4wKYb7ohpR18Udus6KMHKzMu+gIwC3W4LrGlMh5lefGTLlu/D0LWk3XM6bVXMDEqQ
         U7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777990586; x=1778595386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3n1BHwbT6sLMZPQ5Ra5Z4Dc4Gq+q3b4+gKTchSYDuYg=;
        b=ZsbJnCSE4rU4GswXO9Foo44JIqP/dlgUVqX+9o5GlT41fZlTSAV+YbiLjgIX7WgE/g
         l7LQBwzScQIRgCc8jXyLow5uyZ4bNCFUwnEm8+fGNYfN+Q0EOqtDwdfcOHFNSOuC3Lre
         bsyneQkvWxdZenqBuXdsrbjmFyCfYHrzPav47flBddI//E38j4SfMqwvbMGx6VJ36jXo
         VoZJE/1d9dD74BdapON3DQpuL73iZdu09W+SNi5UbD6jwwmCmq2+SjNHEj57epSHkRmC
         lS3HuoXIoz78U8EQQD3SNiuWtQyGsQ3yQ8NhnOe5aVzt5R8f7jJx9OmWXlCjpzDfuEmy
         +bGg==
X-Forwarded-Encrypted: i=1; AFNElJ9kmmeXSqGHYuDgVuBuGEBH/2VfMTPNG6i4MgQvnhryuB190BBTvyvcvpLNV+UesHobIgEOt5yRaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJa/zFJN5XSOU8Y++JuCCrSrdTSkVQd95iaiyGWw+4zqE62mID
	9viIe5kNXAPZ7YJ7k78jgbcLOcqgNGfWymAWh4dRKfnZKtKg4IKZpmHAU+/XsrGwpJ6OSi98jxl
	2fWy6wsBPttexgBXW4Y9u3k7/H9jGT3a9+qqhQaHPiZXJIlVCxTQRjzg=
X-Gm-Gg: AeBDies36fPxeRJP9CNsUKgPv3w/D1QkGnpCCfsCJGTtRoCMeQGzDw8lCnlc7wF6w9g
	RCMlkLp20NmWTbwRkbYFOdVR7VSWwE1jwGtZ2OYFivy6DKGUoFK16DFEcEctS6p+Y1168pV/35s
	4WtVlcqs6vTsqPBXQcUuTIxU2C3cWXpnGCOZJ77/aj9YCC7v0qWx/Z046FGmjuaNDUNiK+B7tra
	pkUWhis/GObuMPVx2Z9bIJspIe3qTFInIpqLqdZsidxfSVXFBrRNhbNZfcz+lTLE1ZyDkc8rMlJ
	Ujk9EFFU6PEFlTVLwn8=
X-Received: by 2002:a05:6512:a8c:b0:5a2:bc5d:c675 with SMTP id
 2adb3069b0e04-5a8631c1104mr5144695e87.28.1777990585964; Tue, 05 May 2026
 07:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410104058.83748-1-ulf.hansson@linaro.org>
 <20260410104058.83748-2-ulf.hansson@linaro.org> <DHW8QPU1VU1F.3P6PH69HLFBYC@kernel.org>
 <CAPDyKFqMDPiqvqJrq5Qs6Tw4Sc7szG4G-=y0NFkNSPoNd9kdVA@mail.gmail.com>
 <DHZMQLCIRJIS.174HZR6DIAOMM@kernel.org> <CAPDyKFoKNpUexGrM0zcysKMKcdYT-cU0_Q_AHbgiGPk_gU-3nA@mail.gmail.com>
 <DIAR5LATLBNK.1CSW7AD5VRN77@kernel.org>
In-Reply-To: <DIAR5LATLBNK.1CSW7AD5VRN77@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 5 May 2026 16:15:49 +0200
X-Gm-Features: AVHnY4JoQ9U8rU1C6LkDXLwkHY8Lk-vfHOOrZ84KcQURDPW5oqZb9k-nt-xLubU
Message-ID: <CAPDyKFqbdDHRj6ZTAs62K=T833Ko7Mu2Bna9D8pjhd=Niw1DbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] driver core: Enable suppliers to implement fine
 grained sync_state support
To: Danilo Krummrich <dakr@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@kernel.org>, 
	Cristian Marussi <cristian.marussi@arm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
	Peng Fan <peng.fan@oss.nxp.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 May 2026 at 14:46, Danilo Krummrich <dakr@kernel.org> wrote:
>
> On Tue May 5, 2026 at 1:12 PM CEST, Ulf Hansson wrote:
> > On Wed, 22 Apr 2026 at 12:59, Danilo Krummrich <dakr@kernel.org> wrote:
> >>
> >> On Wed Apr 22, 2026 at 12:07 PM CEST, Ulf Hansson wrote:
> >> > On Sat, 18 Apr 2026 at 13:23, Danilo Krummrich <dakr@kernel.org> wrote:
> >> >> On Fri Apr 10, 2026 at 12:40 PM CEST, Ulf Hansson wrote:
> >> >> > @@ -1126,6 +1128,9 @@ static void __device_links_queue_sync_state(struct device *dev,
> >> >> >       if (dev->state_synced)
> >> >> >               return;
> >> >> >
> >> >> > +     if (dev->driver && dev->driver->queue_sync_state)
> >> >> > +             dev->driver->queue_sync_state(dev);
> >> >>
> >> >> This seems to be called without the device lock being held, which seems to allow
> >> >> the queue_sync_state() callback to execute concurrently with remove(). This
> >> >> opens the door for all kinds of UAF conditions in drivers.
> >> >
> >> > If that were the case, this whole function would be unsafe even before
> >> > this change. I assume this isn't because of how the function is being
> >> > called, but I may be wrong.
> >>
> >> This function does not issue any driver callbacks intentionally; the existing
> >> sync_state() callback is deferred to device_links_flush_sync_list(), which is
> >> called without the device_links_write_lock() held, but takes the device_lock()
> >> to protect against other concurrent driver callbacks, such as remove().
> >>
> >> I.e. we can't take the device_lock() when the device_links_write_lock() is held,
> >> as it would be prone to lock inversion.
> >
> > You are right, the device_lock() is needed in
> > device_links_flush_sync_list() to protect against concurrent driver
> > callbacks from being invoked, such as the ->remove().
> >
> > However, as part of the removal procedure in
> > __device_release_driver(), we also need to account for device links.
> > Hence we call device_links_busy() which takes the
> > device_links_write_lock().
>
> I don't think this is sufficient.
>
> I wrapped my head around this about three weeks ago and I think there were
> multiple cases where this falls apart. I think one case was:
>
>   1. Consumer binds, supplier is added to deferred_sync. Consumer unbinds,
>      link goes to AVAILABLE.
>
>   2. device_links_busy(supplier) takes and releases device_links_write_lock(),
>      finds no ACTIVE consumers, returns false -- drv->remove() starts without
>      device_links_write_lock() held.
>
>   3. device_links_supplier_sync_state_resume() takes device_links_write_lock(),
>      finds supplier still on deferred_sync -- device_links_driver_cleanup()
>      hasn't run yet, blocked on the lock. queue_sync_state() is called
>      concurrently with drv->remove().

Thanks for pointing this out! More problems seem to exist regarding the above.

What if drv->remove(supplier) completes before
device_links_supplier_sync_state_resume() is called and the removed
device is still in the deferred_sync list? Probably another
get|put_device() is needed to protect us from UAF.

>
> But again, I think that's what I concluded three weeks ago and this state
> machine is rather tricky.

Indeed it is.

>
> That said, *even if* we could prove that this works in all cases, it would be
> very subtle, pretty fragile and not by design.
>
> The whole state machine around sync state is already rather complicated. So, if
> we really want to make it an invariant that it is valid to call bus device
> callbacks without holding the device lock from
> __device_links_queue_sync_state(), I think this has to be carefully reflected by
> the overall design making it *very explicit* how this invariant holds up in all
> cases.

Right.

I experimented with adding the devices for ->queue_sync_state() into a
separate list and then flushing that list similarly to how the
sync_state list is flushed. It becomes messy, but I guess there is no
other way.

Perhaps Saravana has another suggestion for how to implement this?

>
> Otherwise, I'd be rather concerned that this becomes a source of subtle bugs.

Kind regards
Uffe
