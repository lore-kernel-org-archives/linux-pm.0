Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A085437E7
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654626; cv=none; b=H1gOQBnkMb9CcEXOHYvBYzPB7ihysSvGhritVhtSd+RP3reOiho6ScK/8kHRGrfKt1ybVyMKvrag7o6ias/OLwQZIKt5XzvB9EUsu9iuhMIUk8iKiX5XTrk9HkUU7NveA01h+70VAl2zLrOBiyFxH8FzC2MuT8mnEeXhd9M0gzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654626; c=relaxed/simple;
	bh=wiqEuG8/cSEg7rIA1EdKPkNp8t3X+jIVQg7jtFMc8mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNosk5Oc9BlAy86ApuCUSV/1lwiuJw/0d5MMNIDQMuylnF854GlCCssJGLSnqWWF5CoQ/4nmR7dQqVUIsZbHHeMsaSgakWSgL0O/BC+Qpbf4yh6O8j/vdq87KFhdbFT/GlKxxg2/PfQBIDuwd2s5nRH23YqnZCUKBnoAI2FvYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbGKCVue; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbGKCVue"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49fbca514f8so1666415e9.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 07:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789654621; x=1790259421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wiqEuG8/cSEg7rIA1EdKPkNp8t3X+jIVQg7jtFMc8mo=;
        b=RbGKCVuedKx3vs+ffEOxw+sZWVVvWTA7OP75LquQFFL+FEBiifD9GNUIId0gSfsk9R
         JISEhGH1wDGCQiZrpfhRwL6Ipw7EUa0bP6rSrtiIrKIiKTGc+dkDmdH2/dRwdbCouWRJ
         9S4taRq3bMobOw3+PM2YAvW9G+R+A2Dwux9Ikis1PQELHiVz+vsZx1tbAy15G4iBEZ18
         xM3fyxcY6UysQRImFLIcCY/ocYwBxDhdgKFYSSKOEiz+Cu41DpsY+pZB2DwjQM1B+l+Y
         MAH1BLJdDnlvwlzL26yOIOvJwBbndubT+m4jWGDw1A8HBmemUAGwTn55lApvzfVqzDLh
         Xnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789654621; x=1790259421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wiqEuG8/cSEg7rIA1EdKPkNp8t3X+jIVQg7jtFMc8mo=;
        b=BdMyy+5W1Eq/5/TBxAwxo5cz9PSe5fNB2aZ+KlnumHtveYIcm5o6vdpSt8cxsIrR7o
         Kyit8XmEdG8K7V0TUCZw0rcZatBOAC7vMui3TaoK4r6TAlHY/4339f3qEjUI1yfW9uvU
         BGhMfRw1dnt+uZ4EcN3zicxZXCE72mvvcRpZ6Exmrp1gtPr69sbWtrL4ADIAjuON0OJD
         CqgHqsqMVQoCwgHJ6rlBKbYt/EvbgugvbyXVCZNdcf6ZgeCyiz5fwq8HJATH+dX9F4y8
         kbWOYGmaHqNtCRCn+sz8KTZe5stwtoe8BUI3G7bC1VdBPmb2hj2K/ojFJRsYN55eBwXK
         4AgQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTAFyJo70IyTWyNfD4TMjLOyBe5wwvLc6+dg/NXbvi2g8oP2wHsqIJO7Ouv/iiid0za2fUFjMaLQ==@vger.kernel.org
X-Gm-Message-State: AFuF++k4hlvuakhavjpkGu2l/ZYF0BYxMDLmotchq8d6R4KpNWFKROnn
	FyCNksxVdlt0GNswPTF2JWrtqfddezIGSSh4NXEqCBytB/5O0isIb/hR
X-Gm-Gg: AYBFou3m+mF4cuV4r3PaZeT2HQuICEJ54n3r4F1GHQoo4hq+41M/oxyrr7Ye6kFPoF3
	hZPQVFjyq/gB9qOeSNalRkdCd5yA9coO5IrM81KBsk6ZJtbbP63RNy2/dzUmkb5ykDde4dtjb24
	/2rwSZc9/6JWA9Bikk8HjLGN545ef3HmQfLYGYN4tUb6w0IBIeXIqjESgKYYZOrRBqZG6K3ZUnb
	zpnU0eDPK9cZCjZPStpGXKe8AiqXoXm5SdOGc9CzrAQo/C0Mxe7GGXElmNTnIYjkrdV8NWgDGvh
	sWBBxtzjT+eRPIO1PPtkIhq3kkTZWUfMurlaivoIfc6p5byATAEDBFGMDKD73/JribhoPwxR5Q/
	goB4NQctzJ0o503N99UZDdfCaTf9oQnEigCf/RNfEPYYG/WYHf8efUTDca7ECdkhSMqDhKf6YZw
	yTujo+OpudGk2YnLROLenNT3+skGvbFIH3D47fbxr6F/Tu7JO2Ka8E+Z4tAAij5E7T27hIJIo4V
	Faq0mBUCRFb7VLuWizm6XQ=
X-Received: by 2002:a05:600c:3492:b0:49e:7c8b:fdef with SMTP id 5b1f17b1804b1-49eb7329b2emr73332995e9.2.1789654621094;
        Thu, 17 Sep 2026 07:17:01 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd247809sm134648665e9.11.2026.09.17.07.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:17:00 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: christian.loehle@arm.com
Cc: beata.michalska@arm.com,
	cl@gentwo.org,
	daniel.lezcano@kernel.org,
	dietmar.eggemann@arm.com,
	elif.topuz@arm.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	rafael@kernel.org,
	rostedt@goodmis.org,
	sh@gentwo.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: Re: [PATCH 2/2] sched/fair: Randomize equally shallow slow-path candidates
Date: Thu, 17 Sep 2026 17:16:57 +0300
Message-ID: <20260917141658.14490-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <b129997a-8d49-41be-a93a-7e0343c952e3@arm.com>
References: <b129997a-8d49-41be-a93a-7e0343c952e3@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Actually about the last part, I'm leaning towards sticking with v1, because
> that is actually the current upstream behaviour. !idle CPUs currently trump
> any CPU seen so far, but preserve min_exit_latency, therefore sticking it
> into the shallowest seen reservoir is consistent IMO (although we can
> certainly debate if that should be the case).
> I'd prefer sending a follow-up with an idle helper and making a properly
> defined policy there, but that's adjacent to this patch.

Hello Christian,

I could send a patch about this if you want, after making sure about
everything, obviously.

I'm a bit sick, so if you say yes, I could be slow. But I don't think
it will take more than 3 days after your answer.

Thanks,
Kayra :>


