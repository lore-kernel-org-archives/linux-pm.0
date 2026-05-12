Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B94E25B0A2
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610764; cv=none; b=tfH6pqTPG5hAQ+p6I/AMl+LbeOzoRCmonfrMifAnUn49ZqkA45rMkkfLgZ4uoThDb0KNUt79FzAzwgkykjLXJjT02ATeABYETX5oNwtQUw1elpjnbJY5TQW6QFTGlbzIVSLRIekgZlo6QpVzUlVZCXyMPnyXsvGwi0ScB2CFY6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610764; c=relaxed/simple;
	bh=TpQV7EfOpsbYJ6QldzBf1Aw+Bi4z2zhrb+GGulcJC0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxwLhIjkcRNXMLwNWtWZxdYNAWu0XnN2gRSevCsc7aAGHbZFH/zfbX6D4lF6iMgSjgviKixgvXyuPYri9PA6uiIaXPfLBQZYkP51sA6hD+eWPuGqBrkkGNGH94RSaHw3QRkzXlpr+YjA3iG4COzypNSHJOw3Ve82BA5Me6jhHjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtPNbU5c; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtPNbU5c"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so1958991eec.1
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 11:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778610762; x=1779215562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ja6bKCcVCVMtzZDOZ+vitgR4xNzTf+japdav6A1ckx4=;
        b=AtPNbU5cQIFElvPpOV+3AjXxGa6KKDxF4gg54N5qtJFxx+NBiS0p5jtt/a6Z6Kax4S
         Clz7A1bBVncTpWtSUBi9x7Nr2mqLQ9TUQRBRuAp6ovc5x7jm6XqW9t0XOebQ0kVB/vmq
         lBr+ifXFou8204pYNFi1olZ63fmEOMeUfsLHbMz092t703G9XmV3yo3jVL7akVqXrFW5
         hVBtDS+kyO8YK/fMNLrMRfU2A/7fsoAJNuMkkftlwELr54+vn6/sk8IU3zhQe2yogSSN
         76HcGOQXfhBGI7d4IMqKBnC/ZinkqEoy8zgQAQ7imvnpJNXgV2n85oz16hYRs5MLOt16
         oRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778610762; x=1779215562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ja6bKCcVCVMtzZDOZ+vitgR4xNzTf+japdav6A1ckx4=;
        b=gVtUlUAhVR86S+oRwuYsqEUVX74nTKi+w+vYFw7Bau29FFuljNYhiInbZosUIA1UFf
         bPShTqdaEXXenv0aZXSGx3G84eBTdDfqV5O/a0A5DsTrvEGV9x4D2ahgM9jUUpjZFzvi
         riuLB7HMZYOffOCMsuPDNq7wnoUUuy7cSnyNVfesHBwReMNJH6lvQdkJQMwzAfLVOPIP
         2u68/juRcFuwppbB/YJ8AGHmVrQvjHDB4EA2aYbEqLn6bVAdWbKTzoQm25cUbqh3JcJK
         HgkjU2les8EOIHFuZcf2Ovi4tOH0dJniDOO/Bfd+h99m1hE7ukSxSmVc1HphesZjoVDn
         hJNA==
X-Forwarded-Encrypted: i=1; AFNElJ9xdrHTXuiSN99/FGppI8zVoqZV3Y2xphHE0jHJnqfOTA6pxL9uenmAga3Ty2+FAoWIjI35g06gcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMg6ZhEqEmuqwRb8rXZQQxSLq1TKlLIefVI/+5I2Vx7KET4+Mn
	HvhMOT2prN8KhTJgI4jPfxb4jku9K1Qo1HCUa5Je6Ztrl+/qgfMtJVQM
X-Gm-Gg: Acq92OE30AeISDTZC0dtyeqlUKgUg0MtN2s+flRD5PPfSqUbe6uXoTb4BpIKW+3t+YG
	JrTKo+6MDB3jldDivtmxSaKk8mgk352TC7VPMehgokFlVDAZBHcaVy0OpQmihueueqIFK4wG9g2
	N+wFSt1OS8FS9vu6uoHvqDJnnTh8u+uPzJZkd5OJApZETTihdnlMkzh1mNReZOrfHabq7DVFsa0
	SOkQIMVsNzgi0A+5EdhGsnUWMV7Z67/b39qdW7M9C+sT5zB2hRputUGTqMclr2r84fxIEcqvXDr
	Q2WXH1EIRSVCTCfJmc9i9znFyJPRdAednvurLjVObY36fs4DGH/0Qz4lMH1ewDTKzaDCB/TCAbm
	Y257lYIIYmFK5Cr8xDtjM6bKIPWATcPsXj5uty9KCGFiRWtK/0hzgfXYnRxbbFzMQIQdml6rH6U
	TDV1z1aB5Og0HooSx0mi+Ujer9MPgIXs8yoHso
X-Received: by 2002:a05:693c:290d:b0:2d8:df01:d9f7 with SMTP id 5a478bee46e88-30117a7ad80mr157863eec.15.1778610762401;
        Tue, 12 May 2026 11:32:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888c469b6sm19080122eec.24.2026.05.12.11.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:32:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 12 May 2026 11:32:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1] hwmon: (acpi_power_meter) Check ACPI_COMPANION()
 against NULL
Message-ID: <c7b6cd59-7ef8-467a-a5f0-b1882059a8ea@roeck-us.net>
References: <5068745.GXAFRqVoOG@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5068745.GXAFRqVoOG@rafael.j.wysocki>

On Mon, May 11, 2026 at 09:54:51PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
> acpi_power_meter hwmon driver.
> 
> Fixes: afc6c4aedea5 ("hwmon: (acpi_power_meter) Convert ACPI driver to a platform one")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied.

Thanks,
Guenter
