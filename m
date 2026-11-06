Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793927212;
	b=pVEmRhTrFve+aziK2cFhKB4/PgfIGjRy/ggWX7u3C1Qk0L3FGut3zS+aZCgunCOaNKXR
	 wzfEMOk6vOlE/kqQO5fhuQZyFirAMAv0u0EGrZjahx29eoWnipXt9SAJ4DvyNT5U7EysM
	 D/P9yNyGc4UVcbDw+Uepcs012evcxgLAQxteQpV0KJiLstwWkwLUkQ9hL5UjljCTg0Imu
	 RjTyPQlot4mmogQjEt9RkvNLlEZq2Nz+jvL0G/rfrArvzAPP/4fSNmmqvbEBp6g8iXgDj
	 aOtaOpQylcVtudWGhsyZkWt728MALlqu6n9RoqD6CpVBy1VkHWdBGZNz5ONIqfopfZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793927212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sli5Tik7wgGinR9EmKOShOO8llB8BZYKVbdNtNJa+KU=;
	b=AZiaZiwLmsJUB6iIor+g0il8EFmGN9zJu9OKArcD2W8en051UhDg3D+pg58OM78AsZy5
	 PKYLOnjXTqVOMVRwECPcLT9oA1QrpxX7/kB3wUgcAkZPGIrJ+mKOagwbgI7teH9YTO+Un
	 N3EMNKG2X04yA+Vu3vZ+sPtVnsXi7ZPued46QWB2M2Ff0g/6WuQeSxIp3OuGn0G+6IpsF
	 SoctIyB894BT5SkvoffRq9jPYcSEe4dvP9l5p+sL8ye3ruc2n0fSJnefioLBF1tdtWj2n
	 tuBasupzvVnMv4RJEXqicGI6EnTsmtggkpG8sP5Ukpk9FEwdJX/kYpuCcSSBT7j62aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TqAPnM8e;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D222606A31B
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 01:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D222606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TqAPnM8e
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a8cc11ac42so170411c88.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 17:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793927211; x=1794532011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sli5Tik7wgGinR9EmKOShOO8llB8BZYKVbdNtNJa+KU=;
        b=TqAPnM8eT4V3Yp6wyLQNwAKn2r2fSx7tX0Zqk/qc7IB8izI5Uozb/tMECIjjGEafiz
         1XFCiZQ2hOtqvr4d7yuPXl9kI9njiF+tW6Yk9lkVnHl3M4XW0XVZfynrDFsevN4wVOYK
         wwdDhHPiqM9KD8T7mdEkr/p+auuAZnNazL/nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793927211; x=1794532011;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sli5Tik7wgGinR9EmKOShOO8llB8BZYKVbdNtNJa+KU=;
        b=ejWEz+T6HrI+uNkT6hqfwV576u1WqsZyInSSa7VBQapMYgXU+lo0vEhrEfr0O7oSO0
         xrExb5s/PzZ5WmKTjfblaM7Cbx75CjGoQ/cCiwfHjtbkHLX+bFwvB07Zl4qwcbwmW+Cd
         cmsgKGZ/JcLrc8IxGmo/FEnPzJj5gcVr5Py/p56PeTDjmCgyVEj6NRO19UJxWBMnRPIv
         PZfZ2MFWu6mfWY82XVSGxeZaVWHgBsdHEcb+GdBkf7lf79M/1aT++YYUpx87d26u8uWE
         znfDHtKPIRx6X+Us2e8fz0MmMV+r0TNnpBBtpyrJOye7dMTXuQhrsi4KaBDIw53HtcW9
         KygQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGivgFlmB35EHBIxwLItBMwkmtE6jGvz7kjsKOQLfgsOwKpR9oP/zDcsNj/PA3eDDM0Xu3Awtp9A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/6TwNbxs8x9X5kZZVRaiJJhodJxSOBiG7pZHV+wRETZEXiOutI
	yE6V+H+vWLRGlD9IodMlmEv+QjRdBMGKUuEqjBTD98MIWieuMljJbBWLwMSYzF6v4A==
X-Gm-Gg: AYBFou1cVhnRaKl5ofeU5MH+NEMZ7C3YPsbtabMVSp/RS6Wv0GSxlrWMZzhhrQ4fFL8
	8c+JErpKDd/Cy5TXT8ANVRueL7SeNXMcTZn4sbqgeHblZ1k4vHBU1seDtUoAyPAHfcoyOZXPZ0Y
	QctE0JudJGkEG6QoCJpn0C2KbGaWmANm2GTqcsOnCF+2ZThpJJGTvXg/iO1a29zu4esUIe6CGwH
	7uWw8gBIWwa56y/farkuc3SgCS4BFl0KuMr976M+3GNPjzuMAjWnfh2+Cjk4YqTiR5aoDfhKVde
	Pka2Sa/HopNFIfCl5fbpZ/9fXgEOCyPhsc2jrHSkqR3yg/AbG2gpLMRlvwX96NUwnPdMohe3ONP
	+gpv01zRH2ECCMk2Rrojg3DxvU4tqW+6uMH1M69op1UQLM7aDTSCz+ZzMBYHE2yCgu8yH3MBEQk
	V1EXxPAbq7gQiYVqDHrUcNi1vQvPUR+2YIlhIhminIVrLXbwKUcV1gnyQBtYH+7UxXassawyOuC
	8j5VrFJIY/4qVeDGke+GXlvph1Mg0fpkRC7c9KNDrsFg6iikFFGMSWDZGNyRzFbIyg2eVaPph0+
	l6BUd7kC/+n1Fe7AHMj3Ha4rdgne+tR0i7TUY9rTdV1X80Mvtkpm7DkJeemaZZqrlbM=
X-Received: by 2002:a05:701b:4246:20b0:1b2:558a:d769 with SMTP id a92af1059eb24-1b25d28c272mr1042791c88.4.1793927211233;
        Thu, 05 Nov 2026 17:06:51 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:bb6d:e00d:d359:7933])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b25e407bb5sm828381c88.1.2026.11.05.17.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 17:06:50 -0800 (PST)
Date: Thu, 5 Nov 2026 17:06:48 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v2 3/5] PM: runtime: Propagate last_busy from dependent
 to dependency
Message-ID: <au0oKFb9CmNzc6Cg@google.com>
References: <20261103221717.3840215-1-briannorris@chromium.org>
 <20261103141442.v2.3.I40c0bc917fa0b13111251844e9a54feb1d9cd7d2@changeid>
 <CAJZ5v0jWCz0XDgzeETbmMfGOmvh2G9qcx7xLODrpQ9NiwsddKA@mail.gmail.com>
 <auuICAm4BC_8Pzs5@google.com>
 <CAJZ5v0jTX1FgeS9FCV=+V4uacSgLQBVsSPnU27ybgUGg57GUOA@mail.gmail.com>
 <auzlLwlleGLPsLcw@google.com>
 <CAJZ5v0g25xQeRaLJWJyAo2fcJko+gZ7w6JhX7FzMgRx2+uuimw@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g25xQeRaLJWJyAo2fcJko+gZ7w6JhX7FzMgRx2+uuimw@mail.gmail.com>

On Thu, Nov 05, 2026 at 10:18:52PM +0100, Rafael J. Wysocki (Intel) wrote:
> Of course, it will not prevent the parent from suspending if the child
> does not attempt to resume it for a time longer than its autosuspend
> delay.  That's by design and you didn't have to take the time to
> demonstrate it.

To be clear, I wasn't just trying to demonstrate for fun or because it
wasn't clear. I think there's value in putting concrete reproducible
test cases out there. (KUnit is an easier common ground than some
particular piece of obscure hardware.)

> The question is how often those kinds of patterns occur in practice.
> Or IOW, whether or not they occur often enough to justify adding
> complexity related specifically to addressing them.

Well, I tried to keep very close to the spirit of the actual real
reports in question. So when commit c537d3457542 says, "As an example
[...] cat in_voltageY_raw at a 0.2s rate", I think it's not a far
stretch to test 0.1s too. And it's actually quite odd (IMO) if 0.2s
behaves *better* than 0.1s or 0.09s, just because it hits the parent's
rpm_resume() more often.

> > On Thu, Nov 05, 2026 at 12:59:24PM +0100, Rafael J. Wysocki (Intel) wrote:
> > I would love to hear your counterarguments.
> 
> OK, I'll say more about that tomorrow (it's past 10 PM here, time to
> go away from the keyboard).

Great! And don't rush on my account. I'm interested in eventual
progress, even if not rapid. I'm sure you're busy.

Or, maybe I should have gone to LPC...

> > I don't believe your solution solves the problem,
> 
> That depends on what problem in particular you mean.
> 
> It addresses an inconsistency in rpm_resume() and as I said above,
> this needs to be done anyway because it is not only related to the
> cases when children or consumers are involved.  There are other cases
> in which rpm_resume() gets called for an active device and the lack of
> last_busy update causes the device to suspend earlier than expected.

Yes, on second thought, I agree that your patch addresses a real
problem, even if it's not (IMO) quite a full solution for commit
c537d3457542's.

> > and my solution does while also handling
> > the inconsistency you mention.
> 
> I'm not sure about that.

Sorry, I see that part was inaccurate.

> For example, say a device has an autosuspend delay of 2 s.  Say it is
> initially suspended and user space writes "on" to its "power/control",
> so the device resumes.  Now, 1 s later, user space writes "auto" to
> the device's "power/control" and the autosuspend delay is respected,
> so the device doesn't suspend.  Next, 1.5 s after the first resume,
> user space writes "on" to the device's "power/control" and the device
> does not resume because it is active (its last_busy is not updated).
> Finally, user space writes "auto" to the device's "power/control", say
> 1 s later, and the device suspends even though it can be expected to
> stay active for at least 1 s more.
> 
> How is that going to be addressed by propagating last_busy from
> children/consumers to parents/suppliers?

Agreed, your patch addresses some scenarios mine doesn't.

I also agree the power/control behavior is a bit awkward, although it's
not very convincing to me as a use case. (Arbitrary/periodic fiddling
with power/control seems more like a nuisance API than a real expected
use case.) Or if it were, I would suggest solving that by adding
pm_runtime_mark_last_busy() to pm_runtime_allow() :)

To me, a more convincing one is: a non-autosuspending child with an
autosuspending parent, in a situation otherwise similar to commit
c537d3457542. The child is not likely to intentionally update last_busy,
but only implicitly via rpm_resume(). When you solve the inconsistency
with your patch, then it enables my patch to be more effective w.r.t.
the parent.

> Note that I'm not dismissing your proposal, I'm just having doubts
> about the need to do this kind of thing in the core code.

OK. I agree it adds a bit of complexity, but at the moment, it seems to
me like the most thorough way to improve the ergonomics for clients
(drivers) here. And that's pretty much my entire motivation here: to
improve the ergonomics of runtime PM -- even if in this case, it
requires a little (core) complexity.

So, I'd love to hear what can make the ergonomics better here, with less
core complexity.

Thanks,
Brian
