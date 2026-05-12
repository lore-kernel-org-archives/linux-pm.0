Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54D538C429
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578979; cv=pass; b=UFofAElAFvc9jlyJ3Xvsb4sOFGPcV1kJw4tbidW2UsqGjNbzZ+qLdlvfp/r0N/qppixQWyr8WXVznTZwCWn75PxSl8iHocCx4X3VTtpcgIjRrkvEOhYSZIycaptTgCCTVQuuJcl0EXUiF+3lCp1VLESx5/rpmS6Qr8+7G1TAgq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578979; c=relaxed/simple;
	bh=s1OOCWLODmyroeZNuSEN4pTGxnWil2MCytCdzrB/lk0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=V0njw0CKQ7iBBSvq9JfTZ7R9Px2HT/dEaut1F28lg24eQfvoSvJ59YzP5BEPmv2433PayjA4VhmIO8IVot8Q1fJ5uvjhgIM/bnqZmr9v9hpvABKq69nEYlIfDMaztovEvKxH/VNjrX9yI4D57/kkshV8Q3h6g/pM+XONrXLbQkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxBGjx8e; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxBGjx8e"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-366070f71adso4745710a91.2
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 02:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778578976; cv=none;
        d=google.com; s=arc-20240605;
        b=TTT02J/+76n7PRqpZrKOWJFNcEa6Plv4+ANlNHsH7TWXTVYTFtLzrLUVzCin5Zuxqo
         IlxrlU3c/xm7MPiuhwfHv1xgThEse6dgyY1f0DEbeWMy5qERDPlIx/t6oWgobr8iWWQK
         wW81qk8OVULY7Ojkr9keMJl640GUTR5ZeCe4EIhIRLZ/eECYM8b+dHMdPVjVMiLmsnhy
         pF63exDcB8uvnW1cEgPUs3162fmjtEqvK5AQVXyAPRE1D9Gk12hBuwP/bi/KTC83hRZt
         UNNRMxML0kjwuQWkyO1NVebHE3gGa6847LCs2r4YEB2MTu+BCb83IIXOAunCmlKp/ydm
         K71g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=s1OOCWLODmyroeZNuSEN4pTGxnWil2MCytCdzrB/lk0=;
        fh=0WQXTbm85gSCyscIEAd1gWeHGSidmoocSTiT0vGnOW8=;
        b=KpZIr36rIOCAqb5N4hiUwap7YLIX4PIpbXVm806QBeZZiGhyKEThIE+Gq69Vc0lHq0
         /BMoDoFnRpxdH6cAZyKVV3GxAfryuZr7+N05JQfoukFUOm4NvuuhuVM6P7uAo+EQPddP
         UkI51Qvbt18f/tDNSIDx3g/clPulOVGzvlok1D2QHBS7GA0jF+c0jFYfc4nO+1T5/1Uj
         efG/dCdHES0LsiRwOMeV8osUmoKo0n2Nh5duUiTzo4QY6Pze4hnXKfgNbhlyY/MAwQtr
         cVvDbIHizm7cs0idZnyvd+Cfll6NM/lI66mBtgt0/VhxeZ/mPd6RvgnCJTstF6wzIJs/
         xJxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778578976; x=1779183776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s1OOCWLODmyroeZNuSEN4pTGxnWil2MCytCdzrB/lk0=;
        b=hxBGjx8eXH/xlesgd90tbK/0Gj5JP/tdt1niCksHtO4MCyAip9n+oxtRVf/F1v/v0J
         R+lUVe6dQokEqeGi14ifZKWYPTGPHik9Yn+1cA6PSOEGjbJ6JzNek3fKquHRN1j7YqIP
         VpGaEAe8y9CTc0I4U11PIdRwB8Fyv+d7N9h5UL/x0jVEDyKO9uHqORgCTgQmpr6t/BfU
         sypaa1XzQYFY1SNO1rwzuqTN1Ebl5RM9jYpRWFt1M13uXG0xNCDPEg7rZaMyfglMpfhD
         Z3elsbyMdGUeE1kD7D9MOJcrLkND2nxXkGMR2XsaTlQUwlBtfvObxMbKdbjGSi4wD8XM
         0thQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578976; x=1779183776;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1OOCWLODmyroeZNuSEN4pTGxnWil2MCytCdzrB/lk0=;
        b=JgkZ1tohf8YTQGqcFj5FeIUzSlBSalwZnesZcW/8E/WUDy659RE3nN1AvMvI0SxZGN
         xJclA0TIQ7i54DRiRoPNQ/H9c7n39wVYUyWuR733+ZG0pS2h3GtES67Eo+O3EA8juFjV
         Fl7RwQpVBBdpYe7mQGYtau7YCG5nGT9m+4zZcQEzBlkNTTN+6CCVA14dCTX/OVRcK/B+
         HB1RM7M1hB0SL+LXKpQN9E8ZIzU3sRxpSmLGia0zDHgV1o8a3KNahXMdlUvJOIU4prYb
         ilZHm9AJ1CFxqevYHzKR87577wvIDTHDKdr+cvGn5s9w9aZS5NUu9TYgzSky4ayrONXY
         nChg==
X-Forwarded-Encrypted: i=1; AFNElJ/qy4ya+Xnybu4280bbxmHjBXWFhVoaQMc8ClR1LOlcOjxr7Qd3MrkzkgrCOrnNVi1GR4OOZXEaMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6umSxUH3eaWYpcpleY1aCgKRMAaTIMzVMxElbf1gzvKpl57g5
	hSUS1+ddVUAO9YT8Wh+kmKhue+cVcKsJ5+jrjJ4WfBLMO0rUxwPL+SbQcP16pm5pq6iU0A0T9fR
	n/IcLaZ+AlL8Gl1sFoWe9UXMMvJA3g0c=
X-Gm-Gg: Acq92OEDulmI080Wfgfz1uCxzyj//rO2Qwck3NfXrZrqGrVS9upG3vvICJGiDN12ARa
	61JYLsJvH48KdQ65+F4ulSsBwIogBLpvmTttKbfVG9VixgVjVAn0VPrJJDq+nACBdWUeZzaQUT1
	8IgqyhRE4DxgS2hKIKzbQtR7zMhamdQYiLai4MpF0CXeriTHFrFmql1jEvhm6W9eJxjVAlOEFSc
	AzDAfeznkW07i2b/F4pmsAH4bHR4oV++gIpS8kngpk9jbDyclPsRzf/AMSWqrPAUztWKcObHTuR
	jXZMCY4huDdXOLTMvXJlMIyT58u4yDfONfSPvqjN
X-Received: by 2002:a17:90b:2f4e:b0:359:1130:1047 with SMTP id
 98e67ed59e1d1-365abe8c511mr28287381a91.17.1778578975903; Tue, 12 May 2026
 02:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Arun Rao <arun.rao.bl@gmail.com>
Date: Tue, 12 May 2026 15:12:44 +0530
X-Gm-Features: AVHnY4LClgZTeSogklM5klzYgIGBPPxQMCEVETX2llXKICl6FhLrQ79-z4quLNo
Message-ID: <CA+2hknjQ1wLjXdhZWezW=9BwcUhoXhXR1Yi=N8bhce-Qe7+RFw@mail.gmail.com>
Subject: Re: [PATCH] docs/power: note Btrfs limitation with FIBMAP for swap
 file offset
To: hch@infradead.org
Cc: Arun <arunraobalappa@gmail.com>, lenb@kernel.org, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, pavel@kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"

Understood. My intent was mainly to document the current behaviour
observed by users on Btrfs systems where filefrag/FIBMAP-based
guidance fails, and to point users toward the existing btrfs-progs
tooling.

That said, I understand the concern about encouraging users to rely on
resume_offset-based workflows in general given the underlying
fragility of file block mappings on moving or CoW filesystems.
