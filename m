Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C07404BCA;
	Mon, 29 Jun 2026 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738917; cv=none; b=tusnHznHf6+hu/sBvVgaO1f9J0BQsR+C3Q/s+RLYgC2IeqpZpfQwGWQwLUvrRp2Zodl5XVoZt4Djl/dsEenKpVCsno/RZtY0h++2dHeiX58YTnFwYPBWEiEl/I0KQeiGx/UP7ZLSg3blKyeSVQmI54/k8IKxsSf08sGOxHKNcdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738917; c=relaxed/simple;
	bh=sabq8kSQsJkleRsCAFICxNRAp/yHZyepnTyys8bOtes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfTHJQLzMFPpwINU82yjgWhbM+9iptk7yInM+LL+OfqxhqZoRHr9JD8ah3F7lNDf3A4t3TNnTSvby/an+de/wkXHVbPCqaZ3XOXtqjGeBJtxodLqhVmLi86XiP19PdlztodJ54fxXGcygwNwi3p/JZARFkJrlxw8vQQlf7SJPDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWLrf1Bn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWLrf1Bn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8973C1F000E9;
	Mon, 29 Jun 2026 13:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782738916;
	bh=QmWrOLWlZ8XT1PF+7otoOlj76f98IPZUuxfpS8AErHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YWLrf1BnudF0i4ZuSM0wAfxj4pQ6gUnP7S1lafUw2xw608Cumt6aSk3UmNxg86Y7c
	 v1cgoCTKIcwb5nytQ7awp/goEj05O/ZFbNP8cwVYyamadSZEswElm5lrxH6yjfAgyg
	 kycwWlBvsStSOCWJefLgQpk3MlbH0Shxas1y5alPHZxQSpRSQLhmlrQL1DafSmLXcM
	 JcyDaqp+HNr4c4GNpP4zt+eI+qvB7s0IOSj+HQKek3DcNg2dwt9FWyXkdmhlhWKZXN
	 2V9Fy5Rs/l5CB2ItqjYZ5MZNpNJUTbNgrgLhBJnsxOk0sB46kKLw5ijgyuO7qx4ax9
	 4vJxVHHM29ujg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [GIT PULL] ACPI support fixes and cleanups for 7.2-rc1
Date: Mon, 29 Jun 2026 15:15:12 +0200
Message-ID: <12935226.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0jQyELy6Zyqn-ngTmVG7Gj+CFMtL_t7qDEQjWSjgcLCmQ@mail.gmail.com>
References:
 <CAJZ5v0juZ6YJVALVEi1s_O0qgcr_o880TJbRHXWsd-Drb-sUXQ@mail.gmail.com>
 <CAHk-=wjS6CuKne+v6t3J=ppXTJj7dwRE0FiuXjT_O_wBiW0yVw@mail.gmail.com>
 <CAJZ5v0jQyELy6Zyqn-ngTmVG7Gj+CFMtL_t7qDEQjWSjgcLCmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Monday, June 29, 2026 2:22:51 PM CEST Rafael J. Wysocki (Intel) wrote:
> On Fri, Jun 26, 2026 at 10:14=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, 26 Jun 2026 at 10:54, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> >=20
> > How about just adding a trivial strncpy_pad() to
> > <acpi/platform/acenv.h> or something. A place that already knows about
> > the whole "I'm building the app side" now.
> >
> > Hmm?
>=20
> Something like that or define acpi_ut_safe_strncpy() as an alias for
> strncpy_pad() when that's available.
>=20
> I'll figure this out.

So this can be done (on top of 7.2-rc1) and I prefer it to the current
code, so please let me know what you think:

=2D--
 drivers/acpi/acpica/acutils.h     |    2 ++
 drivers/acpi/acpica/utnonansi.c   |   10 ++--------
 include/acpi/platform/aclinuxex.h |    1 +
 3 files changed, 5 insertions(+), 8 deletions(-)

=2D-- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -626,7 +626,9 @@ void acpi_ut_repair_name(char *name);
 #if defined (ACPI_DEBUGGER) || defined (ACPI_APPLICATION) || defined (ACPI=
_DEBUG_OUTPUT)
 u8 acpi_ut_safe_strcpy(char *dest, acpi_size dest_size, char *source);
=20
+#if !defined (acpi_ut_safe_strncpy)
 void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size);
+#endif
=20
 u8 acpi_ut_safe_strcat(char *dest, acpi_size dest_size, char *source);
=20
=2D-- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -164,20 +164,14 @@ acpi_ut_safe_strncat(char *dest,
 	return (FALSE);
 }
=20
+#if !defined (acpi_ut_safe_strncpy)
 void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size)
 {
 	/* Always terminate destination string */
=20
=2D#ifdef __KERNEL__
=2D	strscpy_pad(dest, source, dest_size);
=2D#else
=2D	/*
=2D	 * strscpy_pad() is not defined in ACPICA tools builds, so use strncpy()
=2D	 * and directly NUL-terminate the destination string in that case.
=2D	 */
 	strncpy(dest, source, dest_size);
 	dest[dest_size - 1] =3D 0;
=2D#endif
 }
+#endif
=20
 #endif
=2D-- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -134,6 +134,7 @@ static inline void acpi_os_terminate_deb
 /*
  * OSL interfaces added by Linux
  */
+#define acpi_ut_safe_strncpy	strscpy_pad
=20
 #endif				/* __KERNEL__ */
=20




