Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A786C44CACA
	for <linux-pm@vger.kernel.org>; Sat,  3 Oct 2026 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791058421; cv=none; b=rAUt9qYoY0xdUgC51GVnmze6Rk4i4CFnc+T/b69Wq+a+bjy31LN/Dms4xK6eTTbvZNhfpZORBX408z6l9tm5LBmp/k+jUfy9rOsYE/GLvmjfxQh5Yb9YYsvIwyJF9MbsVQZPG/2v6tljBwpvdAwZUtyJ+AB6NxO9g2FSZ0rURZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791058421; c=relaxed/simple;
	bh=1t1qtli1c0fGBAIs4rR6gtVlyNbR2p0DRjGpIq1uwSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDwf+nMcwj4yGdEtwtVWzH6nNf1mjl2QGaebyujGbf10PV5xqHZA9YPZE87JQrWc+EO/puGY5hoEr9SKy7cMrcfDJv/tDTsHn44zEficH89s/+IDPp5i95HUw20JtHw4OWC7No5uicZSyMVbwcfIh2wp2DC39TCGM0x10NPJX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW03YAIx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW03YAIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5581F0089B
	for <linux-pm@vger.kernel.org>; Sat,  3 Oct 2026 20:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791058420;
	bh=CCcBDb0H/ptFl8J//wMwf1cW1zMHUbF7lzkQpUx3g2M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dW03YAIxZC4SpeGr9eByiV13uyNT+znScf3EnA6LhQQ9VhFnRbrP7O2mdci3KwCSW
	 T+Rvq2bIB54EaVU+H7J46TUr8gSi6CXYYM+B1t2kXhdFHrSyuDsdI/AoTCUX7a9fAP
	 4RpzZlvF1bqj4jj0Q+8an6Hqbuz8BoPOT3O2NpNEEqjbv6nsOIUzjJlgWoQyZvNBoP
	 86ax+sYUDYr1YQyK67C9ToESNQ4ZxMpkPR4Svex8tjMve8iVs8FkdyJlkypEh8ht2o
	 fUc0iXj/lh3Bc0kPVu3Qgs1novbc+SXDZJAyEawEfXl7K0a3lDh/ghZ9GfRuX6pepO
	 /rFhZm5aV8Bug==
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6ae42b3e901so366383a12.0
        for <linux-pm@vger.kernel.org>; Sat, 03 Oct 2026 13:13:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxGmQ9RoI3MMFvmelGnNU5eYDBSOwNIgxSyQV6GPj1/ZZf+Q21l+6ZKniuMjd5oioqYbcWxk6u11g==@vger.kernel.org
X-Gm-Message-State: AFq9FYK2RrQI3CHoRBIoMDiR3rvEbJBMvRaDcb1d0QDeS2agNRGoET01
	jtHfOCTgtJ8uPjEuFe4jT2GLIhyxxwfVyh0Afeb2p43DRVT/bC5ObdAsRlv5o8/lCOGNscEghaf
	g5A1ZSD71AQt+nVa5eZrd+ahQMU3MNPI=
X-Received: by 2002:a05:6402:27c9:b0:6aa:e251:ecb4 with SMTP id
 4fb4d7f45d1cf-6af9e0468eamr5249349a12.2.1791058419271; Sat, 03 Oct 2026
 13:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001173039.934398-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20261001173039.934398-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From: Len Brown <lenb@kernel.org>
Date: Sat, 3 Oct 2026 16:13:28 -0400
X-Gmail-Original-Message-ID: <CAJvTdKmW_2K-O_qrGAaQkH3dG3KDJiUDVdukbd6P4jCZgoxEMw@mail.gmail.com>
X-Gm-Features: AclHuK84hUYdXVm-Zr2VLLe5W1_NjzjscJyccFwGrXSfn0ea_MwLAkopVv3abOg
Message-ID: <CAJvTdKmW_2K-O_qrGAaQkH3dG3KDJiUDVdukbd6P4jCZgoxEMw@mail.gmail.com>
Subject: Re: [PATCH v2] tools/power turbostat: Add rugged Panther Lake support
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Applied.  thanks!

-Len
