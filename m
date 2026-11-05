Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889799;
	b=qyynZQwuBZiV+LT3p17rmS59MD98zidkHV7fcPx7d63kUY4OcjPRohgm83hM1it4v4Ou
	 2yq9VSNF4ADfZMfbnALm19QmRrC0JLz2pDX4cblmJIiNfZ/9pOAd4lzdoJEQBLnVswBI4
	 otPyBzD4RboVjKe33LiG/EFWE9SSq9V0WSW4Sg6AjnUWEDfuZeszyAmiyvlgwZQIR6RRd
	 KRj55j2A8MSZnddqGIz28JuP7qNOuwnRDgM8wNatrc5xlvqhgd0qvTARb66SmyX1dUwQZ
	 LaB7DQvq4LNlKMDRlylPXNWcRFo1JOQGebodnGi+EHj535c4PoeIkCrbj8A5EAvViuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=wk/So20xr62QzWata5h+JuMn7QiKllnw4EsB0QPRdZA=;
	b=KltFOPVCYDdrKRMVOSKoGq/1NFEHnSL4zYDNhphgMe/6vGZpJnEEywyhQarfmmNJfDU+
	 oMZuYSHDoAL3FYjucMsky492chNSpZRXIHpVx8Q5stlrUf5gthj657smFw4YoAVMB33aF
	 +wucXXPI4jeyGpxcul3xFtfF6Zg3a82t4JiyeXIUkCD2iCq7p5LWrQ9TgDeQHsY30bEkU
	 exowhvc/2QkSPlCSKRk6RllUUT9Qs9E27aUq09Pfc7+t29QCy6xHEc8OXS7xU/55m3rhL
	 +w21zNvPIUBBrq7cTxHEKzZTRxLnQ7Tt9IA0KQmfDsiXm/5JDxSuc9FM8pwrkg1yj7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NiU6VXsz;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1332F606A32D
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 14:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1332F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NiU6VXsz
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36a3451ea93so2735552eec.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 06:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793889793; x=1794494593; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wk/So20xr62QzWata5h+JuMn7QiKllnw4EsB0QPRdZA=;
        b=NiU6VXszwSfPXrvc0ev7LGdQIIoSNzyClwMenodgW9tHkL7rHggh1SXl0iWN7QHbyR
         T7wqatl/b7ghNIDvQjtQP2wfCu/Z5qTCeLEOJ4b9a2zOkEljQsMQ3velrPbzt9xPQD+D
         YuHJm/G+1LGKZY4T6ymn2AFQMNrzJLyhH22hDELC5IAIlodZ8vw7JspNG9VR0s6h9ip/
         lCPlLIjXqPfDHI4Cr7ZW4z0d+dw+u13ff5R/laSywid6YhxqMGrG1liqG9CkOqhGFcfb
         IBABQDwHDmm1eSNB/msmmRVJmLsfBGD1V2pfRpPkrdmAkT0vFlJ8hrPWmaRaEhulaY2E
         zkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793889793; x=1794494593;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wk/So20xr62QzWata5h+JuMn7QiKllnw4EsB0QPRdZA=;
        b=huAFwwwXX4CKgAXtNYeQSJXd0GIscFzIaL83LH+hA7/fSjIk+K7BsldGJtXD6whTOA
         uholSnEGyfiVwdBzIcPWM2nUOl5qRkj7S1Oukrgc0qdlbq5ChAmFS+IFojP8JsJJ2FTe
         0kr4m/gnFKI9PdPNS11wzbRhDd3wPH6VNjzxQxKJ6sLz8nqPueqc1PIQWo04icSDC7Go
         mKomTlp9doImVoS6/yrE8wfCV57eEaAPgrLmP3fwjl0fewSBl5NxWvWALpqZf59lZ/y7
         6UVlCbRmv6WPMVAbQFaYqYpmpPogh3YFwAzjFLxId6F2HAZNlQtSoRlMRY+/eRzjsGrS
         1G+A==
X-Forwarded-Encrypted: i=1; AKwUvBzvDBMfs/2GeQMDX7cd4rNTp78fprE/USkuqKROZ/CkKS9uo7cSG0nv8PQDzp3UzcN9Bk0eNotwVA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/xWVCBXTeolIQDNVw8OhBfdp9Q8EFLwJgdFvwtPjJ2mIMH7XRj
	tJ+hc5wQ078MmHjKzOzXz4Sv6ytnmwICTTtveTBkSjX9NOvam9cOoF7XsXWcMXnSvmTyU7I/MNr
	k+x21tpI7UDpasbYGP161uw==
X-Received: from dyu28.prod.google.com ([2002:a05:693c:811c:b0:36a:15cf:f589])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:618b:20b0:35f:2858:aa4b with SMTP id 5a478bee46e88-36a4241b070mr26273635eec.30.1793889792660;
 Thu, 05 Nov 2026 06:43:12 -0800 (PST)
Date: Thu,  5 Nov 2026 22:43:10 +0800
In-Reply-To: <sashiko-outbox-198692@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105071518.1458428-1-stanleyjhu@google.com>
 <20261105071518.1458428-2-stanleyjhu@google.com> <sashiko-outbox-198692@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
Message-ID: <20261105144310.2626473-1-stanleyjhu@google.com>
Subject: Re: [PATCH 1/2] scsi: ufs: core: Skip redundant variant resume after
 error recovery power-up
From: Stanley Jhu <stanleyjhu@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>, Brian Norris <briannorris@chromium.org>, 
	Can Guo <can.guo@oss.qualcomm.com>, Peter Wang <peter.wang@mediatek.com>, 
	John Garry <john.garry@linux.dev>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Praveen Talari <praveen.talari@oss.qualcomm.com>, linux-scsi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 05, 2026 at 07:42:29AM +0000, sashiko-bot@kernel.org wrote:
> If a subsequent __ufshcd_wl_resume()
> fails (for example, in ufshcd_set_dev_pwr_mode()), it rolls back to
> vendor_suspend: and exits through out:, which clears is_suspended and drops
> the clock-gating hold without a matching ufshcd_hold(hba) on future resume
> attempts:

This review was run without the prerequisite listed in the cover
letter, "scsi: ufs: core: Keep clock-gating hold on failed W-LUN
runtime resume". With it applied, a failed runtime resume keeps
is_suspended and the hold, so active_reqs does not underflow.

> However,
> ufshcd_recover_pm_error() only marks ufs_device_wlun active if
> power.runtime_error is set:

Agreed. This will be fixed in v2.
