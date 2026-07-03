Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C83CE4B5
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080478; cv=none; b=FkZQXNGUZJsd+UFP+Ls3Ceq9qc7kDPXjmGbqAeGhAmetrnUNjpVXbvd9o4EXmjlx5T7TVwaSk90JQOa7P40/SU2C2Z7HZiAifiwCkmVuQjI1G5RMciZ0fERUbwTQPPQ2Y0H2N8zy2MhlNzNMMpSjI1dRDrVW2o8IIk8xS3hDcXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080478; c=relaxed/simple;
	bh=PjYdTZtX7lK06ob/wWBa1ApljcuOIaY/cFe1TQGyGz4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJRbmjjp8w08HxW4WjzYzHz97ibjJKHq/0+Mi83gDlXvKMJ1XCF8knHCu7w1S3zg2mUncQAzADi07+e/tbUVqJRvH6HIt+/LjFhSarKickOsuMKJ4/J+Ww96lC2ilR+0fg2l45Ly5oGjSI0Reo+7hrBcyHpd3Rv1mGni8LG8A9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTWi0jR7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTWi0jR7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8F11F00A3E
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 12:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783080477;
	bh=PjYdTZtX7lK06ob/wWBa1ApljcuOIaY/cFe1TQGyGz4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=WTWi0jR7xVCoxYKYqgxGq2fcoz5SNKI3/szg5jvDubWkKDZOL52ioyEKLmIcyAcpx
	 sSmaP4ca9BOE32xZQ9v/sp22wjWqCBoK8xAAhOFCFxIPV/lSpuXiy5uBIeZd4Ka8au
	 mupp6ItSo4dd4lZOsZRKtj7kZ2PFM46nBtvA66Y04MEHJfDZgsbpHqeoMvYwyYitw5
	 ifd1bhmOq1HXeR+tLGHkv/exz8r4DCMSObfom4g2+N9u3PhrdGMmBkOB+MTMuDfCC0
	 JDSpo4w5XSF9yHQ+6OG+Vmmz0dYmxDGap8vxmfspH2EKlva+vLm8tcfIyjsjzg5K2w
	 ZqPvtvwNRyAHw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeb36ed873so406769e87.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 05:07:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RovXgpvvJA+4Gwiz/Dt2nIJFGkQyYGBMXcHXbg5cOFoesGOHxaioCulVXJGoDtz5d9tM0xk1XOKkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqKL1pPBqrO9/LVNdcgMAeoenJHsofW5dt5p8QmXvggMXPqyxh
	MWlq7JLf9HC774GNDsjfA0LgEKGchlRIxlJssPiyJdq26/Jj+isaA3gK1QIK2A/WmnROJB/9chp
	W8mZ7dtYlYY4J75RT3MHXvYEgLiPclgTW08CpuTlFJg==
X-Received: by 2002:a05:6512:4cd:b0:5ae:a9ec:9fc4 with SMTP id
 2adb3069b0e04-5aec807d281mr1746358e87.63.1783080475763; Fri, 03 Jul 2026
 05:07:55 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 07:07:53 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 07:07:53 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260703110317.1283411-4-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703110317.1283411-1-wenst@chromium.org> <20260703110317.1283411-4-wenst@chromium.org>
Date: Fri, 3 Jul 2026 07:07:53 -0500
X-Gmail-Original-Message-ID: <CAMRc=MfPC=Jm6RFkCYG6vsYQiWHxBeNq0L59rwahF_6Fu2Ledw@mail.gmail.com>
X-Gm-Features: AVVi8CfXtDf2gFZfiLD1uTcC0ptlbG8CkVr7knkjsqBhpkA4tCpa69WB2eeLrDU
Message-ID: <CAMRc=MfPC=Jm6RFkCYG6vsYQiWHxBeNq0L59rwahF_6Fu2Ledw@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] power: sequencing: Add pwrseq_power_is_on()
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Jul 2026 13:03:04 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> The power sequencing consumer API already does power on state tracking
> internally. Expose the state to consumers through pwrseq_power_is_on()
> so that they don't have to reimplement it locally.
>

They wouldn't be able to do it as the field is private to pwrseq core anyway.

In what situation would consumers need this? Typically you know what state the
handle is in if you control it.

Bart
