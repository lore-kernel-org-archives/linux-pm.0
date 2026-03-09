Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEC539B488
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055598; cv=none; b=N5J5DgMGxWxQ5Z4m7/Y7AZI67XPGrLJdS92UMnDqNTBuwx+7jVFQTENIh2Ea1prOWs/yfcGbORz2rLt+wQh8GsGgJZFbZ/nOwGpa+40XvVNPa+hTZNrQktqtzNkE+5anrOZLdnYGVGdDWZ5wBLmEv/Lhd/Ulqd1Xw1DHQYlHK8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055598; c=relaxed/simple;
	bh=gnXgtcRDW1An3EMD9lZV+RY4VCeU4JYE7FSnMdn11SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrsHTODPPUXhC5zEh+mYFqEAa5BcSfoyky2xIBOYH9nwgXRpu8dqzXi36bSvCvx1Wr8yoXUYtRF1zUsq8R0Y0/Y6lz50WXAImIO+KAvHVbXDdy5tztFowRCIZBD/CAhFGHsWL1nIPTFRv+BSidDP2Yj6insqgTvLdN8PVQ3a7tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FEZK8iXQ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FEZK8iXQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zlAE7xmA5OnbHDKhIFMGKCO1OAvPjP7zrw3FZsOeoz4=; b=FEZK8iXQecNdX97sbiEgzothBL
	fOWv6K2Wdtb9bJikc5C+qjHa0XbMqHgn6OjuTnBJp0h6tJjokmkEyTrDxph+ZZ2HywjgNNoBE7JAr
	KlDH2vH+irWhcZzUF44v6rvuOD0/IXwOGoNTfEFAQyRx0Sx+e+1Y25bNhXmo+Z0/yl4yaMT4mM5eP
	NxPDooC2+MXbyTXCBzXhCN5+54mBZy3bhmXD1ISAyGs+Gjw/EA4yWB29isZ9aXDjtv7mxEXzTzaRa
	KGOyEMBRXdPvCmb49tSTkxP4DkV+Omq0jBq8QbRFzq7/EHyemZl+oMEzJIQuOlAPkqAOzm4R3+/sw
	lA6vNmzw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vzYkm-00C1Jk-Gf; Mon, 09 Mar 2026 12:26:28 +0100
Received: from gate.service.igalia.com ([192.168.21.52])
	by mail.igalia.com with esmtp (Exim)
	id 1vzYkk-0038qY-En; Mon, 09 Mar 2026 12:26:28 +0100
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
	(envelope-from <berto@igalia.com>)
	id 1vzYkk-004MVG-0u;
	Mon, 09 Mar 2026 11:26:26 +0000
Date: Mon, 9 Mar 2026 12:26:26 +0100
From: Alberto Garcia <berto@igalia.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Brian Geffon <bgeffon@google.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM: hibernate: Drain trailing zero pages on userspace
 restore
Message-ID: <aa6uYoVKegcac2Kq@igalia.com>
References: <20260309001250.192841-1-berto@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309001250.192841-1-berto@igalia.com>
X-Spam-Report: NO, Score=-2.2, Tests=ALL_TRUSTED=-3,BAYES_50=0.8
X-Spam-Score: -21
X-Spam-Bar: --

On Mon, Mar 09, 2026 at 01:12:50AM +0100, Alberto Garcia wrote:
>  	case SNAPSHOT_ATOMIC_RESTORE:
> +		/*
> +		 * We need to call snapshot_write_next() one last time
> +		 * before finalizing in order to process any trailing
> +		 * zero pages.
> +		 */
> +		error = snapshot_write_next(&data->handle);
> +		if (error < 0)
> +			break;

I realized that this patch assumes that userspace calls
SNAPSHOT_ATOMIC_RESTORE only after having written the full image,
but if that happens earlier I'm not sure that it's safe to call
snapshot_write_next().

An alternative solution would be to do it at the beginning of
snapshot_write_finalize() if handle->cur > nr_meta_pages + 1.

If you think that's a better idea I can send v2 of the patch.

Regards,

Berto
