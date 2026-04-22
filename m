Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97893C3C03;
	Wed, 22 Apr 2026 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776855596; cv=none; b=BzIj+KiyX44Vfn/kg13nii0LmD3jzPMgqOEfoFPhuWoWTuMQEPHg7EhK6jTX0qe1IfQ1x1FnArNIiQ5Fcl75qPwq98s8ZDJhYKqozfXx6K3hc0b4nQMmHEOSjIGNFORuCnXUoHwAvs3a73yUPGfoZ95sM23EB4RIelHn/wzzBQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776855596; c=relaxed/simple;
	bh=//4P/Sn26KXkVxYjuyHGjNLQZAH/u/OsyriEY0/4JAc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=BKUcaLunwzdpXh6vUFC5ZbR+TmztXEApPwFgoycvsmTJv01ZHbqRR+zw74LW/jkBoAVwEsHgWiFaO2Jr+13gXbSJu1V5FV8h9149WJ/Fmrkda3yA/5qvC+0rcL6DGYFPxty2rp7zyGOl8AJiO3Kl5lw/SDooGFCbGNQK5oZ+1vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3No9sWz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3No9sWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0BEC2BCB4;
	Wed, 22 Apr 2026 10:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776855596;
	bh=//4P/Sn26KXkVxYjuyHGjNLQZAH/u/OsyriEY0/4JAc=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=k3No9sWzlLT2r4ZMl9+SBaXKDt4bu1LA4TAhpAyGDknf+FGRUaW9Ne1wpqXRTdvTL
	 6h5kikyJIMu7OTw9cIpccxhnb+U91HZsVGo1F/Y+hDvRk8The/76e16RHWUcy3BSR4
	 gHvIr3t89F8Iazm0vUqbrMTKcK2oPLLspqHPAU0FHiXkitUOsGc9XadLludz1TCA0b
	 IaLs7qm90LRhD6HYw1i4Du919AZoIdW6pH7XWI5DGFYAv11QlPBs3krYgdhvxEtxd1
	 Ih883vxjz/kV9whvNannzUqNvd6AjAquij7/HkZGyGBkBFPuKOuPZSjie77mATg4YZ
	 nqhKF6weetQ/g==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Apr 2026 12:59:50 +0200
Message-Id: <DHZMQLCIRJIS.174HZR6DIAOMM@kernel.org>
To: "Ulf Hansson" <ulf.hansson@linaro.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/9] driver core: Enable suppliers to implement fine
 grained sync_state support
Cc: "Saravana Kannan" <saravanak@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <linux-pm@vger.kernel.org>, "Sudeep Holla" <sudeep.holla@kernel.org>,
 "Cristian Marussi" <cristian.marussi@arm.com>, "Kevin Hilman"
 <khilman@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Abel Vesa" <abel.vesa@oss.qualcomm.com>, "Peng
 Fan" <peng.fan@oss.nxp.com>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Maulik Shah"
 <maulik.shah@oss.qualcomm.com>, "Konrad Dybcio" <konradybcio@kernel.org>,
 "Thierry Reding" <thierry.reding@gmail.com>, "Jonathan Hunter"
 <jonathanh@nvidia.com>, "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 <driver-core@lists.linux.dev>
References: <20260410104058.83748-1-ulf.hansson@linaro.org>
 <20260410104058.83748-2-ulf.hansson@linaro.org>
 <DHW8QPU1VU1F.3P6PH69HLFBYC@kernel.org>
 <CAPDyKFqMDPiqvqJrq5Qs6Tw4Sc7szG4G-=y0NFkNSPoNd9kdVA@mail.gmail.com>
In-Reply-To: <CAPDyKFqMDPiqvqJrq5Qs6Tw4Sc7szG4G-=y0NFkNSPoNd9kdVA@mail.gmail.com>

On Wed Apr 22, 2026 at 12:07 PM CEST, Ulf Hansson wrote:
> On Sat, 18 Apr 2026 at 13:23, Danilo Krummrich <dakr@kernel.org> wrote:
>> On Fri Apr 10, 2026 at 12:40 PM CEST, Ulf Hansson wrote:
>> > @@ -1126,6 +1128,9 @@ static void __device_links_queue_sync_state(stru=
ct device *dev,
>> >       if (dev->state_synced)
>> >               return;
>> >
>> > +     if (dev->driver && dev->driver->queue_sync_state)
>> > +             dev->driver->queue_sync_state(dev);
>>
>> This seems to be called without the device lock being held, which seems =
to allow
>> the queue_sync_state() callback to execute concurrently with remove(). T=
his
>> opens the door for all kinds of UAF conditions in drivers.
>
> If that were the case, this whole function would be unsafe even before
> this change. I assume this isn't because of how the function is being
> called, but I may be wrong.

This function does not issue any driver callbacks intentionally; the existi=
ng
sync_state() callback is deferred to device_links_flush_sync_list(), which =
is
called without the device_links_write_lock() held, but takes the device_loc=
k()
to protect against other concurrent driver callbacks, such as remove().

I.e. we can't take the device_lock() when the device_links_write_lock() is =
held,
as it would be prone to lock inversion.

The documentation of __device_links_queue_sync_state() actually slightly hi=
nts
at this, but focuses more on the other reason for the deferred semantics --=
 the
sync_state() callback may want to call device link APIs.

> Anyway, let me add a get/put_device() here somewhere, to ensure we
> prevent this from happening. I assume that is what you are proposing?

No, an additional device reference count won't protect against other concur=
rent
driver callbacks, such as remove().
