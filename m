Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A772C3368B0
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778145725; cv=none; b=np9HpF6Y2e2fsoWuxO8QhC6mg6Pnf7gHf7WVSY8rtpz/zM5KKqBO5Yt9xNDpz/SF962HwH2ryeiU4M9hQvGIzNWKKn3Le4/UzVN8C5MYGOpozv69QkBg5OAqbAFizZ/Uu6lzjR4NhfC6naVLYcmMEKjoZr3/+TtKmNKsZ62RXIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778145725; c=relaxed/simple;
	bh=IwrNVFKzSRTdZ5JveLi918fTr6rocBDAoIvz3oaLMZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKMwtT7DTivQSxmI5VmX/QldT4TeI7WxDwY715vbpNl/6KgoEP4dhCU65ku3hbdlIb5TYrvhsWaccSGp2MBsXTrDAhoD5N/uomVHgM1/Y3t5uZHEVs0HmvSzVscAH6zwf7gI24l8W62B8C+hUZMhI5yxwlSti73DXx41/OMqrTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56f70865797so343452e0c.1
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 02:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778145714; x=1778750514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlQwLkoJNNdnPrw8knAwIybrcJ+s/HKf8ofWJf6H5hI=;
        b=hnM4MEZ517+VbbNXZVlB+eIXPf4tNNM7LDcrRTOf3i4Dcn2jiX4gZdKK1BhYH2P6mj
         vK/n5PxZnQhHbTYer1pQYmEWrp3AFDbpAAP4kCrbGNOwpCsDwfkKNreeNMomXbVIzMX/
         cQJKVxDWu/wl/qHIcMXVTYUkOTmkD1SZbmA7m4uerudJDQWgOafl64tUervwpWcA2fRE
         JiQsKXK0i72ZVnDXyq46P1eifVqIC/esLT3EoyL22KpXNFICLVUEb3RD2myqYQDKeN+Y
         oJcZ0+vn5IvmvvP0FKQhLstXSZ+QjpVpThZWRGF1FodqX5SUDLtFV1w/vwmPMWHLdKjx
         mwiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9X4VF1WboHaww5+mUe8nAf0mqlSdusb94qRSYY7eWdSKLh5svjiMkVAZ6aCP4eLkCtv9sc0QAxeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoVPpPDzWWc3bMpNOFH4nWIUD/6ZoUdY40g6hsb/lhqvDbfHh8
	UOQO5Js54Zhgc+r5Cb1fFEiZm42PnwGUgRchd03wexFTh/rtVJp10cvpE5PyXCFsb7s=
X-Gm-Gg: AeBDieskrb98oRFZzwz2jJhRk0oyOAWHMk1ArosTjjXz6VWJz3v5gyGmqy/A/eG7Qw9
	mf6YPcNnZXCCKzz6W7sFiPz+Ht7Y8zkKhgQlM/kQLAUMKxHF0mqpwFSaM96Xd6hVNU2CXwUTcVv
	cnhE99H7kQtH21p/E8SNA/J0wjauO4rPzsjw1g8//mBFX5sIlVEWLqvCY1mcFX7CroNH04YyhT7
	4doufB2ciieabXtp9QqeRVRVIWMxCVeuiS44wA/z/MIDjJ+o++juu7YMBHufEQ78E8Hx1TIVBDY
	kFQVm1z22V07uXhwmna/yfRo0hnXMEN6KJjyVhRNRu4Nnw3sL4bHPsb9fLAcJuYbxdvQta8sW5q
	LzwQwayGhdeeRZxR7xAAmKcYId/zSQ9630Gievigw3Jkz+M8QrSuTeMgg/v0y/h9//Jl2uJeJR9
	PUAiSueAT7tuV4SLx3oA4G1XoJ2gsphSNlzGaDXojVWzGJ1qZtLR+JB8kxSC+7PZc+hCFTNmNpE
	zk=
X-Received: by 2002:a05:6122:3208:b0:56e:e80c:bb25 with SMTP id 71dfb90a1353d-5755963576bmr4035982e0c.13.1778145714533;
        Thu, 07 May 2026 02:21:54 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-575585f72c1sm3606144e0c.12.2026.05.07.02.21.52
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 02:21:53 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-57524e52a3dso432898e0c.2
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 02:21:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+bI6osPzZiT0GADtx71HU9UQJV7ZTkkTj69yyhM3R4/u/LmQIKTgrKJT8mwXc8APaqjFSzsGCLfA==@vger.kernel.org
X-Received: by 2002:a05:6122:2a48:b0:56e:f1d2:c3ca with SMTP id
 71dfb90a1353d-5755937cdfamr4080066e0c.2.1778145712572; Thu, 07 May 2026
 02:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772468323.git.geert+renesas@glider.be> <10876b30a8bdb7d1cfcc2f23fb859f2ffea335fe.1772468323.git.geert+renesas@glider.be>
 <20260313215912.GA3415767-robh@kernel.org> <CAMuHMdXFd5Sva4Hu7KufgMfiiF02Z1z+UgLyJH=KYPvch4673Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXFd5Sva4Hu7KufgMfiiF02Z1z+UgLyJH=KYPvch4673Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 May 2026 11:21:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWzBzFEfgQePb6xrEHnAYWFKR7L8OvBJfaAg_VxN+mB6w@mail.gmail.com>
X-Gm-Features: AVHnY4K1hvlIze4Kwir9AQf6-zlk9HJ7JWrXBp9drztoS3rJo0JwuvmBgBmS4rQ
Message-ID: <CAMuHMdWzBzFEfgQePb6xrEHnAYWFKR7L8OvBJfaAg_VxN+mB6w@mail.gmail.com>
Subject: Re: [PATCH 7/7] soc: renesas: Convert to of_machine_get_match()
To: Rob Herring <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Saravana Kannan <saravanak@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ilia Lin <ilia.lin@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 17:35, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, 13 Mar 2026 at 22:59, Rob Herring <robh@kernel.org> wrote:
> > On Mon, Mar 02, 2026 at 05:29:11PM +0100, Geert Uytterhoeven wrote:
> > > Use the of_machine_get_match() helper to avoid accessing of_root
> > > directly, which is planned to become private.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > This is an alternative solution to "[PATCH v2 8/9] soc: renesas: don't
> > > access of_root directly"
> > > https://lore.kernel.org/20260223-soc-of-root-v2-8-b45da45903c8@oss.qualcomm.com
> >
> > Greg applied this, so you'll have to respin on top of that. Next cycle I
> > guess. Unless you get him to revert it.
>
> That was my impression, too, but apparently he skipped that patch.
> So you can still apply this patch, too.

Seems like it fell through the cracks... Will queue in renesas-devel for v7.2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
