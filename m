Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D1F3CE4B6
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721556; cv=pass; b=CZ7rgulhfKZEVCxIcFOMs7IcnwLwV3da8Lgwa9cEQLX5IpE4GxY8OanWTVFuFkQjw531fWnC2Puot/eykMRNcnnfPw3sk/JdAKpanYtV2aW+luloUJy1Ss+WNQQauS3AnQQkFzaZL8WK5waYQYgeKQIesWaT6f7Ffwyt3JFTh3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721556; c=relaxed/simple;
	bh=TK7PQvHRhfO7d69vCikmlkkwgXEXe3Jt7PiHxltn8vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAH6LwL9s8XCR3HEdbgGO07Gx1rKYnma61mLsQQjrcJNNgHwhnhF3XPIqTSWhn4JB/Uq3ezy0KQHmuWX+pBWLKp7VGVAhhlCTU0iRtv28wL8EPCdg+JhY6gLlS/hX6Qhdku9r9IjOF8umf69O6JdgEv3zcq9sIc1ULc2eSgpBQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWznMTT4; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWznMTT4"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aeb2bc82ccso1330748e87.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 08:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786721553; cv=none;
        d=google.com; s=arc-20260327;
        b=XkNXt14I187COU4QY7HGJ3vausAjWzFd7JrZN757C3fs9WgxJgkowwxjIHu5y4/HhR
         SAVjnsnCp9//FVwgbqpX7ePpm++Jxzx9dgZd8SgWFAUVmNgjCmD/li/4LntV/0d4eSjW
         9Xa2AlNbxH97GaI5xakL4GTPIl4P1lMAxF0Y0ywQrjATF5UHegG0/sDl5fcLxNDZQhjB
         EmaiDmqQDfC45tOXyq1+dUKGBgYDJPmvW5D+C59Dcet6plGATrroXUY2oAIqbaxzNkC9
         icd+m/1JFLzrP1lU6jlikyaD5JmiZ0pMXg2+fLWgwcibw0Zl5A/s+MeNewn61cd9cHkx
         Q4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TK7PQvHRhfO7d69vCikmlkkwgXEXe3Jt7PiHxltn8vg=;
        fh=jWw4SeexXAYLNJjvWAt+UX9N2C43SuU1xRqv9LM28aA=;
        b=jFI6LSKVv+lZc9sZq056fsCtl/BtPd6vqhfsmuIGwRHrB/VvI/zJQyT0wxHwEER14z
         N6er/2xs18UhGZYFC9Ujja9R5kh+0Y0D+K/VwKGXZe0yX5GR8wYNWDJ+2pI/JjbAQnya
         +GWj8I1XihJ4vJKRBefM7nhLPefQ3gUNB9X4aDl0VNsH1m92jOCDH1DAepTyUtoTE2as
         0iAF3TxdKJ6dhwbI7F6XRZ/D98ReNj7V0fNfIm10Jvq4V67obplp07o939+L7aNIeG9e
         tk6pAUexXT35LPPIfDd8Rcysa8Pi3QuCphHOvMYzxLcSCJfKiqo704QNC0QikgcCqf9r
         0G/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786721553; x=1787326353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TK7PQvHRhfO7d69vCikmlkkwgXEXe3Jt7PiHxltn8vg=;
        b=QWznMTT4c3t2Zh+1YWMgRXyJ1gqpDDuql2zC1f86z/QXJ+LDmyoYiCsgrHOWUMtrg6
         bNrJEd3Cx/hUkk0RLs3yPPOdPeX8oi3medfxZQDFon3L4VoD5hAmdBs9iLEjFa9hSRL7
         jnaLRWeWvD58X+4MPJCaZtCwyP3aaV7lddEZRc77gtb2A9q7MpNcyT5Hn/Y4jz6uEV8+
         hfvPGrZm1nrmVn55b02f+uSfFWFWd0fBFA4wYmbMucz1t3T7Sn1GsyCwevbcj5RcvaSm
         2ISKGREqo10apTu42M7VM8zPxXnfHz0fvQEZ1l0So2KL69wy19nmGQ8KLsaYUngr2yg1
         ssAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786721553; x=1787326353;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TK7PQvHRhfO7d69vCikmlkkwgXEXe3Jt7PiHxltn8vg=;
        b=Tp+A3WbXkiePEfMYfG96u9a91B9DmYnvplqDQjMMGrMI65sPFqCxzi9ybshjfD+GDv
         lunt7CJDSRO//4P9Olp9e/PcFJwEY9HiDwTm1iA4ZLTLba4kkHFNQvS6vXVup47264aG
         vVgIYnsFAGfJw2YSWmuEN1pVLIckzYbVaDDzFN7IG6r80IeQWNCMqiQeml6ehLXEhp5R
         igsXx3SBLZmMzHPnBXDrW2//ySfBEr/ZMPy8908ITNO+W1+zyya3qQAbvc+Xus5JR9B7
         I7+tQoIsxQQg04mmlI5ap8THAwJ1MGd4FeQfYcmU0j/gjarJPLTLBkiF7+68rrBBAbU/
         Hojw==
X-Forwarded-Encrypted: i=1; AHgh+Rpd8uCMXedqkgRvAAdnsfAbRKEm/+H8NdoJipQelyfLigYReqcZYuA0m1MlGulCN1+JZlYD4RmSLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxtVc1ZdZs9LZ8QMECPPeahwlvLvdOsbPlod+9Rd0ip8YcQz+U
	Xs8Iu471N/EoPeYO3QPJ1QGWpnocr0oBMhw3ZYVpwk8g3o81v3g10bq4q2Vidfx+eeywcVWArqE
	H6k538htQeWFMOM/WrFTAfro/kYw/ozo=
X-Gm-Gg: AR+sD13i0uQURIWY+K0qEivTqJhi4lR6SbvWwmOm+6GqnUVpNl+I0IZ667ZRTKf62Rx
	sxuprDJyrqCpQo39H1mdBABAcXwIhX2KCCKwVObZ6L8MGtqkTi145GU8AwDVBt08OM0WJ02jKNw
	JOuQyj+9tQpQKhsDN/n6FCHjbj2PE5tem+2uErURbDhHwyNF2IKW3mvuaZcdOswCIW6wI+7O7ng
	gFNFvUF6nBUL4KobYM8N5y8SxQ1muwaYYgmpPXBeUxiyqjRe1pcW8yApO5xF2tHKZxT+2FLkTbO
	lPhkcD+N2PODcofQn0g+yBZ+R5XmWcn6kpwFb0yxbCc/BYt0bRYSCLTmbWccLWCtvCSMQmEzOsK
	ThyWumtGZDTjLHcBQc3m/9eM1OAYqMD6cCA==
X-Received: by 2002:a05:6512:3b11:b0:5ae:bbe5:2076 with SMTP id
 2adb3069b0e04-5b45914ab46mr1037748e87.52.1786721552817; Fri, 14 Aug 2026
 08:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806170108.2100312-1-daeho43@gmail.com> <ann0OPPglToV_hjs@infradead.org>
 <ff74edb1-43c7-485f-ab78-ec13b500a0bb@acm.org> <CACOAw_zqOS0vHdQV6WoUJyxnDf=kdDAz27pNGDLdQLUdUYOzBQ@mail.gmail.com>
 <an62BorNrc-IX228@infradead.org>
In-Reply-To: <an62BorNrc-IX228@infradead.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 14 Aug 2026 08:32:20 -0700
X-Gm-Features: AUfX_mx2Pto06m45d7F2_lptjs17kW4x65ZWOP5JIP6wMXsiPjstrC3FI6rq2kA
Message-ID: <CACOAw_zKnj-o_7OhEWcVGYeFy6m1GM1KCW3hhgBX+O=KTev1jQ@mail.gmail.com>
Subject: Re: [PATCH v2] f2fs: quiesce background threads during system suspend
 using PM notifier
To: Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com, 
	Daeho Jeong <daehojeong@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 11:30=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Mon, Aug 10, 2026 at 09:53:14AM -0700, Daeho Jeong wrote:
> > On Mon, Aug 10, 2026 at 9:34=E2=80=AFAM Bart Van Assche <bvanassche@acm=
.org> wrote:
> > > This information was shared earlier with Daeho
> > > (https://b.corp.google.com/issues/515470309#comment45): [ ... ]
>
> This does not seem to be information available to the public.
>
> > f2fs threads are already freezable: f2fs_gc and f2fs_discard are
> > already registered with set_freezable() and call try_to_freeze().
> > However, a race window exists: a thread checks freezing() (false),
> > calls submit_bio(), and gets trapped inside __bio_queue_enter().
> > Because it gets blocked before reaching try_to_freeze(), it triggers a
> > PM freezer timeout.
>
> This does sound very much like a block layer freezing issue.
>
> > Point taken. Aside from this f2fs patch, I agree that addressing this
> > at the block layer or PM subsystem level would be a much cleaner,
> > system-wide solution.
> > I=E2=80=99ll give more thought to how we can properly solve this race
> > condition for the entire system, and I'll loop in the relevant
> > PM/block maintainers if a viable generic approach emerges.
>
> Thanks, it would be great to fix this properly.

Now, I am considering modifying block/blk-core.c to introduce
freezer-aware error handling in __bio_queue_enter().

The idea is to have __bio_queue_enter() check whether task freezing is
active before it decides to block on mq_freeze_wq.

If the system is in the process of freezing, it would immediately
return an error instead of waiting indefinitely on a frozen pm_wq.

I would greatly appreciate your thoughts on this approach.

Thank you in advance for your time and insights.

>
