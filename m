Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C813803E1
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632252; cv=pass; b=Jn5wdS5XCN8USbwh6Rm9OQSu2w+YGpbsa5fuVJgu15MuoaIfvdT+wiq5N4heG6Cvjfc9EZLRG8CGUmepJn+cKjqj6wLChawlIMYPDhr6j3fgSuKH9Zdh/+mfZewWWMl7gdKnRrJLhuB75q4jH+U0J8M5CbYQDfCCreCdPuO8DnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632252; c=relaxed/simple;
	bh=0x2rC6YyzM4qZO1HXSbco3HVN0nNJF+d9uhI0gpoN6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMMkzKuB7lHY5a39ysfOv37EC7gOu04hwRE8OUJuB25LfPXDZaGoYate/EnBKfPJ5vWlq9VLTO5iF8XrRxf4bUhza3m4i3c3GCXIYfSxzFK4qYmnJ/R4d2XNjO8OsCmY8gu10IWUSs91s0czVzXK30OG9q+u4d2jm4ig6jBGEBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hk7YqMfD; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk7YqMfD"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c01089e8aso56596831cf.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 04:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784632250; cv=none;
        d=google.com; s=arc-20260327;
        b=r4liRntDT7dDrWjmBVzSk77Azz3T7WRZcYZ08OFU7kDyjrbEHvCWU625DX1NBD/n4X
         yaytEVK34NyXE919aqYnKOjpSp09l+YgWau5tFgIzBN2CidjgVL4uPUzty8VVz8zyZBM
         EiHmNphw4GtxR6KM0TYPYXwlGdhRzQ5BUnCDxAAhg+459Y8nsbnA32zuFNHcg9NpHYWz
         mZD6vwZTIqcwVIO4l9ZoVCpagdz4i91ZamkLjfQOW7HBeG2Ovd0aM3GzqpzoUCH5Y1Gj
         ORRupT+//sk6TeowK7eekq3WHv16KUPcP/QY1FFwjwK4mP2jsb5UaClpMBTZeignbXf8
         lthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0x2rC6YyzM4qZO1HXSbco3HVN0nNJF+d9uhI0gpoN6w=;
        fh=F2CEO508c31Enh+9Ty2kbvEOoXIGw8uT4LkbTk070kM=;
        b=dt/KJ6aMq49FYjokNe0WKZj9K2jEf2G+Zd2KimrFOtZhPwhkFbVz1OE0pUFvRi3ktF
         hKn8exuAnQ9o6rGXkK6GOFqj346mDuBzkRR9Qeup6K97KHO3xSJMXJurcOy8IMHSHBx8
         Swv8+kCjuW71vlmshmcYCDBs9vV3TWLimMVyZHNxFQxOsZhyaLZ8gxoY584+M0mvQnGI
         4ZgjcZO6lzQpmJvd3meNoplWiQa8U8tLLKWcte/PI90qQ6eMCyeCHlVSOLBgCQnUquk4
         vsZYH/Dz4ehNASc8k1KCY2sh4caO1PmjHos4K3jW1ONmRxmGfM+88qoNjKbErlQFjP29
         JeuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784632250; x=1785237050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0x2rC6YyzM4qZO1HXSbco3HVN0nNJF+d9uhI0gpoN6w=;
        b=Hk7YqMfDthISNvGsG+9KOpgALMQETizWDq+mv8lJ/62B9O1E1o4ovsE/EIH5JWgnMl
         OuGlNYHcWl98zGZgJXFnUrSySNKVV/qBFxSYAsu1Uhcu6lDhUn+uK97+wVNq8n8C3Iai
         8wth3z+MCznfbycNWeQf7QyBIDNfqncFVnTIwNhwAUhc+EpJwb8MCjuHDr9ClphLgfMt
         SARgKbqAFrYO6k0f/r8xpEnsVvfwP1l0eA/f4P3xFTQpFi0Ow4lYia/0U/Gdk+toAMIg
         TLxSjPziOBDPgMFRs+Rvexch/N3/nYE8X9tbdOV2tyoNRQU+gtah2H+do1dUIrpJQhIo
         19yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784632250; x=1785237050;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0x2rC6YyzM4qZO1HXSbco3HVN0nNJF+d9uhI0gpoN6w=;
        b=melBs4MKxTLUiejAWKsxb1zsezQ247ccCMksTJPT/DcjwCJ3ZoyzZl5h3GxKqvv/IM
         3OuJUTjbmiBSiHsBeF5PP/YEu2ecILVZ4GebPxQpx3GYA70dXg5Rx3/7UtEU1WuqrmC0
         SyWCAJ32NwzPowHYedELENCddIMO39RS5XsgJLdjYU4oME/7HEhr/CVusIaeI4AZ6tgz
         FiZv2VWfgFCP/BH9bh0l3wwh/IjHMvCz77sxgZu3Bbsda72LLdmKgP6495VNen0j1AdB
         DtcpEI1FUE4qxdCvCgesyq+GWCXv4C1iJSi6/X35wi1ovyADAfITaK7LM/o6kiXK/tZe
         qzvg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0yi5Vd32ctwmzXbywTwckXtWc1UbMVgZ1zpbr9jsoMKGpP5bQ/hC2neNcqyEoLpc1S3iD7LwBUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuI24UGlXB28y2oL+dTmhjrYOo6Vv7O8yHK0h5oL8C6iPioy3r
	Ernuh6iepZai3lqnuwcSDjdVtoZzxZnNrjQPoN3nOPuls9PKyvnHO+6ftAlKgfmqAeEdsv6pEPF
	yk4JqlTRZY4IvSG20cMPaQADCjV0EHKxOcG+r
X-Gm-Gg: AfdE7cnZk+hq64wbSOSWZxdILbFxUMBzTm7n5kZQVesecS0DpbyShZJX5e8rblI5JAM
	8r9jC/TSCZgLUL/HE8ibfLbzCTSEkQoGUz0HjP486oAqnO/KO2v7zv7R+2JMIp9yRHwZ4HKnvtz
	YvwjWoktdCpclUjqEL1xD6+BCnkqkgCPyNkwGUbDfh7xY9Dz6Z4124GPSm1RYlS2AT6wtXrqywI
	bKT+e3ZLSdWdqG5TOOM0XI3+u1JlfMhq2/O77Dzxhm1hR6GRcbxdRJ3kj0n+tg=
X-Received: by 2002:a05:622a:941:20b0:527:61:b4e3 with SMTP id
 d75a77b69052e-5270061b9c8mr5319821cf.67.1784632249707; Tue, 21 Jul 2026
 04:10:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710082447.5160-1-xuewen.yan@unisoc.com> <alSVBRoPnyVHLcEJ@infradead.org>
In-Reply-To: <alSVBRoPnyVHLcEJ@infradead.org>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 21 Jul 2026 19:10:38 +0800
X-Gm-Features: AUfX_myxTt_MMMoz_5mYwgjeXlrGN79JbNYZS3UAOk5fV_pL0M-VXEz2huZZ-I0
Message-ID: <CAB8ipk-cVZVLHdh_9y_E0wTZeFYqy-smCm0KgxYbak1S8U=F_A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] PM: EM: Export em_table_alloc/free
To: Christoph Hellwig <hch@infradead.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, lukasz.luba@arm.com, rafael@kernel.org, 
	pavel@kernel.org, lenb@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Mon, Jul 13, 2026 at 3:34=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Jul 10, 2026 at 04:24:46PM +0800, Xuewen Yan wrote:
> > When drivers wants to alloc a new em_perf_table to update
> > their em_perf_table, they need to use em_table_alloc and
> > em_table_free.
> > So export the two func.
>
> Please send this along with the driver actually using it.
>

Sorry for the late reply.
we use it in android vendor specific ko, and the ko is not upstream.
We use them with em_dev_update_perf_domain(), Just like
em_dev_update_perf_domain() was exported, export the
em_table_alloc/free.

Thanks!

BR
---
xuewen
