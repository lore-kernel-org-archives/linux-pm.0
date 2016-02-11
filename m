From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v1 3/6] power_supply: Add types for USB Type C and PD chargers
Date: Thu, 11 Feb 2016 07:05:20 -0800
Message-ID: <CANLzEktCcUe9cGfSQsRZuF_SB_puqK4czNgETJfa+JCN5gmubw@mail.gmail.com>
References: <1454679181-8949-1-git-send-email-tomeu.vizoso@collabora.com>
	<1454679181-8949-4-git-send-email-tomeu.vizoso@collabora.com>
	<CANLzEktsLH_hMPoaspuP1tZue-HkA3rqY2PbqOPOAOB7qm5+pA@mail.gmail.com>
	<CAAObsKBdtQ0Je4cnU=tQKNgsGRoMJPF9gkSywu+EXH476uXudA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37829 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbcBKPFV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 10:05:21 -0500
Received: by mail-ig0-f179.google.com with SMTP id 5so38253201igt.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Feb 2016 07:05:20 -0800 (PST)
In-Reply-To: <CAAObsKBdtQ0Je4cnU=tQKNgsGRoMJPF9gkSywu+EXH476uXudA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>, =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, Feb 11, 2016 at 2:00 AM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
>> Could you change these to be "USB Power Delivery Port" and "USB PD
>> Dual Role Port"?
>
> I have gone with omitting the USB prefix, following the lead of the
> existing entries, do you agree with that?


Sounds good to me!

Thanks,
Benson

-- 
Benson Leung
Senior Software Engineer, Chrom* OS
bleung@chromium.org
