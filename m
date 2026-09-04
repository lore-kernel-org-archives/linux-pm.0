Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B9551FCCF;
	Fri,  4 Sep 2026 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553104; cv=none; b=ILNR92A2L+J3NurXJ6yAcU5zpb0wRMAgU+fyNS2pmvY1BFcVdou23sPnTQ5dkavgJ/7K4itUyDOg5QF8xVfxkMDOPQkqLu0S/yUXMXGS4cxsL0tSNik548UFVHQpDN4dYSvAdaTTb1f8TmKUB03FW+xJ8u1I7YGM1MVrKBO9h7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553104; c=relaxed/simple;
	bh=z5rgzC2ZXtEFFsyI/mhG8YgT7oVtGQudZOzxj795Sog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2tzZxLV0DbAdKBCWdB72S9wuYnHEmCURqSh9zlsvo7mOSdqNV4TToczA8Ep3+CbYG+Vn2UfzjNZCGi5sOXU29veXrf25fW911juPiKAyvJH/CFqUl2VcN7ogaBJ4FFmlp0SZ4CV5Y7FgwaYpUUBRn3axF9BSKA9OnfiWw3bs6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N5SzOXnm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N5SzOXnm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788553100; x=1820089100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z5rgzC2ZXtEFFsyI/mhG8YgT7oVtGQudZOzxj795Sog=;
  b=N5SzOXnmwvWUqKv7G27CwXfG6CIAnVtv8tROpMnw6O8YgHWbqupLB5/P
   CkrIjBgUpWmsQrzwJdz7kgncDuJyq9AFa6a4CL/q67vptYO7mEk2f1j/u
   W/Af1UbhgTYkGOY21SyS7rl6/cG4tzlHHhvz+RadSM0X0ueILJbZYvD7h
   sCKpiloL5VgMEddmM43MDbFqwrKrkPuJfmeedsmEd11jdPDS+k2Tv9/14
   BcbEU7oWhFsAT7aZ+dULIXODbQ8r41H4Ej88HRWb5T9QkqoSiL9eWKSwt
   MsybLQYKOrmKLvkRSEqQBawVuo+RTVkvXW05cq56AF3+Y6Or+Dl3IcJ11
   w==;
X-CSE-ConnectionGUID: IWZW9nrIT2GgHfzZCf8hxg==
X-CSE-MsgGUID: qGgvlc80TQi0bfybC9QKWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="89093870"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="89093870"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 13:18:19 -0700
X-CSE-ConnectionGUID: UK+p2y7PRwKlW144I7lA6A==
X-CSE-MsgGUID: nfqpePWmQhiaLID+A3JNeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="295011246"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.86])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 13:18:15 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id EAC3911F7F4;
	Fri, 04 Sep 2026 23:18:13 +0300 (EEST)
Date: Fri, 4 Sep 2026 23:18:13 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wei Deng <wei.deng@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v8 01/16] device property: Add
 fwnode_graph_get_port_by_id()
Message-ID: <apsnhbsN1ENl31JX@kekkonen.localdomain>
References: <20260904084158.1341550-1-wenst@chromium.org>
 <20260904084158.1341550-2-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904084158.1341550-2-wenst@chromium.org>

On Fri, Sep 04, 2026 at 04:41:40PM +0800, Chen-Yu Tsai wrote:
> In some cases the driver needs a reference to the port firmware node.
> Once such case is the upcoming USB power sequencing integration. The
> USB hub port is tied to the corresponding port firmware node if it
> exists.
> 
> Provide a helper for this.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
