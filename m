Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BEF388E58
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787124954; cv=none; b=cGQ+L5MstXiuvvjaCpbpBKQtjtIzmpDGEKUvJGE9rzPs5ubQirO6MwqvRRaccVuzCFIHxgPSnj8I9emjBdJ+40fuL2iV7z+RFKvp9Nvunrr6NW2WklKxRs8Ds0eWgKIoSPD5VT+HZDJxkOmpF39uJm+vkfagHognZ182z41MrGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787124954; c=relaxed/simple;
	bh=UMGuM+WEzYHZD+w+RUpLFgQprr/FW0djT8CGLZ4rbhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlXGRlcu40EvClJvnQoK2Vr6arp0s9djX5hUijka+eS89V3zjbvRCaBJF8ox6GUR2IfKYVQM6Sf/LZBb/BWo/itl3XleCgk9TZGtQWzp7OMduFn8Mard5Kr66ixtdrIVNH0ocQJjc45CAONaLwP3TPfgGV5CR5n+TJtjO2Xjrzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/xR+Zvy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/xR+Zvy"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4956d1d9fb2so695415e9.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 00:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787124951; x=1787729751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EEZZ7jCpPzgYTO9oedvXx8uW0QuKMwnxpLd54iUvN+g=;
        b=k/xR+Zvy+iyqLFpuCksHYHOc5UVCcOl1Nkkmuz9ABSnR9aQRgB2CPeYs3VsdpQKT8j
         VYxOKi8QmcrtZ82tyq2pPRt6bzDdU5yywecjoCwGsBDiEilFwl0snjXgz6G8jSQdKcnO
         KPp33jO7ohke4O3iCM9PgKJ2L2eK41szkyKD6lP0DiSMXmYNK0prFwe+TmfMRcQ/TigW
         +pVU+Rmh/PZdeHw0bnj3DgvBMrKfVSSOeS+hZpM4fg6HvmJcpuSY9hWpUXuOHflGtgy/
         ZNK1dKFJ+l+4JYwEX8KAoXCmIwBjO8lRvz1mLcauJ+mMjIwhvDM/yeNnw/PNoMyqoY46
         soMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787124951; x=1787729751;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EEZZ7jCpPzgYTO9oedvXx8uW0QuKMwnxpLd54iUvN+g=;
        b=YYvGTQjFDa8Tq5OC8vHzlIzG989DN4LlbMsrcP3LxaedYfu+P87S6LVRsWHtBKDLN0
         DsNUmQNb+I9b1KE8hlob/Xte6GwkQrU9h+xR+CBifBiGJtN/lWKRhM3djWaQPIZ4mKsb
         pATd39nul9+iZDNPxChQ3vlR5Rdt+T3XFlG7rBrdPqJ996jFl//GZnzkqb15mAVfEyCY
         J8ae7EqYiAzf+COvY3j4i1YL37PQYs0JDVWWdIAtZIrJUFoWqpys205Ed7BZ9Wo2Gs6H
         XPeJUdOAAcCHyTbiw2bZQfznoV+Flo6YT3dsmD/8Do4JLGiThRHeG7Q7tZIzyxb6utjX
         KKSA==
X-Forwarded-Encrypted: i=1; AHgh+Rryu99F5mtEPFurjh93kmCeiuGBxVvrUSUlfE7PIiDcIZ58ob1HYlpEjsmpvrdojt/uiRl16YF0aQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGdMDErlknrwFW5qovC8LJHZZlvfK1jVzHDS/Syrom5xrqqAJH
	m0v6WEzdmq1xwL2dKgahYd7bsR0SK8kbYCjaLcucxKYKY6c9q3T2YSE/
X-Gm-Gg: AR+sD10MyiUfcPFbrAzIOzBJ56ihNGP5FQfBWi4ONHoMdiyGHlKlUPN8j+M/AkNI6JL
	Iz0cpAdbGhlspuZM5pLnu1xcw2hJfP5N8jdlW6gx/n3ABE5CGIgtwCg9MeY2Doy7jD5vPr7Di3l
	Ct9dOoW52kFuBcgdRreLDZNuv++Lf4zC26lNYwf8LEbwMLPsn84mPB4+UVouS5TV3i4rf/WtjgP
	qggAyAhXmfhaSCMEqVUY2wRUj/msOTEF6cb1nRrDOKP7t2ZILDRzm/FnhCz/4wx6IRHcW5r/0P0
	hu42Xo7gcbv+D5DK5nl51NmZd6FXuRSi8254QCCBVglawQ04N4yM8NeP0mVEyp4GZrU7adcT3Fc
	ZlsOqQKNxKBUj65h5+JxHTY4QgS4T2yzx4Xo1uZxh3ygFyaCY3nnvogkwYZZtQFN9mwGD2jR9bB
	Gm7B9ONUcmtmYNyQfdAb4qOn4dpi806BJAVF+3rCcHSOgXYvq8rDsBaviHaz1f9H6hsJO8klaN8
	dCO4pcwlK5/+ZzF7tgRyhdZvJv2pv7aIRChQMm1xsZ495+AKsw/LI+OAUpsdDvOqVwFwA==
X-Received: by 2002:a05:600c:6206:b0:495:71ff:598d with SMTP id 5b1f17b1804b1-499aa1997d8mr24560625e9.1.1787124950666;
        Wed, 19 Aug 2026 00:35:50 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B92960062A31D8DDD4EA0DC.dsl.pool.telekom.hu. [2001:4c4e:1b92:9600:62a3:1d8d:dd4e:a0dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0dd3c9sm40653805e9.12.2026.08.19.00.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 00:35:50 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Igor Paunovic <royalnet026@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Alexey Charkov <alchark@flipper.net>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/12] accel/rocket: wait for a running IRQ handler before resetting a core
Date: Wed, 19 Aug 2026 09:35:27 +0200
Message-ID: <20260819073530.6087-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819072420.1780708-1-gahing@gahingwoo.com>
References: <20260817113603.1436067-1-gahing@gahingwoo.com> <20260817113603.1436067-3-gahing@gahingwoo.com> <20260819013609.1613919-1-gahing@gahingwoo.com> <20260819065146.5904-1-royalnet026@gmail.com> <20260819072420.1780708-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jiaxing,

The three-run design with the deterministic third arm is exactly the
de-confounding you promised, and declaring the fourth run void instead
of letting it pad the table is the kind of honesty that makes the rest
easy to trust. Glad the third bullet closed on silicon - one line, as
you say - and thank you for the Reported-by.

Meanwhile the differential finished here. The base build existed as a
pair with the patched one from the start, so this is the same machine,
same morning, same session.

Base kernel: identical tree and config, same JOB_TIMEOUT_MS=2 local
patch, with 1/12 and 2/12 not applied. Same protocol, two passes per
kernel at console_loglevel 8 and 4:

              loglevel 8   loglevel 4   recovery   oracle
  with 1+2/12     12            8        all clean  48/48 both passes
  without         12           13        all clean  48/48 both passes

Zero MMU_DTE_ADDR, zero "Error during raw reset", zero lockdep or
atomic-sleep hits on either kernel; the domain dropped and all three
cores returned to runtime-suspended between rounds on both.

Your distinction between the two tests deserves my numbers next to it:
all 45 of my resets hit a healthy block crossing a 2 ms timeout, and
the domain dropped every single time, on both kernels. Whether a
genuinely hung block would keep an RK3588 domain up the way your
failing runs stay up on RK3576, this protocol cannot say - I do not
yet know how to manufacture a real hang deliberately. So the honest
summary of that difference: the step your failing runs are missing
simply never goes missing here under my conditions, and I cannot
reproduce yours.

The race itself did not manifest in the 45 resets on either kernel.
Timeouts are easy to induce; a completion racing the reset inside a
microseconds-wide window is not, so the justification for the pair
remains the source analysis. The tag attests what was actually tested:
recovery and absence of regressions on the patched kernel, against a
differential base.

For 1/12 my v7 Tested-by carries to the v8 shape as re-run here. For
2/12:

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores,
                                                 # induced reset, differential
                                                 # base, JOB_TIMEOUT_MS=2

I understand the v9 sync patch will carry the interrupt mask and so
change shape; the harness here is standing, so say the word when v9 is
posted and I will re-run the protocol on it as-is.

Regards,
Igor
