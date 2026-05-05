Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1E7425CC4
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979606; cv=pass; b=qFUegOcSJOaJ5iXW8DtgMRYcwUKl4rZOHGTqCpeB6R3Q2JMzs4zfxWVp7vP7yLfksD14GwvtC7W4I13eTD1UeaCd0DEw+otD8HcJK3mP/IMHQFBPcjCCGXSG2/zpl2GHSLyHJhGVWgHQJcG0T9TEgtxclRxCknmufefvGGrpBjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979606; c=relaxed/simple;
	bh=Os9gwDsHZQMlqqIBFGdN3USXXITiLKFrWc3TuCSD3Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEOdAuXG0oaIt+1PEWZCzwPQo714lG/4MpYHKS+QQRkJnS+ECKDN4BTiFDOtotPxYPcnBqM1Yh0NuJvRlNghLUuBK1mVNYlbEaqBo4PvnOsSESmhan7PrIs/MxK1lijaTOR23BtpPJsKv2Wvkw1wRFR21zBmSvDyOIAC65cJFBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A6D0WZE0; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A6D0WZE0"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a858881ad2so5204112e87.3
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 04:13:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777979602; cv=none;
        d=google.com; s=arc-20240605;
        b=M0c8FY1rMU4bxWetVSY3D9RWExkAyMVbeeMJD65I6DGZQkhFsPMbuzToY42mKXSKEX
         HwsR+DxRtrFi2WeCRfZ6Tcq9AZHlWDs+CXgasw6KwgZ4/zkjC6p0o+0Cxgs/sGPYNJ1q
         4wD/HWsz+2EKHQwTrIjg4XwnXwtSuDRGRe7dopVk86isvzjy0tBvFNy7EKFQfnwJKq17
         YRFxyj82XKY/Im+MMgfpesMXef0J68/C3+xtR7sDWkHIrcnj8dICboMMxj7IuJOz+Omz
         FlG1S6K7xdw0YJ7e7bSGRFgTz3LqP1BbDkPITLtyoRAGfivXIR4oIhV/Dxs2JgEIxHk0
         4O7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vHtD1aX9zPxNRjWtqJ4oSWNxhaYMbBh5QHVWQYJquis=;
        fh=aXzj/2ocbJnF3FDTlWAypQPP9qUcN3a5CWJLsAhN5Dk=;
        b=KsKZqSsY6J202n/wThFMboTkbmEHnWnHwVvFUe3JGEB1CJgPq/yszXmrW14GIQs/37
         uu6Y15+9p4avyMojtBfH9qmHFiyeeMB0xmr6vydvb3NMw8uNnhnv9k+v+3cVjWLXFwd1
         fspD8g8EaRBPSpwPS568S+VjoPVVuiE/KmqAiHR6f5Bb4gMqHAhqwzhyCKmNgzb1Fb4+
         FF1XBnEz6tWGqcl0hKdZZ81fYjNW/lkcPXk3CG+2tNvUEohTKxtAKclnP5gDaip6+QrU
         gpwS2c2OpO30FmYYwlL5LmNsYp/p6P1yzWQXp05XMpGpqqLo5x3CBJY5S00vPNrB0xRn
         ryhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777979602; x=1778584402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vHtD1aX9zPxNRjWtqJ4oSWNxhaYMbBh5QHVWQYJquis=;
        b=A6D0WZE0OCPCIlByA/bi5yakb5qNNPXDnateBUUw6PEoKyG/F/jhl9/lGZc5NAHzok
         5mnyqqniLR50eLc6XY6AVxL43d7j2GcjsxguHvSWlD4ysCK2ku8gj6E4ERbuP7cHSCQW
         Z9P/eKb63L7IGzGqq/nfZCKj+LLuURIb/hGFOCS4mFMhFe1sG0MF0+IZWTyCAVymlKB9
         tRL9O7qdtQSuapZreeKWK2fefEyCtB6RiR9I7elZDWuN/OVSIzsg4UfXqJdvi/2qusCV
         9SivwGAhb+5qcYa63VXXcRJVRTtVSo2zoqogUiCS4TM7tPiXH5/Dz2ylL7znmbgO2aHc
         EbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777979602; x=1778584402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHtD1aX9zPxNRjWtqJ4oSWNxhaYMbBh5QHVWQYJquis=;
        b=JpxuVSyTbsg4l0EobKIpTYfm3ukfYGnrui7EcUj198gQwL8EsDdAuIfaLSLi8bfCYZ
         4RUb4FcmInYOW5U9NF+Du1Spl7hYozubebiq6KV6irzT2i/hiA+Q3JbpGLlsDPGJPLBf
         JfVzJXqHAgVH422wBPCMRFFjUw0Zh5CNVEKmF0N0JhiWWZrVrpUxcSI5Jvk8lrZmTaov
         hmujvncyPcNM55Ikt5/rKX+q7kRrqdohKa0d57IYpw3CSVCsKKuZizxpB5Hbzzh3AOAV
         FjQE2WkRnGLU8gftKSr14a5hpzeJzLMccf9KvXjvGniWsrtwMSQswYqFn+dBt+DcMukC
         iHmQ==
X-Forwarded-Encrypted: i=1; AFNElJ9XeUEuCgIqKdBTHZb5f9woWmUk94H6pxdGei90c5Q/KC7bOcUMZxtEhrm2dw5Ac8Qt1zWLkJV/Mg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9yvUgBeW3mYksx5MDMSp/m45Wc3y5E49PeOiZY7fx6834iiGu
	P9mWdx2fnAZuOZWQ7OYqiuNt/pLyf/ceTv7AbspLhKH+J5vaRnEX7X44OsDe1FbBtBA//QXkvXH
	UyErXtP4vduQY5JOC6fjdsPdPEvLL4IOY0xrTSpq+6g==
X-Gm-Gg: AeBDieuJ5OScx5GxXIJtCK33mxkLR8UwSaNQf6FAsU6Z1OIAfjUF/3F5u5+JV2rwdkP
	df8N6dqHroxoFbadGQ5AyzTMX2vdYp5uM3R7TAO9R2YyLew4G7Em5YEfNItqQMCejv+IGy8jxpX
	IKI1Y9acZ8oGN3dX7MgMyq9kDF+/HrJoa4XLyVzIBMXjOUvQOZsLhJ4a6CBjPHaol2UeE6XPEAg
	p//B05t+D9szYUdR3/ZMQNdGtPn1RW9O75ydBLfq6cG3l+ElF/SczXvKxkAdJVHJ8u28og66NxF
	ui0/yIqxmtvm1ZChDzU=
X-Received: by 2002:a05:6512:1255:b0:5a8:6b81:6694 with SMTP id
 2adb3069b0e04-5a86b8167c7mr5154556e87.30.1777979602140; Tue, 05 May 2026
 04:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410104058.83748-1-ulf.hansson@linaro.org>
 <20260410104058.83748-2-ulf.hansson@linaro.org> <DHW8QPU1VU1F.3P6PH69HLFBYC@kernel.org>
 <CAPDyKFqMDPiqvqJrq5Qs6Tw4Sc7szG4G-=y0NFkNSPoNd9kdVA@mail.gmail.com> <DHZMQLCIRJIS.174HZR6DIAOMM@kernel.org>
In-Reply-To: <DHZMQLCIRJIS.174HZR6DIAOMM@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 5 May 2026 13:12:45 +0200
X-Gm-Features: AVHnY4LlCgMgAkU1pCqSb5NGsrhZtKGgNNx2kcRO5ejJAWo_ZbIw6N5C10vsCeg
Message-ID: <CAPDyKFoKNpUexGrM0zcysKMKcdYT-cU0_Q_AHbgiGPk_gU-3nA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] driver core: Enable suppliers to implement fine
 grained sync_state support
To: Danilo Krummrich <dakr@kernel.org>
Cc: Saravana Kannan <saravanak@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026 at 12:59, Danilo Krummrich <dakr@kernel.org> wrote:
>
> On Wed Apr 22, 2026 at 12:07 PM CEST, Ulf Hansson wrote:
> > On Sat, 18 Apr 2026 at 13:23, Danilo Krummrich <dakr@kernel.org> wrote:
> >> On Fri Apr 10, 2026 at 12:40 PM CEST, Ulf Hansson wrote:
> >> > @@ -1126,6 +1128,9 @@ static void __device_links_queue_sync_state(struct device *dev,
> >> >       if (dev->state_synced)
> >> >               return;
> >> >
> >> > +     if (dev->driver && dev->driver->queue_sync_state)
> >> > +             dev->driver->queue_sync_state(dev);
> >>
> >> This seems to be called without the device lock being held, which seems to allow
> >> the queue_sync_state() callback to execute concurrently with remove(). This
> >> opens the door for all kinds of UAF conditions in drivers.
> >
> > If that were the case, this whole function would be unsafe even before
> > this change. I assume this isn't because of how the function is being
> > called, but I may be wrong.
>
> This function does not issue any driver callbacks intentionally; the existing
> sync_state() callback is deferred to device_links_flush_sync_list(), which is
> called without the device_links_write_lock() held, but takes the device_lock()
> to protect against other concurrent driver callbacks, such as remove().
>
> I.e. we can't take the device_lock() when the device_links_write_lock() is held,
> as it would be prone to lock inversion.

You are right, the device_lock() is needed in
device_links_flush_sync_list() to protect against concurrent driver
callbacks from being invoked, such as the ->remove().

However, as part of the removal procedure in
__device_release_driver(), we also need to account for device links.
Hence we call device_links_busy() which takes the
device_links_write_lock().

>
> The documentation of __device_links_queue_sync_state() actually slightly hints
> at this, but focuses more on the other reason for the deferred semantics -- the
> sync_state() callback may want to call device link APIs.
>
> > Anyway, let me add a get/put_device() here somewhere, to ensure we
> > prevent this from happening. I assume that is what you are proposing?
>
> No, an additional device reference count won't protect against other concurrent
> driver callbacks, such as remove().

Because _device_links_queue_sync_state() is always called while
holding the device_links_write_lock(), it I believe it should be
perfectly safe to invoke the driver callbacks from there.

Kind regards
Uffe
