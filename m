Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C333382E8
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780371897; cv=none; b=GM7b0sAvv25cANuSP+eFDuE+JoWbieOb5E/f+QhSsLVDrIE3wieuIooU8ZM9xl2NFIJVSTNkAy8y2+G+bL3UgQugRGBQkHvBxvifv945cItRIv11Uhpw+mdFyU70rCdts7suiKU46a1eMeXYJKDUoETJw8y2lkZ+UjHIhJX+aEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780371897; c=relaxed/simple;
	bh=mRYJ7PxOrFtv65CLLZ54456b0DWYC5nxECBKHwzvqXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uK5WG5RR8kLNc35wK/d6E61e0R6s2sVAfYun7XZys6cZVHM5U/9+b+Pwjs8FPIRvEzFFf+u7l9pOmdQLYGxaLOiy80wZIJEW5m7MVNgJrFXzt7CokNi3mTV3of8bR+GkuH0CEbv7b7kxRiJwAxUOaUXJy8HgV+5SfW/B66442bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j56VatWv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j56VatWv"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490686877a1so64107485e9.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 20:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780371893; x=1780976693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRYJ7PxOrFtv65CLLZ54456b0DWYC5nxECBKHwzvqXA=;
        b=j56VatWvGaz3veX5e2UPEkNGoQMxNYEVcdmYM/PmAY2eOZNnC1fBrD+uccJOEpZbNO
         68yi8IttcWmqpvX8mHUuJs5Noahm7w3/z9zLSuYXpihOGXvfUM5K4tklFixKjCD1+ju/
         daYVRKvofGTfk06qaqxXSGbJJH4R+8hn5BizMs57o/AKgQTuRBeKiwCv9PX2ZEFfKSzf
         WwM4XR7eRV9XkraEgzOkucn9wygcxaAYaAoeREHTgo0hDo+/TW/r4kg1bsTa124ijoXR
         U9OK0fwjHuprh4wwsCuA3vysM6s3j2wgmB5LwE3P+22b5F1js/dgIOP51SWVAdKu8qau
         NC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780371893; x=1780976693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mRYJ7PxOrFtv65CLLZ54456b0DWYC5nxECBKHwzvqXA=;
        b=FtVl/tIvRX7aQ6s2c53rtG/x2Mw/dMH552VCowyHNGM9LRyncqxBmF/qqoai8XdRwe
         wGxw1/SrK7LThysVZAsbIRTOHA23TF4yEFfjMSDXTjybenquI/9l9p0khh0UnpAOxTFM
         +Rj2YCv7SgneuYRtUly4K29nKlfklsnuE0K4b+p9WPwzcPYBhwOsG9RvheRXrIvhm7EG
         PxFLkASmdMpP6wullJXhb4JHS5JhxJSWCAFbDsqcgMbu3EJrjhtaraLYIaba1brnD4dF
         hIOGz9XBbtkVCX6hJ2dBu3I6AgKoAmuTN+p9Pn1tjieYWSsf0tnEcUjc4mCHKC+jSihB
         hJBA==
X-Forwarded-Encrypted: i=1; AFNElJ+G1FETFGBrA3iE7w2wDQJGTo7560hVy1JHjdZPJ87FkTXg2ReyRwdTUj8swmWEey/sfgVmGdJJlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YynjxtSaxNQqMmuQ3nSgZg6g7KROPmgqrnXVTNNlVz+Na/0elGS
	slHNYTPptGeL+A93ehDecFswS9vprVa6rGwPrli+cwqM9xg0GIiFnp8=
X-Gm-Gg: Acq92OGv79h5AtVJr2b2qyhkcuieSQ7CNxP0UCZkGX/puYoi4rcDk/5Ch1Ydh9xAGTw
	SV8oo17+Qj3NMjOhXmpfZtxj+TvsGlxjyLIgXwLlTO+7TLrYKPog92Ir48HljVrIrnaezbP8Cvs
	L6PTL6+i9H05gT5YWVPNECEteI9LA6x+v/pCAyM9EvFDiIZhg83OHtHKwQMyOg8dKSUFm6RGvKt
	fnFv1trPM9d/6REbS0qiGEEzJ9f+op1PiQO6w9P0/4yACCEExxaVw5phmY4zKQiAg+8lG8rxWuN
	eISqwqRv/JSLzo5R5GPVcNCbrZv7dXKht/vOj00DUZPpHa45Z7cp8lpj5RFq/9dMhnq5f1YUfLK
	tQCMHgNYBu7b4j9NM2FMahl3eGDL6F6oODszANAYKeMMU6hl/zRjgSf0JQnR6BPELwfRdRL/2hT
	EB6XWtdRHkhISRFJ9OaH1KOndge8X3tjR1k3MMfe82PMTUP1+hswbeo/Kc1jjEasq63X3gfGmfb
	lxMXTXbDTN62Nm7K6uuTqSJdeLgXgrhyXZaDScGMdEUi63oRWY7eMr1xnLklDqyVUf8OXvU992t
	zND6c/pKLi8/N/0H/N3QMkHIpHpAjJbJVdu7FCPfh2zl4FmQBCWqig==
X-Received: by 2002:a05:600d:6405:10b0:48f:e230:29f4 with SMTP id 5b1f17b1804b1-490b0ea300dmr21500185e9.15.1780371893353;
        Mon, 01 Jun 2026 20:44:53 -0700 (PDT)
Received: from dev-debian.lzampier.com (brnt-07-b2-v4wan-169550-cust456.vm7.cable.virginm.net. [82.14.129.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0daefbbsm59794995e9.0.2026.06.01.20.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:44:52 -0700 (PDT)
From: Lucas Zampieri <lcasmz54@gmail.com>
To: Rafael Passos <rafael@rcpassos.me>
Cc: linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	kernel@lists.ime.usp.br
Subject: Re: [PATCH v2] HID: Input: Add battery list cleanup with devm action
Date: Tue,  2 Jun 2026 00:44:51 -0300
Message-ID: <20260602034451.398835-1-lcasmz54@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260602030519.3097058-1-rafael@rcpassos.me>
References: <20260602030519.3097058-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rafael,

Thanks for catching this and the quick fix. Turns out this is the
hidinput_cleanup_battery() hunk we dropped in the devm conversion
(patch 1/3), figuring devm would handle the cleanup. It frees the
hid_battery structs fine, but never unlinks them from hdev->batteries,
which outlives the devm scope, so the list dangles into freed memory on
the next probe. My bad.

Acked-by: Lucas Zampieri <lcasmz54@gmail.com>
