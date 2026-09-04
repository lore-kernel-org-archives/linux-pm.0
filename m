Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780C435E93B
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485430; cv=pass; b=pHw4/xtBCIfKZBDvTRabm4VcnyFcIavFtBiMcNGTSFgiR8RXS92UXHYesUXbftRKJLrrBw2aBR+Hf1+RBRw7/7jr09/ASFvZLfhE68VFWFAbYCK4ztnC84Zk9yWWh5enKvmT0WuAezRWS7ViLCwjoT8X7EUedP2OV84Sx5KZBX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485430; c=relaxed/simple;
	bh=SYDvkh8Gqu4VGwUGF72ItVZ97u41+W0b2kbxS8TvHkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgHsSh4uLA9QU1yCmdEJT9TJchghDAegF+MA3aJRoUAHxU7jxVyezEDAyc9NyhIjwimjGzGlFUaHOq0gdQSx1SX+nPIZUDs4vu7aJIaDX6qT7GVZJyRQmuKYER/orH+HlxbURxRagJTGF8AIswFyZQ8GO/REo3BArIseKZnPaPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MtfhBwNw; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MtfhBwNw"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a613a6bcd8so3054a12.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 18:30:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788485427; cv=none;
        d=google.com; s=arc-20260327;
        b=bBz8dDp6I8mMGNztiuJvr21Oryn2Q2j1Uqf9bZIxbEbIloCftfneOWeWFXKxhNoUN0
         fVOblX2X7GG1JIXfYFiu5rCd2lv2NIUHulgtVbLSdTxK5mJFnAcecPdRQAYB3qNQSxX5
         Qt5aaDhKhn1UD7J7OrIL8evmZeI0WZCWjuqcOch6HlRETdWvStFsjOXsQtY2wfM961/M
         6wYJb5hJeoGHXdsQ//O2T3TyoqfRQRgKB2olMf9js+DXJKEzCLciuIGy57wCPr5OYw7/
         NcwIPyV1B2jyoa0Zm1zNszNhXvMq0fH16Ic+4aUAulG0YiLJZ1RNpOLqpUwY2Q+nPkst
         FqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SYDvkh8Gqu4VGwUGF72ItVZ97u41+W0b2kbxS8TvHkA=;
        fh=QFNk7tw89Gan6eF+e/OaA7xOydL7VL2/GMamQd2SnGI=;
        b=aFSC4bG/zCQDPamTIibmSv3XcBy6o4/6GfmTujyZBhNywspVpd+LYXmLTDGgn87xnL
         D5G2JAcnJS7lVF1L1ILg3xthLErgNU4w99lKdmWxERC3kUM43aZPVjPSFMdYgABav+UE
         mpSMBw21ljGtLXprdk/YttdrvlB3mf6kT1WTdg1sgG4wc/sn7Vylr0r2mH45bo/4znuU
         8lkDgd4n9NE/JCsMP+CquLUnw1mswgs46Mctr0gezTl6fbyG4LQz3hTAGcH8eMTQkCrU
         PDQSAWhfPw22ndD4ngQJNdBlFLQ7QtKf0zuxQQk28UqtYg2wSLj8SU0Sh79D/9YVa51V
         JqVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788485427; x=1789090227; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SYDvkh8Gqu4VGwUGF72ItVZ97u41+W0b2kbxS8TvHkA=;
        b=MtfhBwNwaCmP8XDB4GsmJPDTGt9G4tUlQYhGcCZ1xj8Htm7Y2ex6sp+ShcjBHwfaIi
         16Mrrxej+thURnxSf6CeOXVqSeWXGJo4TAjsC1SKZLZVMFfipRIpk+mXWdy0Ro3530bS
         JoNHGrirrSwrGReEJIlcjOz20N3o7V+BNPoVDlv8SSq88DoAM7lytMYwJ4PQ7aC1z3I/
         AvKMJ1426IXCK+o3+PV0GZYB5E0+lxiYRicRzt5VgzNAXpwGsgWQQ1EdScUu94LD7vbp
         boUbC0tRfKtiN+Nj1qahH90k3t1pr9VcPNqKzOMKigGjjiqObbN0qQD7cVIa113N3AcC
         SYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788485427; x=1789090227;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SYDvkh8Gqu4VGwUGF72ItVZ97u41+W0b2kbxS8TvHkA=;
        b=aSDlq//mjCFBlu2hKnEk+83MHRAasYjInovtTY4Vk8wDm25lOMLIqfrqNxdx5/EUSX
         Srbi5uuTDTFrlhQ9LXnfFDHgQ85I58qgd0hYYik8eBDJmsjtzo+jrME+bWPuflsV7eG2
         zw9nLYorrK2wnwVp+sTCMRP84xaZGWUG9bT8w7Oy3neQ2MXnnunGVV1878IKj+9ye+Oh
         f/WNFVXE0SSxFIzvumrvGVkp36Q9H5wf+0XsDzSEHTu6LoKRisR1rR3hT9uG42aYWSZb
         cEGhnxuLiuspx8sMy1GIByoUg88PcIjeUyeFsGRu+/tHpDIyW+og02c2OLIYxglCkUoD
         jEYA==
X-Forwarded-Encrypted: i=1; AKwUvBzGnnKSlS/vBcxEhFghVwDarZAKqLIU6VoAq+Qq9DDYZH4HG3vcOZyw3HuTZhoG/vyprDEEY543Mg==@vger.kernel.org
X-Gm-Message-State: AFuF++mz5lc22Ig2MKU8xwkaMY94OC9+fS7/NcJoRMpPWtyw//rK6aHB
	tpsigyugg2GRSGfARnClOTMeDjtTob+6Tn/3QYl5d+gmxP96SKqiKhKNYumlBU/7pwEXsf2k2uo
	aYSGWF9dGCc67JkgrTEbD8AtaNGpiFKUnXl/cHik0
X-Gm-Gg: AYBFou2lHwyurHZ7T9fJVM0YmjU+8S2AUCi27ovVB9lkDkeM6tdFsQ65MGWlk+BQP0Z
	SWj2sw+izIGKEBqgus8lPHr1/b5JR/zeqnLNKEcyIq7jI/uymcQs7UA4uIJS4QL3jcvMRMwv3a6
	OaWXTqffp9jYhqKScSvensxeY5PppGPtW7cYev0jB62b7hBtalLN7V2vL6xDU5uo6OZkGXSl4qL
	ltkSMvEb/1tMSpxoDWSJjUAURVRStJfCN07gYsvBeZaQU+eZNsO8+HITvpDF8hKJbpqitUUd+/2
	14EIYvwJfuxEZW4SfLdGtDeSg2Zjen1YLoU846QIKGs=
X-Received: by 2002:a05:6402:1154:b0:6a6:76c7:65d0 with SMTP id
 4fb4d7f45d1cf-6a7e9dc0cedmr7971a12.5.1788485426203; Thu, 03 Sep 2026 18:30:26
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831130129.3979454-1-beanhuo@iokpp.de> <20260831130129.3979454-4-beanhuo@iokpp.de>
 <CAE14pddCf1VhLVC_H-Nv30C4BzK_UO4Eknd27g72d1nAjdBdpA@mail.gmail.com> <f1e59607ab2f5554993dacf21947024e41278058.camel@iokpp.de>
In-Reply-To: <f1e59607ab2f5554993dacf21947024e41278058.camel@iokpp.de>
From: Stanley Jhu <stanleyjhu@google.com>
Date: Fri, 4 Sep 2026 09:29:46 +0800
X-Gm-Features: AcwNN1WqpKQ9dvQE183nH8HsNdiEUkNRgZ_8L4LRNHHVTD2yt5OLSz9J4XIN8jY
Message-ID: <CAE14pdffhBju7fdez5Aewzz-rBCoRWDuCZJrOej9iJrFCR5+HA@mail.gmail.com>
Subject: Re: [PATCH 3/3] scsi: ufs: core: Report the current clock frequency
 to devfreq
To: Bean Huo <beanhuo@iokpp.de>, Stanley Jhu <stanleyjhu@google.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@sandisk.com>, 
	Bart Van Assche <bvanassche@acm.org>, Jie Zhan <zhanjie9@hisilicon.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bean Huo <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"

Thanks for digging into this, Bean.

> That holds up the queue for up to a second only to set the same OPP and the same
> gear again. This happens today, without my patch.

In Non-OPP mode (!use_pm_opp), devfreq_profile.initial_freq also needs to be
initialized to clki->max_freq. Otherwise, devfreq->previous_freq remains 0 and
devfreq_update_status() drops the initial time_in_state accounting.

Thanks,
Stanley Jhu
