Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E254399368
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 21:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781646868; cv=pass; b=Q8fHTUpD5cUjdVqWq/JolWXFnTUAXHMjlzii0dMMDrQ2py0pVGaQqG0bjrwInpKFm57NedvzMfYrPmGaQ3+1Ph1aPdIiFXnXMuNoPKXGgNheESZtWRUCrq0Qr/vFVu2LHmWsM1w9VOKHdvFZnODv8hccRvoaCkUPUC4OLJ39Hj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781646868; c=relaxed/simple;
	bh=9Z9LunT4mAHZzYKcYVkktHCCEEGJlcsqTx8XhGsVBSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJYmzDCx/EfxjcCBu4MbawAYa1ivYDvf8sANZL44HJmdaDPGOL2zJDwoFO0IovJT4ymuPPRdmTGKR2zy01GS8KBIJT/CPv2yf+QL03yxoC6TJU+jhtAGJNpdHp9FTG28GrK22h4BOu0U9hQmQ0BkK6Osxt2Kix2wveNpmFyAPWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WJ6ymFxl; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJ6ymFxl"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68d22476e88so4535a12.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 14:54:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781646865; cv=none;
        d=google.com; s=arc-20240605;
        b=LZDT7njbS3sMqE4HAO7xUXxCn3S1AU4mGbtbMZEH11eaL5F0I7YSj3aF+XH+/Y4Une
         /H9RsRyt+X+a9JQnrq88V64bfIou1TMk4tXlfxyEuXOSTe59PWDFrmuBO54HqQMYVHLo
         DL0c2RlwRt/55t5Ie0Kd9baKGT9L5xaqu8Ln2kARYzSLtJOusgK9D829mZO1aQffkHAf
         F9pLhzAnhWYFolO3pN5MolKqn/R2xiVg4PUcEgqxQ0PmfzCBmQMb1jXxn0+mD5QxePmx
         Z8nR0AI7JOh0SMjAlJlfMohuwJ6x3RzrLZsovKMMLffDfGPn9XHlJVLHb1Jkhggbbb8W
         lpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pHwYOCHunusixyCj/RHnrVRAZ+hEtAxcOEBc8Fc4M+g=;
        fh=OPvVZGpa9dzX8xwlUtD68wax06iSRH9/gMgkYD7HyQU=;
        b=hcBCwWzXNxTg05oggTSBALO8rA8T/FOQYycbfybAXm3dkw979ij3j1t6DCyHjOdV5o
         QA66EuSGTVgJZfWZpMZtfKHJ5r4zHERsOKqZIEjJ3jzve4Qt3m/IivtgG8xPV3kl/QjQ
         EhbG0tqyFTv8CrrzCo1v2hF+zAXJSfNEiMsa+Cz2+IBgjpxAZ1XYuSrnLymiR3PpXnCz
         s8O+ZZBRtb15LKzaDSTZe0thnuRx7p/BLHVaqyC8zjUtIDFW8gK0OdatoHgGN/C0/50+
         uNvPxKd6S4EmTfACG8CL7eTJ1yT1yn4Lf31SFPc7xFOpsFoyMu4uDWCdp8pRvpcEJP0R
         LFSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781646865; x=1782251665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHwYOCHunusixyCj/RHnrVRAZ+hEtAxcOEBc8Fc4M+g=;
        b=WJ6ymFxlQLX+NE2hceynkO6Td8nEn3ULgmAb2QUqs04A+7eJD5YSUNydk0ci44Exhb
         vAVxAR9abDLlUTBiAKvB56MFsIEFoy3WkUwb6A77aEEU9qFF7t4LcWKk/nI7DQNDAvVK
         O9POTmKo4MOo3xzvO64OrPGp/IGxFEoLW5XXbp1C1abIjQ741wsO6iyHltdMXDHYp1BL
         S4BUthuRGDreQCx51iWn1jGrrZePnR94EL26Bht2gi9CX/t5z5CuYb7RdoOGoGV13otW
         /sa9oRTD6DlVlQfhJ+zXCGSVUvKeuWgk1wbPWTqhcOij1YS8i4zQczu2O2uv+xO2YJUL
         ZlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781646865; x=1782251665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pHwYOCHunusixyCj/RHnrVRAZ+hEtAxcOEBc8Fc4M+g=;
        b=CniHZ4vZVy1XaSFd+4XqLGOd0Ry+1AwVnXWwKMos6AGEzeaPIcVkb0n/S3yWjtR3F7
         ecgh807Gfhtwg9tgtqVe/ux322RVCTFXK/fZfVBU+lo3CY2GHmo9WGQyVkNVxvNajAoe
         dvVPnlDTECqazT1QbjuIpnPveqkNmXE5PwCrAYEIU8Z9HGiOqWFlwpMuTQQVrW3wuN42
         aAMSk5Oe5qNuaUmD+L1+sjtKSLc8cpvL2f7dR/kuJtA60jy4Wtej1kfNuixsWaWGIQRB
         N9I5SxYNRkorJVuan427xfg4vXAEdTf+GzHNUxRMqMd1PIjfiQ3TwROCckHSu3Wshwwn
         YCIA==
X-Forwarded-Encrypted: i=1; AFNElJ+ggtO5ymlrIfx71lXtSb4iUhyBDVF/D5+b/ri9ZXhK+gHeDUHxT/RuCKc4j044zx2PzmYmDO1pww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrr3LIKJhsQ/MAJqTyiZiqkqOqOXVUQUgaG7rjjwE6TkwN1fbI
	5Z+Nw4bOkDtljHllZu/Fuh2VMvqf6bkUC2moSXslxfTIR+8vOnglbQ6fmfpkUhfG4q1hZjT3Rt4
	hITz+roeAJApuf6uIS5OqRoJKmIo1X3Is4IMlFG/T
X-Gm-Gg: Acq92OEVeYz6jTKuTgGn73HKECUYFlmazRmbDs4+LlLSa5sbDecvCP+JV00CQv5A8ro
	uPfjqROvKt+jn5hurqjlI7gkFtm7XIKrIiaxmw7/9JlQPWDEw9pqmyVPHpsvcwGm/COVvCSRARy
	dZZ6HPV4aV0gWgHvJU33cPXQapGkfRK9NT3NmM0hy032yJdbEJSZQkE4KOEUJFKTDbYp9mgosy7
	l+jxEQ7nhXYRLC4beDj1JJ4tMKY/04c7OgrNY9g9FGTOjFqIc0k8y+p6YeAPAJQYzJVQ35xTJaU
	bItf/mFH4H7CxRABSA==
X-Received: by 2002:a05:6402:a504:20b0:68f:d41d:ca5e with SMTP id
 4fb4d7f45d1cf-6954783d3cfmr10814a12.12.1781646864981; Tue, 16 Jun 2026
 14:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612215729.1532175-1-jmattson@google.com> <20260612215729.1532175-2-jmattson@google.com>
 <CAO9r8zMmmHXbrKKfZOEwggSRHrd8Am5+wko4riVM4Yz-12vbFg@mail.gmail.com>
In-Reply-To: <CAO9r8zMmmHXbrKKfZOEwggSRHrd8Am5+wko4riVM4Yz-12vbFg@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 16 Jun 2026 14:54:11 -0700
X-Gm-Features: AVVi8Cenl2SVz_D2THSUftoM2By33FfIi-sYsOrv-ZZ47uUlceYZ-LuhsQ_U06w
Message-ID: <CALMp9eQNjEiYaHNYNJs=hjZG4S9eEeS22Ft9HMwg1egSA-pFzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/CPU/AMD: Avoid racy updates to MSR_K7_HWCR in set_cpuid_faulting()
To: Yosry Ahmed <yosry@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 3:30=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Fri, Jun 12, 2026 at 2:57=E2=80=AFPM Jim Mattson <jmattson@google.com>=
 wrote:
...
> > + * Context: Any context except NMI. Disabling interrupts does not
> > + *          serialize against an NMI, so NMI handlers must not write
> > + *          MSR_K7_HWCR.
>
> Might be more useful to WARN if in_nmi()?

I concur.

> > + *
> > + * Return: 0 on success, negative error code if an MSR access faults.
> > + */
> > +int amd_update_hwcr(u64 clear, u64 set)
> > +{
> > +       unsigned long flags;
> > +       u64 oldval, newval;
> > +       int ret;
> > +
> > +       local_irq_save(flags);
> > +       ret =3D rdmsrq_safe(MSR_K7_HWCR, &oldval);
> > +       if (ret)
> > +               goto out;
> > +
> > +       newval =3D (oldval & ~clear) | set;
> > +
> > +       if (newval !=3D oldval)
> > +               ret =3D wrmsrq_safe(MSR_K7_HWCR, newval);
>
> Can we reuse msr_set_bit() and msr_clear_bit() here?

Yes. I tried to make it more general, but none of the current users
want to modify more than one bit.

I'll try to get v3 out this week.
