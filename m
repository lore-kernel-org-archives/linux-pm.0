Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36FD484243
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936065; cv=pass; b=O+XklL1eGntOwUrhg6cjSIsr4IWAhcLKIcV2X0m15p+TemJabFpMQ+ovXSu8LnfDNRDw1epqw4VMO/KCksAGpemQFa9Jivs1jjXK4YyAFfiV2t9e9FgUKRLOEkt93cuIt6Al5zr/6WRTZoQAgTqFxSv4JUw6ylbTFcYVDQs81Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936065; c=relaxed/simple;
	bh=pIfrqYOsttuk4BcoBkatYHzhO60Yrc+sR942QLyGfbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUAKu0AQkKaLzPV229Z+hoCC8vKeipU2eMKXdgBM22S/GivHNiPp2nJplMGLQ4Ix+vcYtYYEiTacv7UZdQ/ER7hWtyiwBkED45xPI+SsPBhFA27XNkHSeLr/G9J4zFxOotJ+6wJzShtdVgU5sZkOnPI6uJ21pwiY+mBo83MvaLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gTt39BcF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iG4GoTEi; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gTt39BcF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iG4GoTEi"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6929naWK1190356
	for <linux-pm@vger.kernel.org>; Fri, 2 Oct 2026 10:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	97tQrA8V1fotLtgnaG3+4FcLpgXpr+0ISXkTd+sa8kE=; b=gTt39BcFNLX7ML3w
	MHVGUYozgYrp53m+cIkXudyla3DkkhIDcBC5GOxak74EnUyfrwqDkygihs5f+2rT
	7KksnIswlaRwt4vRFRsaAoIAsT4YQPGzMrQy/3LodEYu3YQmmImVPySOBUSchLRO
	g9PdBZ56v8vt/cBrrRgiPQEzZI22e079byf8h76+Avp9zkKIs1cwe4xhMoZi8XAI
	u/dTdXbFbypyDnL2+8BAz1jxPdLdPokklz1UrkcjiTycrDbOLWQSdBMJ24tdO0JS
	AP7sAlHjKLTp2YLmuJ6SxnySObd1bvrP9HsOYobtQWnNgjb972bA+Mvyo1j3YR7L
	palIzg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1w8tjm55-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 10:14:22 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a6d30f66c9so814411a91.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 03:14:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790936062; cv=none;
        d=google.com; s=arc-20260327;
        b=H6GAX1OPAx2455d1R+Mhve8BZEapOJWVAISskxD0/2wEDck2DpF9Af1GyqwEzpl/nu
         q8V9rviC1+2QnOWneA9Cwma4wF+kVopQVcBYRH2tVuCZWtYAGo1O4N8/GsoG5aecRjG9
         JCn1gtWioqbPgaraImwTSRBu+TWYtnTdHk8IMsh69dwAO4YuMq/D6nqdlnJ1FqKT6Ij1
         p8/Fh2R0JZoIP+LbKDj6auRh76kZTRU8Y5oSfwFRUoL6U0gkLouUYGb3dnuQeaRMVhAN
         98aKragnoz9MSRZHfjw1h9zwCGWmbCpCl93e3Pef69/bRfSkYjmYcsGeoq0mT1DFSELe
         CUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=97tQrA8V1fotLtgnaG3+4FcLpgXpr+0ISXkTd+sa8kE=;
        fh=r4MziR91t/Ks6ObYbfkeVvTMa/NFLz5zr4ja9kkEQeI=;
        b=ZF26dlsmvxQEGURELagXsrfIK1pamfV8QlB2Z0HzS5RHXy+Z0dydZcin1rOFZ2Gjz5
         5dZXmJAZg1Vf11ePLAXoZId5M0NPoNa8HTFrXEBp8/ZBRn3+cuaZVZYMYasfN3D2zkpB
         1uuuTgpnXy1bUKcmdm7ZNyYCL2AvyCcQPDgpsz6bEMaVwcetb/CEtm+U4Y8yBFRssNHB
         hoLJ58veD44XF8x9weOuhcxfDhmuE8t7JbfzlBwuZjLQIpSi5GdTk5d4flikOoEEZx+p
         ccSkWAYeupP8dTpv4QP9Jlq61kFQ5cTH+9O6ilAEnFXuO0fah8QXoawTITdh6JGtKoSn
         9Xqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790936062; x=1791540862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=97tQrA8V1fotLtgnaG3+4FcLpgXpr+0ISXkTd+sa8kE=;
        b=iG4GoTEif4YYbjzxjF4a3F6+l5x07jnfKkHWsv5rMrSaiNFY/fETqaSNIXuG058R4u
         SuXCq/zkuLBE01P3xfuWBqCfWfUVcLv3TJpV4eTRpuGOCc7VdCXvZAH5BwabiAcu+DHc
         sq4MIE5v84aAp6EicOoxU+6+uNg6McLLk+6IPjlST+DYc2g14ZCzdmUOaes/E0DVSXEo
         BlYYETPaQWo8v+U2xh/AicHOg6NBwuViGpFfJ/vDrOVrxcTlq+dXv6TsZhsYZTvNO9hL
         5GK6xpYV5TzbanjCwKHsibicYWnbLSPGvxztvnEeWMoOgOgCjLVtDbFO4yAvBtH3w56t
         Absw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790936062; x=1791540862;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=97tQrA8V1fotLtgnaG3+4FcLpgXpr+0ISXkTd+sa8kE=;
        b=ZPLTZMdOn4pQmIxVG6WwcIk2C75BZy7GJNVPZZcTB9uT+kzWjrPzHYbUmCK/jzogHq
         36a6rH73jWM8hTmK8KZRSojLEFpry3TT41kclOivnTxVyVmvjGOnbId3WXOBbmEEIFZk
         uDiYMKBf9YlZlM02tO0lnNrCeANHCfhqeSWsEqVTR/0RrF4taC94EVvRGjP/Lq8JvJyx
         iFJIzP5Z3Zpwzu8XsuewoIEcnzhTKK7DDfJAdVAO/mV5/XHF3PjOHnojWl7VlrmwokGV
         RFmH4L/ZQLv5yW3n5atT7G7WnHwWsR5rNZd8x+3KClVy4F8IaGekG86BzT/RBAwtv09b
         iKSg==
X-Forwarded-Encrypted: i=1; AKwUvBwUKkLOo/TiFTKXnO4+LvBkPyJYnLHRZF1WY9WHTDTckIeoE/VvbSRLLZWaGJuuMeHUt21xr91XCA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKmAC5Q1v8uFSUz3essw86IlEs7fKYd1TiFSWnBy18R4FLUEM23
	vH4HXO0t6DTCt0N5t6xVJ+Zp4KqUgvMoVCDt6PTNwhlSmUHcDLJ9e0zPRAx8itFNqXLzumJpef3
	pXc7HNduibF9J/6U2n2Vfb1b6gYHdq4ufCcU9YOLhA3CWxr3naMC+4mXMskWCoeNQpwF8rMadc5
	Do66Yo7AjUkE9g4CiaSdW3sW8auuEXcNQMktqW
X-Gm-Gg: AYBFou0HhAxmYzq6DBhKHEC7Q8iBAK7n2jbWJ1oFOijlWojp4hGiWwYz0O13lYsTX4o
	YUU5dMNcPenRq++Pz5nbVCINE9tTKoY4eFyq4bDth8r+LRAb3ZRN/MjKXxBZV5+qmoVQ/YjqCi7
	SyLhcRMuxz3hryLjfe0dZt89peZ5ysqhXus/ls7ndT6H+Hr2tKL737TqkOiQ==
X-Received: by 2002:a17:90a:fc50:b0:3a0:25f0:d8a0 with SMTP id 98e67ed59e1d1-3a4f3d3b4e0mr3834216a91.55.1790936061803;
        Fri, 02 Oct 2026 03:14:21 -0700 (PDT)
X-Received: by 2002:a17:90a:fc50:b0:3a0:25f0:d8a0 with SMTP id
 98e67ed59e1d1-3a4f3d3b4e0mr3834178a91.55.1790936061253; Fri, 02 Oct 2026
 03:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com>
 <20260626-clk-sync-state-v1-1-4156d8196dc8@redhat.com> <CACRMN=dAxriWU7Age3g9o_d6zyz8hj2p76vHXJSs7sCFxSwuWw@mail.gmail.com>
In-Reply-To: <CACRMN=dAxriWU7Age3g9o_d6zyz8hj2p76vHXJSs7sCFxSwuWw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 12:14:09 +0200
X-Gm-Features: AclHuK-oEMz6OlcHzwlSg3p_f2RJdDM8dmJ8MqNGv6f5-pC6qfJBs-GdohGXbU8
Message-ID: <CAPx+jO_byttA+b-Z+zNyPa0-zXvjCU8hv_AsSjCmBDWEEkSE0A@mail.gmail.com>
Subject: Re: [PATCH 1/4] driver: core: introduce dev_add_sync_state()
To: Saravana Kannan <saravanak@kernel.org>
Cc: Brian Masney <bmasney@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Xuyang Dong <dongxuyang@eswincomputing.com>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Maxime Ripard <mripard@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: FzEFMCD2ky9syYadh5wukcTIxZZ7iS4n
X-Authority-Analysis: v=2.4 cv=ML/1C8Zl c=1 sm=1 tr=0 ts=6abf83fe cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=aupEIk04F7la7JYrT74A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA0MCBTYWx0ZWRfX0PcCdrlYKSSp
 1NvQvQhShZGxLHoYLLzQIIR8o/t+OIo3MX4CXNQscUdnuMyAyMNr5Dq9DUu7L3wqahOLfKMNTaG
 taNZqQrOs8dTshkRrILXVRP6C/3oVgdv9JzrjP3mURcTThBoQXcITBemx8TIwD6Tqn4qWUyNsVY
 pa11I7pTaM1DV5LyK8+SOGIq3QBnwt/ZsHRIWjRApu+Y0rwuAwAOiXsyaOT1aeAfNBqCVK9KycU
 buVDeCboeKBWgM4sKdIEKN8710aaawnIW/JEPKLw9EvC6yDONTFsmXhtVopAKQxitNeUQJF4Ash
 kXEqQ/gLFK4GGr5+bIc8ZdsY8Jna1ZrJTX4XJndRrmk5MqBURyeAgaQYOg37Az7tmr5xoh8+Hyd
 PEQFhGTvTZqFIbCJFL7tWSXIQh9vVozj3M/HISjLg/hiX3iR21UXyV+N7dx2QuSu1gWYCiYhQDX
 JqygmgeGROeon4/NAiA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA0MCBTYWx0ZWRfX0UR8fI5B6c6u
 Z7U0YpgIAVDZfT6pXEnbcuRddbjvn2yu2Ov5Pi+eUWqSbfnah+emGma0LvZiwJbvG2fYJZemBpw
 UBifOjlfa6I8ODKtrJj/7YqAUHj+uGI=
X-Proofpoint-ORIG-GUID: FzEFMCD2ky9syYadh5wukcTIxZZ7iS4n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020040

On Thu, Sep 24, 2026 at 9:30=E2=80=AFAM Saravana Kannan <saravanak@kernel.o=
rg> wrote:
>
> On Fri, Jun 26, 2026 at 9:33=E2=80=AFAM Brian Masney <bmasney@redhat.com>=
 wrote:
> >
> > We have cases where a device node represents a provider for multiple
> > types of resources, like clocks, power-domains, resets, etc. We
> > currently have dev_set_drv_sync_state() where a framework or driver
> > can set the sync_state callback for a device node, however it currently
> > only supports a single sync_state callback.
> >
> > The pmdomain subsystem currently sets up a sync_state callback in the
> > core framework, and the clk subsystem will setup it's own separate
> > sync_state callback in the core framework. These can collide with each
> > other on some types of devices that have multiple types of resources.
> > Additionally, some clk drivers already have their own separate
> > sync_state callback already defined.
> >
> > Let's introduce support for allowing drivers and frameworks to add thei=
r
> > own sync_state callback via a new function dev_add_sync_state() so that
> > multiple sync_state callbacks can coexist.
>
> I had already thought about this scenario when I implemented the
> framework. Your driver should just set its sync_state() callback and
> that my_drv_sync_state() will simply call the sync state helper
> functions provided by the relevant frameworks.

That would work, but would require all drivers to assign the
->sync_state() callbacks themselves. The core of each subsystem will
therefore not be able to help much, except for providing the helper
functions.

I can imagine a lot of boilerplate code, but perhaps the flexibility
is worth it.

Also note that, we need to address the situation where a child node
acts as the provider, but doesn't have a populated device for it.

>
> This link list is adding a lot of code without any clear benefit. And
> it also doesn't work for drivers that might care for a particular
> sequence of framework sync_state() callbacks. Instead your are forced
> to follow whatever order in which the frameworks are adding the sync
> state callbacks to your device.

Right, if the order is important, the "parent" driver would need to
control the order for how providers are registered. Yet, I think they
already need to do that (if it's important), although for other
reasons.

>
> I don't think this patch is a good idea.

You may very well be right, but I think we need to discuss it a bit
more. Let's chat at LPC next week.

>
> -Saravana

Kind regards
Uffe

>
> >
> > Link: https://lore.kernel.org/linux-clk/CAPx+jO9JiV16ePLk59hTQzEMnA96Va=
6Ns4jqJbwyZ6oTT0AjXA@mail.gmail.com/
> > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > Assisted-by: Claude:claude-opus-4-6
> > ---
> >  drivers/base/base.h    |  7 +++++++
> >  drivers/base/core.c    | 29 +++++++++++++++++++++++++++++
> >  include/linux/device.h | 11 +++++++++++
> >  3 files changed, 47 insertions(+)
> >
> > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > index a5b7abc10ff0..339db4afbeb4 100644
> > --- a/drivers/base/base.h
> > +++ b/drivers/base/base.h
> > @@ -178,6 +178,8 @@ static inline bool dev_has_sync_state(struct device=
 *dev)
> >
> >         if (!dev)
> >                 return false;
> > +       if (!list_empty(&dev->sync_state_list))
> > +               return true;
> >         drv =3D READ_ONCE(dev->driver);
> >         if (drv && drv->sync_state)
> >                 return true;
> > @@ -188,10 +190,15 @@ static inline bool dev_has_sync_state(struct devi=
ce *dev)
> >
> >  static inline void dev_sync_state(struct device *dev)
> >  {
> > +       struct sync_state_entry *entry;
> > +
> >         if (dev->bus->sync_state)
> >                 dev->bus->sync_state(dev);
> >         else if (dev->driver && dev->driver->sync_state)
> >                 dev->driver->sync_state(dev);
> > +
> > +       list_for_each_entry(entry, &dev->sync_state_list, node)
> > +               entry->fn(dev);
> >  }
> >
> >  int driver_add_groups(const struct device_driver *drv,
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 4d026682944f..acc12f402dd3 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2612,6 +2612,7 @@ EXPORT_SYMBOL_GPL(device_show_string);
> >  static void device_release(struct kobject *kobj)
> >  {
> >         struct device *dev =3D kobj_to_dev(kobj);
> > +       struct sync_state_entry *entry, *tmp;
> >         struct device_private *p =3D dev->p;
> >
> >         /*
> > @@ -2625,6 +2626,11 @@ static void device_release(struct kobject *kobj)
> >          */
> >         devres_release_all(dev);
> >
> > +       list_for_each_entry_safe(entry, tmp, &dev->sync_state_list, nod=
e) {
> > +               list_del(&entry->node);
> > +               kfree(entry);
> > +       }
> > +
> >         kfree(dev->dma_range_map);
> >         kfree(dev->driver_override.name);
> >
> > @@ -3239,12 +3245,35 @@ void device_initialize(struct device *dev)
> >         INIT_LIST_HEAD(&dev->links.consumers);
> >         INIT_LIST_HEAD(&dev->links.suppliers);
> >         INIT_LIST_HEAD(&dev->links.defer_sync);
> > +       INIT_LIST_HEAD(&dev->sync_state_list);
> >         dev->links.status =3D DL_DEV_NO_DRIVER;
> >         dev_assign_dma_coherent(dev, dma_default_coherent);
> >         swiotlb_dev_init(dev);
> >  }
> >  EXPORT_SYMBOL_GPL(device_initialize);
> >
> > +int dev_add_sync_state(struct device *dev,
> > +                          void (*fn)(struct device *dev))
> > +{
> > +       struct sync_state_entry *entry;
> > +
> > +       if (!dev || !dev->driver)
> > +               return 0;
> > +
> > +       list_for_each_entry(entry, &dev->sync_state_list, node)
> > +               if (entry->fn =3D=3D fn)
> > +                       return 0;
> > +
> > +       entry =3D kmalloc_obj(*entry);
> > +       if (!entry)
> > +               return -ENOMEM;
> > +
> > +       entry->fn =3D fn;
> > +       list_add_tail(&entry->node, &dev->sync_state_list);
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(dev_add_sync_state);
> > +
> >  struct kobject *virtual_device_parent(void)
> >  {
> >         static struct kobject *virtual_dir =3D NULL;
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 7b2baffdd2f5..b7a3dd4b56ed 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -642,6 +642,8 @@ enum struct_device_flags {
> >   * @driver_override: Driver name to force a match.  Do not touch direc=
tly; use
> >   *                  device_set_driver_override() instead.
> >   * @links:     Links to suppliers and consumers of this device.
> > + * @sync_state_list: List of sync_state callbacks added by subsystem
> > + *             frameworks (e.g. clk, genpd) via dev_add_sync_state().
> >   * @power:     For device power management.
> >   *             See Documentation/driver-api/pm/devices.rst for details=
.
> >   * @pm_domain: Provide callbacks that are executed during system suspe=
nd,
> > @@ -723,6 +725,7 @@ struct device {
> >                                          */
> >
> >         struct dev_links_info   links;
> > +       struct list_head        sync_state_list;
> >         struct dev_pm_info      power;
> >         struct dev_pm_domain    *pm_domain;
> >
> > @@ -1137,6 +1140,14 @@ static inline int dev_set_drv_sync_state(struct =
device *dev,
> >         return 0;
> >  }
> >
> > +struct sync_state_entry {
> > +       struct list_head        node;
> > +       void                    (*fn)(struct device *dev);
> > +};
> > +
> > +int dev_add_sync_state(struct device *dev,
> > +                          void (*fn)(struct device *dev));
> > +
> >  static inline void dev_set_removable(struct device *dev,
> >                                      enum device_removable removable)
> >  {
> >
> > --
> > 2.54.0
> >
