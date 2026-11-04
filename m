Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821554;
	b=yEaO/UU4SoXDG9i8O8TjW9mlGZHKlUpHnvUdHxPBGd1CKqUWKKXjZ6krwU7jdU+Df4J1
	 qcKDz1QHctYzWy99+N7KjrhUE38BI6q4QSnUUmyl5r7gf0b3acLceh+hlID/S/FZ28pIl
	 aK/+osTlUyfg+1g2TDKCG/g+hLe38Zstd5YNnzuBhKWtrVMzuJ5l3PsZvB9loegJ5TPIn
	 dhEVRs9vUPJWTezgQ/almKr3jkkWqOfUPkX7hx7FyzPbpmuwW+NeltIiRvd9BHjsiUxRv
	 1nGJzmQa/+KXzVm9AyDXqZDRAN7tjsoRRbvXDxLowsvj5tIJMmhTVTi/dTAtzXoSamg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
	b=YTACkZ6dGK2oo0Q3KgeUlDoHyzvU94yi/AXTQ5PfQfdPyiQIUQLbwUcVtQ4LvARvB4o5
	 SX/ljDEJrXwlIIj6XX3+3qEiHT7fsJAFYquk4NdL7STx0DEHte3phkeK2D3WGIMuytOOu
	 ad+QMolqme0N/IpVypkYbvRaEjjZ6/TLmtGuHOWaO6UuhajHavky6hwMP0K7NHc8Kr2i8
	 J9TInvinTvI+lu3CYv0S4hjQeMFXkxO9RHswyO/lzW5jYzjzV0rifdMxZxsMZsw3mVjir
	 7k51PIcqg8UWtJ7dOONVfEyxZPeu6pTJsQ46pkoxAChMR7WRLQgBdK+oBJLUcwyz5qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhgChsRR;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2054D608B1EC
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 19:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2054D608B1EC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhgChsRR
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b244fb7fffso1559757c88.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 11:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793821553; x=1794426353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
        b=PhgChsRRxoaFlSlkRP6+eJT4KYEi14DqTMP0leDLu81FxLUk2LAC65QwDPBooqvAsn
         iH6XkP8S1MK/SwZxO3AJkItw8VOGPpqeDmiiYKv7myO0lnlZgnop7KC9K2NAgM6ukplu
         Gjsdpkx1k0Dhr49FqliSxtq+PV7zOW1rF8RqXf/q22186XabS9LOxL3XW958WfiYw+PV
         JBjD6srBvq+hK2XBFDtCmpOIf+gS9iJ5nhxA+IIgHZhp3x3Dcb+TLxzecX64kH4ggJZ8
         fI8gag+0WQBADwjfb6rFBnw2H4YR37v7+5aiBzykie/3yy5MmRaIYgT31jdFJ3lzFtA6
         N3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821553; x=1794426353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
        b=kNzTgKDFXblFxVtOcpUJyQYqydTYWVzs4T2ZzMA/w1wbhIR6e/VA4OPgcTer02pJnm
         6mK0toAtWCB8Pi1JzSGOJiQixf8+6xNzuSkaPD/435FGCAA2SY9m/5xk1Rs/vQi4KuCr
         MnS86TBbzlPRN3Nekgy+iZapr3b4EiYPuOGJz8/hnhL5UbayBOc5eeIx5DArVJK4v8/W
         FTpFTHqKZDfBIs0Xc9qllO/WVJgQfpYLnE3wWxygQeuyn3FZRjqmyVUoZ/kA+AVc+yJU
         7bz9YkJone/9yv9UzoqvO/IG0erekgiN1adhNgB/8DXw6zwJX94aU/y1Kn8YFPNYw1JC
         93Ig==
X-Forwarded-Encrypted: i=1; AKwUvBwkJiJbasF76uLG03QnRwrTRuAirzNIa7W149WtQQKEn0EmNUBGwIdpF4LJY6aLFTc8cW4sArYNIA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+L7R0UbTpvl1Vc+jbboyvZSCWd71Vip22Ze0eo+suCDK91gpNj
	/CsZ+u6zKiFuF4DggHG8qYCyEFAKR9o+n73QclAEglUvDPiE/jK5vs0=
X-Gm-Gg: AYBFou0lEcYacU4k9Redo4l9G9ODNpDBRbXUtJY+ga+Xm9IETCT1SRd37ofgQsPNXEC
	XoHIs6mBN72BPbVmHS4d4gBSnBg4gv3Sk8T/POy9ocbaLmxNeVvRSYg+nU2dhk/dD5lWy1ufOyI
	1CgvbFnj0vkvnLIpVJwFgSjwYoeabfpDqYnt3BxeQqfT3B81HSFfM1ud3vJThmeqiwz7symSxLb
	/utScTo404rABedjLp6TW+w9+eLaeCDrkgiw+LB+h6vx8qpa0j4k04uqI92RyFaZN0Y9IKpnI8k
	cuS4opaw9cVkfWGOuQ1DGDQ1WiwIVgJ8mhHQZE8dmCU9F8yc3ruwCUWq2VytGWZsCAgT0yYrLlD
	OI+Re/1mdnJbXv4W6S7Yg/FAehC6vSMwpx/Iy2Nucpn/NP/T5qr5/QVD/nwmZq4XNVllFmXku7R
	FrrXM/GAFgWXoCbYWDyldlFqKYAv1TDY6U3meWaVUZM4PjXQLSDpDakOeom4VlvFE9N6rnVHlYk
	ZjxMY2++6Qwce2ehXFr7/R4/Hb5/aJY8R3qYnIY9m4mwWXLj9PJayD0vj8kXSEjoMTwki0014h7
	RP9OBsshtCSKao81FasxcCARyDLQHsEi3RGJ9Ol7Wb97DOjaI2GlkX1gBXxhbA5KFA==
X-Received: by 2002:a05:7022:3a02:b0:1ad:e740:e51e with SMTP id a92af1059eb24-1ade740e699mr23857533c88.42.1793821552953;
        Wed, 04 Nov 2026 11:45:52 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm8652168eec.9.2026.11.04.11.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:45:52 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: jic23@kernel.org
Cc: alexandre.belloni@bootlin.com,
	andy@kernel.org,
	asahi@lists.linux.dev,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	brgl@kernel.org,
	dave.hansen@linux.intel.com,
	dlechner@baylibre.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	griffin@kroah.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	j@jannau.net,
	jarkko@kernel.org,
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	lee@kernel.org,
	lenb@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	mfd@lists.linux.dev,
	mingo@redhat.com,
	neal@gompa.dev,
	nuno.sa@analog.com,
	paul@paul-moore.com,
	pavel@kernel.org,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	sre@kernel.org,
	sven@kernel.org,
	tglx@kernel.org,
	wim@linux-watchdog.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: [RFC PATCH 00/14] Add macsmc support for Intel Macs, replacing applesmc
Date: Wed,  4 Nov 2026 14:45:32 -0500
Message-ID: <20261104194532.8259-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101010737.203951cd@jic23-hlaptop>
References: <20261101010737.203951cd@jic23-hlaptop>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Are we looking at ABI changes as a result of this? That
> tends to happen with split ups of unified drivers and mapping
> them to more standard kernel subsystems.
> 
> What is the plan to handle them if so?
> 
> Thanks,
> 
> Jonathan

Most of these changes now expose the stats using standard api's, so this
should not be that big of a problem.

The worst possible thing that can happen is that, the user will have to
change their fan daemon (macfand/t2fanrd to any other standard fan daemon).

And also, sorry for the late reply.
