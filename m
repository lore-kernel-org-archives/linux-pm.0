Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C4325A655;
	Tue,  5 May 2026 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985216; cv=none; b=Wi96lTVb3ZZ4B012HjGVja9kBf4sEbmnqo/zVci9/VmWK1db3Ylm/KoixVlB8+upNVQWX9xumsj59y/7h3qPxh0QvHPCEgzpKCKriV6UZrCJ8acJAasS1LC04AkPYR9hip5ZtZXQ03w5ZZFzR5N907Sp8fPjPm1pPnJ95x3F5PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985216; c=relaxed/simple;
	bh=596sMWZzO6rtiPjU1JWkqiiSWIQcxiR85HlwQ2gSnXg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=RP7LFR9mmt1TX85OyOwManYFUPFc8NkRV3hTS7njxQ5rKQ4lA3cGKQ/g0nDE8UDfCHXo7gGl4Z+iFR3nfpunZb4xylGlkYdwGbZHjQlbngSka6/18MzNTWqyVsSRp6RLnCHwC7T/d/g0HxG9wZ0mpbCHfIhCJcNH291K+XIFuqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbU9ITGb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbU9ITGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EF2C2BCC7;
	Tue,  5 May 2026 12:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777985215;
	bh=596sMWZzO6rtiPjU1JWkqiiSWIQcxiR85HlwQ2gSnXg=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=ZbU9ITGb91UZX09/qUN7UK+C66NqfMP+rt4z3zVV5PRWg6VyC3VUNmo/QH2vkf6E3
	 1CJJFrw42Vj/Nn57WBhZHnqrkCLhUKKYMVqUSa/LGx3QPS40ZWxm+8LUe2/G/j31aI
	 /LnN2J0G5PMTtqnIX2rDri3L4/NDxcLPAxCokN/Fh9PMxN1L5btTgH+oKRxvG6Q/H6
	 goaafdhFwuzeNXSfCPPW9CqFWJFUb+BINS/qdXA1pi6pWqZiyH1fv7/uldf9S4joKq
	 Mll2fB6ZEFBIGARw0FzIlqEafFI3HJLPjoF5gjN3waJKaDUX2ADsdA5NKnhR8Fqtpy
	 du+oNQMpcmAfA==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 May 2026 14:46:49 +0200
Message-Id: <DIAR5LATLBNK.1CSW7AD5VRN77@kernel.org>
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
 <DHZMQLCIRJIS.174HZR6DIAOMM@kernel.org>
 <CAPDyKFoKNpUexGrM0zcysKMKcdYT-cU0_Q_AHbgiGPk_gU-3nA@mail.gmail.com>
In-Reply-To: <CAPDyKFoKNpUexGrM0zcysKMKcdYT-cU0_Q_AHbgiGPk_gU-3nA@mail.gmail.com>

On Tue May 5, 2026 at 1:12 PM CEST, Ulf Hansson wrote:
> On Wed, 22 Apr 2026 at 12:59, Danilo Krummrich <dakr@kernel.org> wrote:
>>
>> On Wed Apr 22, 2026 at 12:07 PM CEST, Ulf Hansson wrote:
>> > On Sat, 18 Apr 2026 at 13:23, Danilo Krummrich <dakr@kernel.org> wrote=
:
>> >> On Fri Apr 10, 2026 at 12:40 PM CEST, Ulf Hansson wrote:
>> >> > @@ -1126,6 +1128,9 @@ static void __device_links_queue_sync_state(s=
truct device *dev,
>> >> >       if (dev->state_synced)
>> >> >               return;
>> >> >
>> >> > +     if (dev->driver && dev->driver->queue_sync_state)
>> >> > +             dev->driver->queue_sync_state(dev);
>> >>
>> >> This seems to be called without the device lock being held, which see=
ms to allow
>> >> the queue_sync_state() callback to execute concurrently with remove()=
. This
>> >> opens the door for all kinds of UAF conditions in drivers.
>> >
>> > If that were the case, this whole function would be unsafe even before
>> > this change. I assume this isn't because of how the function is being
>> > called, but I may be wrong.
>>
>> This function does not issue any driver callbacks intentionally; the exi=
sting
>> sync_state() callback is deferred to device_links_flush_sync_list(), whi=
ch is
>> called without the device_links_write_lock() held, but takes the device_=
lock()
>> to protect against other concurrent driver callbacks, such as remove().
>>
>> I.e. we can't take the device_lock() when the device_links_write_lock() =
is held,
>> as it would be prone to lock inversion.
>
> You are right, the device_lock() is needed in
> device_links_flush_sync_list() to protect against concurrent driver
> callbacks from being invoked, such as the ->remove().
>
> However, as part of the removal procedure in
> __device_release_driver(), we also need to account for device links.
> Hence we call device_links_busy() which takes the
> device_links_write_lock().

I don't think this is sufficient.

I wrapped my head around this about three weeks ago and I think there were
multiple cases where this falls apart. I think one case was:

  1. Consumer binds, supplier is added to deferred_sync. Consumer unbinds,
     link goes to AVAILABLE.

  2. device_links_busy(supplier) takes and releases device_links_write_lock=
(),
     finds no ACTIVE consumers, returns false -- drv->remove() starts witho=
ut
     device_links_write_lock() held.

  3. device_links_supplier_sync_state_resume() takes device_links_write_loc=
k(),
     finds supplier still on deferred_sync -- device_links_driver_cleanup()
     hasn't run yet, blocked on the lock. queue_sync_state() is called
     concurrently with drv->remove().

But again, I think that's what I concluded three weeks ago and this state
machine is rather tricky.

That said, *even if* we could prove that this works in all cases, it would =
be
very subtle, pretty fragile and not by design.

The whole state machine around sync state is already rather complicated. So=
, if
we really want to make it an invariant that it is valid to call bus device
callbacks without holding the device lock from
__device_links_queue_sync_state(), I think this has to be carefully reflect=
ed by
the overall design making it *very explicit* how this invariant holds up in=
 all
cases.

Otherwise, I'd be rather concerned that this becomes a source of subtle bug=
s.
