Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA6141DED1;
	Tue,  7 Jul 2026 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430292; cv=none; b=CkzTdBUU5WcQD86nq3o7fJXOgkZQMmOOqbH246GiObgweNnuU6UmTpVnWdAigMHgkSCgaYoH32ILyPhcrNm3Z6HuII0HfgGZ0LWTqahK5jMZH0LEwFfERQ5PD1SFXNaVLFY57amIsgXUzepmhuyrz5K4364ulc673OAT995zHTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430292; c=relaxed/simple;
	bh=/ly3zhbN8UvM0mBvHsyaV05d2n7SVnkwc5cqb3pdRB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0AIPqx7hnM+m8S/Me8wv8NNBNIcBWNRy4ZPYGA2RYx6NWVk9rS0IaI61HGQZOXSZz/kfY/kPPcFL+SF6hoBbIL6rSEsuX+OJcjpUqw6J/VqM6T7toiP2bTYkrmbx9yPaef/AFAprnDN61Hy5VgWAO/9irbs0jrWnuP2LoTdKPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGX1nf+9; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGX1nf+9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783430290; x=1814966290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/ly3zhbN8UvM0mBvHsyaV05d2n7SVnkwc5cqb3pdRB0=;
  b=OGX1nf+9aL0cgms1qB3jjrGS3ZWRw/sKhgzObkJ3px63381TpUwuxqV7
   TMok6sGGYQ1MxSE8xel7lppU5AMZMYGmzhcoTaZXB/f/6fvTKVKskFho6
   N9dr9bbIARsJI0Mp0GjMdiFM4PSaCxnxVIr4yCYJSirpdHwZppUlGS/lB
   b/n6IjzFw1Pquz3sSc+K/y3XhI8o4+IBuhaq1UQ21cDlnBaWtIPAcY1ZU
   04W5k6Iazb//Ow/LfuSUjTJ9BHpesi+Gr6M3BPxO/p0zvsSNGb0OkIg3Y
   WMCd7HwqvN8wLZDFdIzkX1iQ46Dcbw0NcFIZnV8YvlhUz9BCPn9DqZCdO
   Q==;
X-CSE-ConnectionGUID: aEIe5ST5Qi6vUjkMfTT8Dg==
X-CSE-MsgGUID: T8PhNBB5RqWgDshvKZifrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84167302"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84167302"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 06:18:10 -0700
X-CSE-ConnectionGUID: WsO3CRuiQMilZkW6KgdYNA==
X-CSE-MsgGUID: wMffaHyNQPaTlSUC+Mp9gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="257569504"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.36])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 06:18:04 -0700
Date: Tue, 7 Jul 2026 16:18:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, sboyd@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
	neil.armstrong@linaro.org, sre@kernel.org, krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org,
	luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com,
	mitltlatltl@gmail.com, krishna.kurapati@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v12 00/12] SPMI: Implement sub-devices and migrate drivers
Message-ID: <akz8iRW2emM7B7n7@ashevche-desk.local>
References: <20260707111829.180158-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707111829.180158-1-angelogioacchino.delregno@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 07, 2026 at 01:18:17PM +0200, AngeloGioacchino Del Regno wrote:
> Changes in v12:
>  - Removed call to of_node_put() for failure as it's being already
>    done in spmi_dev_release(), as pointed out by Sashiko
>  - Fixed usage of the new helper in all users (it's too hot today, sorry)

You have send two versions in a row and effectively ignored my comment.
What is going on? Perhaps you need to slow down, find a cool place and
start over?

-- 
With Best Regards,
Andy Shevchenko


