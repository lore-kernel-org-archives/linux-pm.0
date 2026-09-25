Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4029D3B47CA
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790355177; cv=none; b=JUuzoVkmWlvrZiZ6dRb8O1kwSdv1DPss57V/pttWYx/d4f6wcw+2MOaiCEk/73W3r9E43Z1ld0OSE4YdGUD3y9iwm0/hcpbl9sq3SgJbsm2JxAyIjEQgJu6hx4kR73ly1spPv7fRr7TlDsu0W5pkZeeTnKS1nnfFocqDNt9HkGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790355177; c=relaxed/simple;
	bh=JzAn+EHmG/YqsboQ5r/uwFt2WNm7DNHuTs7ss34Kz7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNGQiJ3FvjjiLUkZEdittfOfVA3HZh5F+Cvfs6TMwTSI3KSiscNVzr4xCXrNWD1Rdd+oc7RnOKatWMIgV9D7MYFDXYZHok9zpeh8UQK8ne+Stm4Recx3QFJ0otP8xc8XJjj3r0kVUj77e66/MgcE1xNZSCWmOESg8rproDwf+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLvy7LjL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLvy7LjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BA01F0089B
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 16:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790355167;
	bh=JARynGJUCvOWQyNY1o+FlzMj+Bv1IKnpsppKykEkgD0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VLvy7LjLV2lwF8xnen2f4bIBb9oDB2QwHkoz6EYM5DvhyEZtITS8HBqpcGfakhIzS
	 k32rhF6dfMKsKJ63WzcNiH+IVdxnkyAsoq/4UsXmE3YsjeCuQuAnZ8Zlu/deuHk6Fz
	 iC0AtdVi9G6i7QZph3lAKpqewVTJ03IVe6M+1KSNCoNpRsj4G/dPqIKwYmhQE2qZjW
	 HgCXSfsDz+9azthI8GCWtnF/wnCaz2UQNclzH9G+qKloZD/WcUmIn6ZcHj8Kv56+vW
	 KefDbXJmh5ATXCavdZ2/nKKoz54ISFYSi8BA6YyFuU6hiloreXbO8TmhVkdulhp6Tw
	 utniKwNv2o42w==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a658b1f7b7so1707331fa.1
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 09:52:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByYMPMdq+KamdNdDRSYFhVEjhF3aSKQ1dUjDk0sx2eA2oA2b5ydzpihUTQ7y6hTMPeocZCdUOk80Q==@vger.kernel.org
X-Gm-Message-State: AFuF++n6f+YUv7rGxPCrJXrs8WlmsA4orI2E6mxr31ZCjmMVOqruau2t
	So4C3324c3/lj0sy8mQKfYT/zT3V8E4peOXPMKJKezcWkLr8OoYpZQQdoXYd5IrUkaD+XhEL/e7
	q/DIyzDy4ujr3PG74Uw60m0GQa51JyAU=
X-Received: by 2002:a05:651c:222c:b0:3a6:4e4d:9d1d with SMTP id
 38308e7fff4ca-3a64e4d9ecemr6264461fa.0.1790355165530; Fri, 25 Sep 2026
 09:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805070900.3390978-1-matthias.goergens@gmail.com>
In-Reply-To: <20260805070900.3390978-1-matthias.goergens@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 18:51:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0izV3g1mSKJtKMcc=TfeUjJofSXCX92y4XX55Lam28qOg@mail.gmail.com>
X-Gm-Features: AclHuK85wIOJjS4FjOn7NpdlQI5RIKzhlYZPPYKaHhvSAVTRRtE57QyxOv3z4_k
Message-ID: <CAJZ5v0izV3g1mSKJtKMcc=TfeUjJofSXCX92y4XX55Lam28qOg@mail.gmail.com>
Subject: Re: [PATCH] x86/hibernate: Ignore page-zero RAM in E820 checksum
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, pavel@kernel.org, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, yu.c.chen@intel.com, jlee@suse.com, 
	baoquan.he@linux.dev, dyoung@redhat.com, io@r-ricci.it, scardracs@disroot.org, 
	moravec@ukf.sk, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the late response.

On Wed, Aug 5, 2026 at 9:09=E2=80=AFAM Matthias Goergens
<matthias.goergens@gmail.com> wrote:
>
> The legacy kexec_load path reconstructs the E820 map exported through
> sysfs.  kexec-tools leaves the first 1 KiB unavailable for the real-mode
> transition, so a kernel entered through kexec_load can see conventional
> RAM starting at 0x400.  A subsequent firmware boot reports the same RAM
> range starting at zero.
>
> The hibernation E820 checksum compares those byte representations and
> rejects the image, even though the maps agree from page one onwards.  The
> reproducer observed this exact transition:
>
>   firmware:     RAM [0-0x9fbff]
>   kexec_load:   gap [0-0x3ff], RAM [0x400-0x9fbff]
>   firmware:     RAM [0-0x9fbff]
>
> Common x86 setup already converts conventional RAM in page zero to
> reserved memory in trim_bios_range() before registering hibernation
> nosave regions.  Page zero therefore cannot occur in the image.
>
> Canonicalise only the conventional-RAM portion below PAGE_SIZE before
> calculating the checksum.  Preserve RESERVED, ACPI, NVS, UNUSABLE, PMEM
> and all other E820 types so that changes to exceptional mappings remain
> detectable.  Maps without conventional RAM intersecting page zero retain
> the previous checksum byte stream.
>
> This is deliberately narrower than the June proposal to checksum only RAM
> and its opt-in relaxed_memmap successor.  Rafael noted that ignoring non-=
RAM
> changes could hide moved ACPI or UEFI regions still used by the resumed
> kernel.  This patch preserves every non-RAM entry and ignores only RAM wi=
thin
> page zero, which common setup already reserves and excludes from the imag=
e.
>
> Changing the checksum semantics means an image made by an unpatched
> kernel can fail to resume under a patched kernel, or vice versa, when its
> raw map contains page-zero RAM.  Such cross-version attempts remain
> fail-closed; normal same-kernel hibernation is unaffected.

So this should update RESTORE_MAGIC in arch/x86/power/hibernate.c to
indicate the protocol change.

> With the reproduced raw-map difference retained, both the direct-boot
> control and legacy kexec_load hibernation/resume tests passed.  The test
> kernel also completed a clean full bzImage build.
>
> Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memor=
y map by md5 digest")
> Reported-by: Roberto Ricci <io@r-ricci.it>
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> Link: https://lore.kernel.org/all/Z-hYWc9LtBU1Yhtg@desktop0a/
> Link: https://lists.openwall.net/linux-kernel/2025/04/04/1372
> Link: https://lore.kernel.org/all/CAJZ5v0jmOj0WBtMTvbnaD+2b0bTFowA=3DJWrq=
RzaaCYpHpai1Nw@mail.gmail.com/
> Link: https://lore.kernel.org/all/20260623165724.10753-1-scardracs@disroo=
t.org/
> ---
>  arch/x86/power/hibernate.c | 47 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> index a2294c1649f65..ec53c970c92e6 100644
> --- a/arch/x86/power/hibernate.c
> +++ b/arch/x86/power/hibernate.c
> @@ -63,6 +63,25 @@ struct restore_data_record {
>         unsigned long e820_checksum;
>  };
>
> +static bool trim_e820_page_zero_ram(struct e820_entry *entry)
> +{
> +       u64 lowmem_size;
> +
> +       /*
> +        * Page zero is BIOS-owned and registered as nosave.  Boot loader=
s may
> +        * therefore omit part of its conventional RAM entry without chan=
ging
> +        * any memory available to the image.  Preserve all other E820 ty=
pes.
> +        */
> +       if (entry->type !=3D E820_TYPE_RAM || entry->addr >=3D PAGE_SIZE)
> +               return true;
> +
> +       lowmem_size =3D min_t(u64, entry->size, PAGE_SIZE - entry->addr);
> +       entry->addr +=3D lowmem_size;
> +       entry->size -=3D lowmem_size;
> +
> +       return entry->size;
> +}
> +
>  /**
>   * compute_e820_crc32 - calculate crc32 of a given e820 table
>   *
> @@ -70,12 +89,32 @@ struct restore_data_record {
>   *
>   * Return: the resulting checksum
>   */
> -static inline u32 compute_e820_crc32(struct e820_table *table)
> +static u32 compute_e820_crc32(struct e820_table *table)
>  {
> -       int size =3D offsetof(struct e820_table, entries) +
> -               sizeof(struct e820_entry) * table->nr_entries;
> +       struct e820_entry entry;
> +       u32 crc =3D ~0;
> +       u32 nr_entries =3D 0;
> +       u32 i;
> +
> +       for (i =3D 0; i < table->nr_entries; i++) {
> +               entry =3D table->entries[i];
> +               if (trim_e820_page_zero_ram(&entry))
> +                       nr_entries++;
> +       }
> +
> +       crc =3D crc32_le(crc, (unsigned char const *)&nr_entries,
> +                      sizeof(nr_entries));
> +
> +       for (i =3D 0; i < table->nr_entries; i++) {
> +               entry =3D table->entries[i];
> +               if (!trim_e820_page_zero_ram(&entry))
> +                       continue;
> +
> +               crc =3D crc32_le(crc, (unsigned char const *)&entry,
> +                              sizeof(entry));
> +       }
>
> -       return ~crc32_le(~0, (unsigned char const *)table, size);
> +       return ~crc;
>  }
>
>  #ifdef CONFIG_X86_64
> --
> 2.55.0
>
