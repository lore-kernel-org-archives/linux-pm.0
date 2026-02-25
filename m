Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C82C15BE
	for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045606; cv=none; b=fxVA/5Ux793YulPxbFkWxIrlbD2SDTRdnvdnTB6q0HRA/egAi1iTlclTMqKzyicsQyRWixQZHFzMIW0Wpaf7+9YYHSTKspY5ProlLbcXOfVLarVEVgS6axjuFuen28i70LTywb65JtPHKEts0kXklfqOACVcwiPAR1N1ObvS0aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045606; c=relaxed/simple;
	bh=UM6ZfWtI0C1leCyekexcdGuSnbK1NBzRoayTNlcqTFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4es79EzqxkbmstAC1zQndJFtqeV54KYSrzq/EwZyIc7B/hynQ3jZLSr8UiD+i9bYssg/chLAkE228j+zUV3ze2w6Eqe9ptQaWwPh31rsejfcU2YhLljOsUS2z3zzm0fYyfnbPNXhT2v8JJn7tSZxkojM2218XwZLvKLCrSZj8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKlFJJcq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKlFJJcq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D73C4AF09
	for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 18:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772045605;
	bh=UM6ZfWtI0C1leCyekexcdGuSnbK1NBzRoayTNlcqTFg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hKlFJJcq36oHF+GXgNpU51RB9mAIaVowzRCE0ZZ9jGvcHHE+yUlSp9Kg7XdTyxmZ7
	 Mftd4eMBZ7wqDjlqN6/rRrRmM4UyylhHIkW3eB7UoP9VPtfxKKp9+Gj3c0PuOzpmOX
	 /kL4g/GZYfsMgqKbQa0Rb0eNsfF+MlVjzi+BGJQxXL36QdncC9jU8xJf2tRznhFg0W
	 tsLX1Nfo7jaVnr7aztXtpcEgXo1Ucw1ghracieZQWF1MvCJe/nmJ6jDQ9XYAGp0Ao5
	 AF/lfuVMmgYb+81T1uAVLktgtJuZMHY2UXAJl4DYVqTbpRdP58sBLiC1y2dFkViFp5
	 /txGtzErLbVBw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65c0e2cbde1so176541a12.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 10:53:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvUaJXKyZCNxSIh0N7aA5FjhVVjzjcsESP/mXLN4iPwgY6w0RYas7aB76ePeT59/O+7hBxC4dGPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw81R1gRVcPMjW9j/oixeeheH88Q2YW/3+tDY+aX1NQXizXyilp
	JyjhcHoCJSprWpRWXfghEMV2eJslat59TM0cH0smG8LRT1xHcMJOjTxtVjn4ILowbLEhj7Omblm
	6t85ecVpLb6mJfMmKHkKUwpiVJU5qQJU=
X-Received: by 2002:a05:6402:2790:b0:65b:a76d:6fe5 with SMTP id
 4fb4d7f45d1cf-65ea53faaf6mr10887138a12.30.1772045604674; Wed, 25 Feb 2026
 10:53:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224023719.65165-1-spevnev16@gmail.com> <c0979077-a229-4584-9ac3-747dfd96650a@amd.com>
 <CAM_YkW65=Wam6or8KXdSdZFC2Q_XXqAfwREiomzH9+xgmFtERw@mail.gmail.com> <e61eaaec-2c77-480f-a875-3e42633a5fed@amd.com>
In-Reply-To: <e61eaaec-2c77-480f-a875-3e42633a5fed@amd.com>
From: Len Brown <lenb@kernel.org>
Date: Wed, 25 Feb 2026 12:53:13 -0600
X-Gmail-Original-Message-ID: <CAJvTdKkML8bQrs2bH9VOT1tX7Xsha4bZxdBorHWktKqPBLt1Sw@mail.gmail.com>
X-Gm-Features: AaiRm53aMCY648uEjC3ZRPkIZ4vF7hePKNKNMhmcMMAKdsKg6o9nZZ54AYbCGXM
Message-ID: <CAJvTdKkML8bQrs2bH9VOT1tX7Xsha4bZxdBorHWktKqPBLt1Sw@mail.gmail.com>
Subject: Re: [PATCH] tools/turbostat: fix microcode patch level reading for AMD/Hygon
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Serhii <spevnev16@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for noticing and reporting this issue!

Since the MSR is common, my vote is to keep a single MSR read and
setting of ucode_patch_valid for all vendors,
and just check the vendor to tweak the "ucode_patch" variable for printing.

On Tue, Feb 24, 2026 at 10:35=E2=80=AFPM K Prateek Nayak <kprateek.nayak@am=
d.com> wrote:
>
> Hello Serhii,
>
> On 2/24/2026 7:40 PM, Serhii wrote:
> > Yes, the only essential change is shift.
> > However, I believe that handling the two paths separately is better
> > because (a) using different constants better highlights the semantic
> > difference of the values stored and (b) AMD currently reserves upper
> > bits, which could require handling in the future making separate paths
> > more appropriate.
> > What do you think, is it still better to merge back into a single path
> > with conditional shift for Intel?
>
> I'll let Len answer which one he prefers but having 2 paths is more
> code duplication for error handling when we are essentially doing the
> same thing.
>
> --
> Thanks and Regards,
> Prateek
>


--=20
Len Brown, Intel Open Source Technology Center
