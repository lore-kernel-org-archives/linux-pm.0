Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793652793;
	b=15JIuaSVVmy6E2Tj1Eg6LaudUWnHhzepo6vCRaw8iT5Yq6tKUPxTJXF1YL1o/c0HdeS9
	 kKXpyQL8lyN/SRGDgaALZFwM5ujEaJTIh+W9/gXoccRMSfzz57iCQzDGawkvSNIeRuvmk
	 g56iC2GbReBq6FAyz+AkNylwDQu548zklAc9wEyY657Bw/frU79NRnGF06BPAal+ogKar
	 50bzQXi2BZddrlhfBlCret7/rOCALRkL+cV2Ex+XuwVBAt4dMjGpsLbkYLqT+hpNU7J86
	 PSqcNNKghfWOXBUDtL1d+MsyH5Wka6UMGRKJNT+6eMwpLXiWe3UC3qtf9HtQhZHcaZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652793;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
	b=ycd2GvxMO/yEt0Td//loNlyhhEf3BVeJjRwySXHO/g0arJ/sK3fDrt9rbgTOgGR+S9gQ
	 /Hj7/qU/r0AtXFM93K1fAChiJPKde4QahY3OiwK2b22RoOjoxytt6YJcemUItIGbx9J2W
	 ribG1BfgWN9XP7FXtXn+sYQrQ+tN4qplZ/0kM7Nb3GdOcaDzwmiOFLJMhcOi7PHU/Ia6r
	 k7PqEfzaUzc97mVtcdSMA4mFxJJJ2KbR4GHMAtFTzEHa8Ctm61sCIgyWe+oJeXA47wugO
	 +UMOHSiiDeWHMM1c23t6qymg0p/X8Jp+EVV7QG0dswr/RldH8601C4rfBvMyLDL679Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JrjqNRqP;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ILbC3qNV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29071606A32F
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 20:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29071606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JrjqNRqP;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ILbC3qNV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793652792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
	b=JrjqNRqP10lz+xwTaT1N5hOMraQMewbNcL6ZPtYs/6qBeMDZq5lyggz1hz5TUE2wvCqKwM
	IXQbQRbVn/7mLpXXty1C0A86MwLFP717upzSrzHF5Nt1PiF43MqFrw00/Vf94oFs2+EMGE
	o+EsfhfOm9/h5ijPwHR98WSryq3gxtk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379--1rClco1MCWZhMsh7lJKSA-1; Mon, 02 Nov 2026 15:53:09 -0500
X-MC-Unique: -1rClco1MCWZhMsh7lJKSA-1
X-Mimecast-MFC-AGG-ID: -1rClco1MCWZhMsh7lJKSA_1793652788
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3ab3fc6e459so290151fa.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 12:53:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793652788; cv=none;
        d=google.com; s=arc-20260327;
        b=O3fiAOpu4YDK8ZB/nNPT8aWfTCWit5UQmPYeBlaz8iiNTfsEOBGghQ7A0aoQFiY54+
         YIP87OhaQUbvYmQYT1sUsrQQzCkpPzFyz7ZDMY8RBe5m+RPgFjbOzsye9CItYxm1sHj2
         25yG6OYA3P+LZPL+GpTbyxDJOoimEZICEFKzBMIsuoKO6kjC27dLRCXkDHtrxmI0x1hl
         uS3hHoY4pUEwslelcZTFqAc/zPCB9Z1FYXJoCeq8624wrnsus8fsQMvjMULEe3zcdHzb
         ExD+iNvOabwhrW6mq9pcU1EjkLXbENb7/ofnNv5lysfR9kr9EGJs2/fCZ+st7ZqvdLLz
         Ay9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
        fh=lMg5sahEW8YeGuxCpjzyLVdEdjmLA8Pid92/xrn2Zyo=;
        b=HPSq73WeAhxUyejzpXSJLkAwiD3vp26y3diTYnL5eJEDZUMsSxu0oI65R9nVzd7iV9
         yQzM9Zv2Hg0sOmLS6XV+cONdE63l61Nc4+LKAqS8otAjhXQqAzaJV6n8OVcyjwKgBpxv
         JC6ZI+pDSg3iCxb33UM259yXrkn7BejALGh/CrE1IUxYeyswF0MHjxwT76AXm/5f60JJ
         1QlJmZS9mLYoZTi/PhSgLmvJ4ZTSy+UJAApxXHVTIhX5u/E4RC7s/58Gg5hABJoLKpaG
         FkFMlCJQNsHNu53POOJi7Tx7djgkk3bVHvJKZizW0qG0HJrDzXYnhXNrN/6I0khQxPny
         NbmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793652788; x=1794257588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
        b=ILbC3qNVxcxSfLLqiEMczm2K9EWJDHjQ3jtHiRo8lvs7xOcCBk9KViZKbMYNn3rDyD
         1nRBZKRZevJudcNGThw44x8q3rGE46+/V3Lp15cYzXfiXGQHqy3zvhO0o48B5BncA5Or
         KbQ3kcHqkQQMolwwbUP9ub3434QutGVu8nmoCGzc2PCEhLmjOocqh+8d4XwIGdidYoBZ
         1xLTej5dBNXaVOsg0H9ykUYcbsfyfY1xRAFquEOh1DF007rqhduAsvbJpJIrCtz2kQKk
         jbQ0GJtS49pjk16tDcdcdHiHPoCzeSh4Rpt4Z21PkzyRrg6RuTlgqDQLYpdpsCCp4Dam
         yDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793652788; x=1794257588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
        b=vjObABP+5D4vHdEwRe7EnsyK172hZIa5ld7WeEccg9BHeYdpx0g5nq0TuS2Wi93IE6
         FBLONSiwVnU3gESymTbFrRd7EDZ+cECMAibCf+hGnjTrsQlxr5GjPbAdCeHV6q/EvHo/
         ZYWeeuHDr4T2YxTJquNRkqLVjZa856ExlpwbFu0qSxj+oJvbt0GnOqvbquLWboUtMu0T
         AZTC+R2IawHN8CiDJne8YQig4Kv8mDlNQI2i/3fPveQ5r9aT1Ii2kAKpg/vih/eg9dUi
         eFL0ODY2z3Rg2Wf2f4zC5WjS7BKhbJgZnGol+l712GtWsvVfopg8AkOAhMnWwtuZTbZ3
         K0yQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOVZvzlYHhNiH/jk6hvBs1aHRhmsfCyV0Xjx3oLhxO+lXyI7R6V6Jv3gLsNlmN/kOzoFjhrrcqxA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8+/oAlgen4q6oGNsdLyWZtBKVp4uAzj/zApFI2LnaKemYG9xE6
	/WZP4ibr25vXzdceypttW85G0Fl+sJM/XEloRAhSZMTI9nC20NqN1F3QTsyqcyqyjz+FdaTtNnn
	K4qM6lLjt0cGyyR5uur4+ltiAwnI9ZgyBoLpz8EtuvlmkixQfDsOw1H6DLodY2nxYrUAzH2VDzK
	vCQLM4NzcUHVdiotEt+T7GxLMKlvEq2/1Zfgc=
X-Gm-Gg: AYBFou0l9J2NfmKqahi9IOPEJ0k1lk4GD+D5u/Tc2A7tDnvgEhVeuJS8MMeP+Ma3sfa
	7vu1/rm1p9dGYKxJQ1VBonj+MD1q9KI2lsbbhIIgYx4fqrxqt406/kgJCdV4sUq3awbEnz/N30Q
	98uBejdhvRtKu+1fxpfjhsNupSf48Im6chBkCWA379LnEcvKVLFdPLYJD6
X-Received: by 2002:a05:651c:a14e:b0:3ac:4b79:573b with SMTP id 38308e7fff4ca-3acb7aa83b1mr20499281fa.13.1793652788273;
        Mon, 02 Nov 2026 12:53:08 -0800 (PST)
X-Received: by 2002:a05:651c:a14e:b0:3ac:4b79:573b with SMTP id
 38308e7fff4ca-3acb7aa83b1mr20499011fa.13.1793652787872; Mon, 02 Nov 2026
 12:53:07 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com> <20261027223847.652884-6-irogers@google.com>
In-Reply-To: <20261027223847.652884-6-irogers@google.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 2 Nov 2026 15:52:55 -0500
X-Gm-Features: AclHuK8pGzNf4aGPekLa6NQcs521xOugw8djA3E8ZMCjZ7yn89XzG5j_wIaQNFk
Message-ID: <CAK-6q+j-MS_5St04YFU11LG_Cjf1jOuS3q33qk_iK=7TE-iuBg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] dlm: Free dlm_ls in kobject release callback
To: Ian Rogers <irogers@google.com>
Cc: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>, 
	Greg Kroah-Hartman <gregkh@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 27, 2026 at 6:39=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> struct dlm_ls embeds a struct kobject (ls_kobj), but dlm_ktype lacked a
> .release callback and dlm freed the lockspace structure directly via
> kfree(ls). With CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, freeing ls before the
> delayed kobject release runs causes a use-after-free, and unloading the
> module while the delayed release is pending results in an instruction
> page fault.
>
> Add a completion ls_kobj_done and dlm_ls_release() to complete it when
> the last kobject reference is dropped, waiting for it in free_lockspace()
> before kfree(ls) and in the new_lockspace() error path before module_put(=
).
> Also delete the kobject via kobject_del() before stopping dlm_recoverd
> to close the window where concurrent sysfs writes could wake the stopped
> recovery task.
>
> Fixes: 3514faca19a6 ("kobject: remove struct kobj_type from struct kset")
> Signed-off-by: Ian Rogers <irogers@google.com>

A somewhat "big change" for just a debug functionality. Althrough I
agree we shout call "kobject_del()" early to avoid additional sysfs
changes during removal.

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks.

- Alex

