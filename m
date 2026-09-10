Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B153C09EF
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029467; cv=pass; b=m2J+INaJWtHmLHvhP3nEhGMEhujr0fA50LFl0PLrQqMsrp8YJhjikL2PgATxT77pJogZTNFXS/+QRm9DXXs1GlnR9H1HlkEkxr8vdEvvKRGlsm4gygSVm1yHA5is/8RSGg23TENXpQU9m7sXHmlKCNoLK5eUOmorKa03B55KEg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029467; c=relaxed/simple;
	bh=sc9Cfq2daynLd+xZRF9G1RrBj/E/QZge6eVGxMNfuTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtpXbqry0exQlXznEbCfb+QbKcErPTS7aOnhIPtBGFeRMKJHJ3U8pnWpEgbrtX53/dbUwxX0B0ZzvX9e6//VtS3MTkbZ2H+M3zFbzH8uqXYuJuFNpnYUk2P8nFGBxCdzkkERYXPX4PQfsjwkAxjLqcwnrRt0UeqqDbbQcOXDjLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G6wfuOD0; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G6wfuOD0"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482ea739de2so4602754f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 01:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789029464; cv=none;
        d=google.com; s=arc-20260327;
        b=ZSMP1h/tjeo40mCSOt8HS+xyh8kyw6kZgM7YzvU+SxEgN5HJkSahXVl4TyINrpPOjb
         A6F7DkPtw5KXylnrE99WzkLRnORbg+Kq72shnnt3Q5CVLovirYBfgqW/WXolbdCtH8BD
         ha32OV5NXTKKRYK/YK1Xz9LhAdku4Zu6fQTLmSX4QcDoH+U3N745SrMfNcRJYlit50/Q
         ULI9ErKu9MOZ4agXKKRspLmmYELjXhqxFFBXx3J7DdI8vVe2gGNlngQuxBX4QIrlkKTM
         zRKevSllpS07XMCsGgLhTxU4HuH/gFVeS1EsjhlPS5FRSf7TIFxNODM/x5z+/uOMrO6X
         Qv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sc9Cfq2daynLd+xZRF9G1RrBj/E/QZge6eVGxMNfuTE=;
        fh=l/8pBu1gAZvKgoN9qHOhvTQWPAQny/rcgOWG8KfFxyw=;
        b=ZgiTM9RM9hqhodXYQzzS/Ohjg36bmmVBgTG7AyuWlQkszBJtb3CEmxlclzvJvgzeEU
         3AxkaDE4CShJmI+czq9i2r1fKxCViy44ORHaW9GDmUDGlGD9Mm6I4wdNU+hq1wHUOP8C
         Cnk1eq/1lM4XFb2qBhhFv3H4eMa7VFfXXTyQ00PnejWoeIlVuVhShfplob7FMqhRbS3A
         0Yjlwap50H6lHlVEGRPx6z3P7eW7Rk0wjNAOhgr4Q2IbwjeikBEqEhFcEcp+oY7mkQYp
         mp/J0TWxIOm2VqjVV1dOdc9pD5os1zE3nPLnkqodliJzgWe23q/fi0ulcd6Ndz1zEvkn
         7PVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789029464; x=1789634264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sc9Cfq2daynLd+xZRF9G1RrBj/E/QZge6eVGxMNfuTE=;
        b=G6wfuOD0GgeSMycPWzGkHC6pJtjh6k5UX+pJJaUn7LNZCxmKnblfjv6WmAsa3lnO1G
         NUCu27CyARa2+vMNtiHi6Jqw8CghBJmYYQSG6//H7GoFIoZGOXVMKubWcCOjQFLaIbrO
         gBCgKrDIE4Oafj64U9IhhNsbnYT8omxsKaMFb9a3mRPevZV34O7OHKjaiSqottHQ+Drb
         XKQ3fII+JTYuM1DvCSLzAxUhdbQPWmNkPPvEW/zyuvtXoRZmVcGu6SYXuQTLnkEPhAb6
         ioC9FP0WspoMVvQ8rTZbhHqStKmVJTRe0Nrq5OkLkixS85uDCUGZZZ8y7w1a9QQ71rFb
         hB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789029464; x=1789634264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sc9Cfq2daynLd+xZRF9G1RrBj/E/QZge6eVGxMNfuTE=;
        b=Ws/KsFeM6TDqQWImmCm3oynAftt0VjGiotDKeG1n3ePhkJAr8oRbY7dnQMjL4AWiEQ
         NWL/m5H/0XaJSXwpJmGOmlH16A8xBZ+8BQ4u2jcYGsFWjpnnxaTCXeThNl28V0s8LP3S
         IrMsmsySsLPg+PJ389ueFN5zZk7mNU77lIc46oB5H2XznAY8g/pLjDZFl/9cFbn6iiDV
         e/Ip4B7wy/bVLt8txOm4bFXtn/6FkTVjIYhSkQ8D6n2X6Li3wct2OBQuFkw5grjA+1ax
         fUm0/wlovYchZVj1bBkG30j329SLvbCWLYUUlo59gkmED6A2xjzQZoNrwkvf5o/XHIQK
         rdgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRAq0ijFX07L9gT1/FA4BHInU+fXYXaD/lO4Sqw+/QXYEyj7ltr2sVSuFArcUvJ55NSMrcoHLyxg==@vger.kernel.org
X-Gm-Message-State: AFuF++kWwbcqdctGClUmRj11s6/DkA0kQeWtq9odUrFM7e6/KFCG2Ww9
	T8+SMkWKuLrNDtOPmsfJ2d9QzkG5123IgN2OeaSzypIGHzso200icBxT93edKJx/gZ7L+RSpHNw
	6opGCGy74DsJYYmTzGElNG0XWWc/xbc7p01rmpHVN
X-Gm-Gg: AYBFou1PBG14Zyp4a1mj/9DF5h5lY6GGjBQp87MTfaDiV3gPr1fRzWxjCShiE80vklJ
	Sas5ufLfNP4DV4eTR7LLo2uJCWKjPtcMcpabDVVsRTbGJQjwtB/uoI3n44er+3XOBJNtA8pMVSU
	4Ik4QSkYlfiPMpyDXh4x8AnLOqZ92Egk4y2rO9VdiKkqG3yow5ujok8S3uznWJRVvIl2r6suLDb
	mnqzCbz4MmfhWQCxnfnmCUbBzNd1wkyb0LxkIs97yCeUz9cGqTnPqAd4L8hBYxxTuAvzzIs1iwY
	YNMKJ4H/ZfEJhCvHQ9vhtzkvok+SAeYx9fqc/WN4G6o3MYh904LEzIbIYyHi3TZoIq10Gw2PnqN
	z2EaHkllW6Mg9jG2/F+zt
X-Received: by 2002:a05:6000:4a16:b0:485:8c16:a361 with SMTP id
 ffacd0b85a97d-4858c16a757mr37879090f8f.57.1789029463048; Thu, 10 Sep 2026
 01:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826131213.1820408-1-beata.michalska@arm.com>
 <20260826131213.1820408-2-beata.michalska@arm.com> <aqEox8rYYBcfxtrN@google.com>
 <aqJqICNMitP3JTJw@arm.com>
In-Reply-To: <aqJqICNMitP3JTJw@arm.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 10 Sep 2026 10:37:30 +0200
X-Gm-Features: AcwNN1XzpH-G7K26BQl6iCpALzC0tIsAPD3Utlt434iR5Pwrv8_DVtOsPo8QrAM
Message-ID: <CAH5fLgjWcO5fTn3fRwdt8Zh8U+AubtHfVuNOUCnm0U8HjJe61g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rust: add runtime PM support
To: Beata Michalska <beata.michalska@arm.com>
Cc: ojeda@kernel.org, dakr@kernel.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, daniel.almeida@collabora.com, 
	boris.brezillon@collabora.com, work@onurozkan.dev, samitolvanen@google.com, 
	acourbot@nvidia.com, rust-for-linux@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 10:28=E2=80=AFAM Beata Michalska
<beata.michalska@arm.com> wrote:
>
> On Wed, Sep 09, 2026 at 09:37:11AM +0000, Alice Ryhl wrote:
> > On Wed, Aug 26, 2026 at 03:10:55PM +0200, Beata Michalska wrote:
> > > +/// Result type returned by runtime PM callbacks.
> > > +pub type PMCallbackResult<T> =3D Result<Option<T>, (Option<T>, Error=
)>;
> >
> > So I think my number one feedback is that it would be really nice to ge=
t
> > rid of this Option.
> Guess this can be done. And I'm assuming that's for both Options here (?)

Yeah. I'm thinking that one approach could be to use the AtomicFlag to
track whether a value is stored in the container, and possible change
the Option to ManuallyDrop. Then in drop of that type, you check the
AtomicFlag and only if it's false you drop the value. That way, you
can take the value in/out of the ManuallyDrop so that you can transfer
ownership to/from the storage.

Alice
