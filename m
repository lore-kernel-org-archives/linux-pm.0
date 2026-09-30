Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E22F50B437
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 20:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798622; cv=none; b=isiTHZEbFwcfrWKawdW6VisQPuX40askcwFIO0Hk17mqBD4F8FpE6DvyRFfOJa+lzW9YZIhBx+oLAss9AdgK39UyBPkdrugQ5TcKW8OUONT/G1WvXjJWD/gYuaf5SoQQLq/IbhjQMlSSZrMeWkTXHZWOpDzpPGBspQNayP1Z4ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798622; c=relaxed/simple;
	bh=eNs7J7QVZeMz7CRY7JBc/41cENuy7PTlFY65xb5RJPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Czm1ktTMcKNGvij82KW2qVsBV/QV6o/m/GTrvH5ZX+o9oHLatIkihLd/lSeYeidEd8lrLqpjwP0nB36M52d4l+pJX3sySyzMeCbhO2PV1S6spuhxGhQ39QNn9VWRF9lOZqdMIGUnov14Fuy0mBvETmmqoc4MEiO2p+KzAfm5swk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isVJFtDp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isVJFtDp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E1E1F008A2
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 20:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790798619;
	bh=OapGlJY1wYDmw+Y0TtKR8EKrOr0XHXHejx9VYzSAsew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=isVJFtDpxlkkt9wxINs19J35jvjci//y8lyLPwj66rp8XRRiKTQ6djmQq6Vja2yMt
	 kEdYBzCM7dWoM2qpkWVy/m8nk4ZLTZ38b44IQR/LsMqSECnUomS9aKTHdY30m2X99p
	 ZdgCta2E4seokHNq1AxDt8HnW6yIxKgHeD8n9UrWXddQuMU3/HdYAWXaL01MYtlksh
	 bpzDUKJgpBB5x9LmmLJ7dGQ6cElDnBMzLcEUZtiPQ7cin7F3E4wU5FGTgrzg4nk0jA
	 koTgPKWRc7OCgXzkQ5q0zaM/BjB8h8eVsquAGrmFOjU/MJz7GBOQE36bDVv9BFluAi
	 0ibbHoQjSGYug==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff148dfdso47190481fa.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 13:03:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBys/Jtdae6Y5rNwW6qgEwPmRBs9tKsOFki4Y/fK/yQO5taKjqK8uON6Rvtnt7vU5Mnf0/GoXFENtQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKIw2t6UIN+RLqtFZFC0TZTddVicfDQ6zeBfCBcSa0KWPiAUHPj
	3FRrgyquNCPIUWvXL/tPLlMipoUfCBLjqeOHKVv6cDSLHztBrGt7Tdscp1uIPsHCMkvN/TKpsiz
	29803MCWebpZyZp7dTh4+qdsk/+oK2i8=
X-Received: by 2002:a05:651c:4182:b0:3a3:7681:6d66 with SMTP id
 38308e7fff4ca-3a779269585mr6413091fa.15.1790798618340; Wed, 30 Sep 2026
 13:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805070900.3390978-1-matthias.goergens@gmail.com> <20260926052117.3613637-1-matthias.goergens@gmail.com>
In-Reply-To: <20260926052117.3613637-1-matthias.goergens@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 30 Sep 2026 22:01:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hzrTjgrteh6JwuiaJdXLXbHpKbD7Qdz=5TinZ934vmKg@mail.gmail.com>
X-Gm-Features: AclHuK9cxMLeqKTvasUuTJx35wURz83sx4X-kdaW8aAo_1NHUJMN1pBDUOQ5Uzk
Message-ID: <CAJZ5v0hzrTjgrteh6JwuiaJdXLXbHpKbD7Qdz=5TinZ934vmKg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/hibernate: Ignore page-zero RAM in E820 checksum
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, pavel@kernel.org, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, yu.c.chen@intel.com, jlee@suse.com, 
	baoquan.he@linux.dev, dyoung@redhat.com, io@r-ricci.it, scardracs@disroot.org, 
	moravec@ukf.sk, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 7:21=E2=80=AFAM Matthias Goergens
<matthias.goergens@gmail.com> wrote:
>
> The legacy kexec_load path reconstructs the E820 map exported through
> sysfs.  kexec-tools leaves the first 1 KiB unavailable for the real-mode
> transition, so a kernel entered through kexec_load can see conventional
> RAM starting at 0x400.  A subsequent firmware boot reports the same RAM
> range starting at zero.
>
> The hibernation E820 checksum compares those byte representations and
> rejects the image, even though the maps agree from page one onwards.
> A QEMU guest showed this transition:
>
>   firmware:     RAM [0-0x9fbff]
>   kexec_load:   gap [0-0x3ff], RAM [0x400-0x9fbff]
>   firmware:     RAM [0-0x9fbff]
>
> The checksum covers e820_table_firmware, which trim_bios_range() leaves
> alone.  The nosave regions come from e820_table instead, where
> trim_bios_range() has already turned conventional RAM in page zero into
> reserved memory, so page zero never occurs in the image, whatever the
> firmware map says about it.
>
> Canonicalise only the conventional-RAM portion below PAGE_SIZE before
> calculating the checksum.  Preserve RESERVED, ACPI, NVS, UNUSABLE, PMEM
> and all other E820 types so that changes to exceptional mappings remain
> detectable.
>
> This is deliberately narrower than Marco Scardovi's June proposal to
> checksum only RAM and its opt-in relaxed_memmap successor.  Rafael
> noted that ignoring non-RAM changes could hide moved ACPI or UEFI
> regions still used by the resumed kernel.  This patch preserves every
> non-RAM entry and ignores only RAM within page zero, which common setup
> already reserves and excludes from the image.
>
> Bump RESTORE_MAGIC, since the checksum semantics change, so that an
> image written by a kernel without this change is refused by the magic
> check instead of being compared under different rules.
>
> In the same guest, with the page-zero difference kept, hibernation and
> resume now work after both a direct boot and a kexec_load boot.  An
> image written by an unpatched kernel is refused at resume with
> "Unrecognized hibernate image header format!", and the firmware-booted
> kernel carries on.
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
> Changes in v2:
> - Bump RESTORE_MAGIC, as Rafael asked:
>   https://lore.kernel.org/all/CAJZ5v0izV3g1mSKJtKMcc=3DTfeUjJofSXCX92y4XX=
55Lam28qOg@mail.gmail.com/
> - Say which E820 table the checksum covers and why page zero still
>   cannot be in the image; drop the paragraph on cross-version images,
>   which the magic now covers, and report that such an image is refused.
> - Rebased on 6812ce4e4379 ("Merge tag 'drm-fixes-2026-09-26' of
>   https://gitlab.freedesktop.org/drm/kernel").
>
>  arch/x86/power/hibernate.c | 51 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> index a2294c1649f6..dbb340fb24ad 100644
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
> @@ -70,18 +89,38 @@ struct restore_data_record {
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
> -#define RESTORE_MAGIC  0x23456789ABCDEF02UL
> +#define RESTORE_MAGIC  0x23456789ABCDEF03UL
>  #else
> -#define RESTORE_MAGIC  0x12345679UL
> +#define RESTORE_MAGIC  0x1234567AUL
>  #endif
>
>  /**
>

Applied as 7.4 material, thanks!
