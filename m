Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794338277;
	b=wQO7flVZzH6ExKggPSqc/z3htstuEF5D3d7LNep2E3/6VPEc2xn4LecB2NX70kz4Wsqs
	 rNS7o++I70Igjm87/ugMHQAwOTUFLyCutCdzWqyFSkLHf899PGWNUk4xwC3zvASnQU4pm
	 /lTWtKl5CK3PwxTEtp+XT+osq9R2Bwmm/77n7KoHtbvv0VMcG4tncTRoJcvy6f7w8IT83
	 joEVftRkKouvNm5inj0XxloXU9ouRGrhFexJO1wcW0DzLq2xR1r3+OApSAWAfhvomNIME
	 Q298MQX74uMH+hWQbsqm/O00z4w7XIfsmcPiG8ZqhogdF9ECXpME34dUrNQIkHa/9mA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=puDDZt/C2f5Dzo58o7lKVRrUWtH4KzZHgOy66M1m2I0=;
	b=mVEnqrlttqshRzIzRGkjMO69dqr22xAdXyXaIU+wotRs6qsC0URLu9JAG4/3cuZA2vL3
	 S4iHOeCwfunOgIkMQACyNYucTsEBUrr0ANzuFwz4KQxadt8Rh9NUiS++hKa/QpABUgBDj
	 k17wOTgpfPQYZMvgFX69nvtOdf2AefQ4pOBKtwhpORcMNlRP0ybvQNU2VdQAwSeP31nvY
	 jTM1SHwN1KdK6QgEqOyMTPcRknA3EXZhsBlHmfYIYyimJqwEXmuK4R4nRkqi9C5Tpw8yj
	 JoZsZ0LPct4zVC2hr33DeLa3r9CnhS7BHc+OKJ22SwBMlbJTROTzT+G2DzCXkknyXXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wG23Iavn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7A1606A33C
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 19:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A7A1606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wG23Iavn
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b0cf2c0785so25290747b3.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 11:17:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794338275; cv=none;
        d=google.com; s=arc-20260327;
        b=Q7UuUybCXKAeIGLfvCgXnL0APJALgjjP3zfFYJBvuoa2MOeQiXRXlKoyu4BbMHu4RJ
         RSDf0woTO3JGUq8DRbekPbg3C7cN4v1h7s2QjQshHLPIu11dwWhnTD142JLVhkG78W8g
         7q4aV6iCcp0jcfc8aPLz9bRLiL2QJE2eja1tmpIzvT55v4b1lqiU+/w6yQujfdNTbmhC
         r8fRgxahd0g++CYynidFHHkWQxpD9MlQnRvodthk01RlEXH4AN7u+qVcAoRP2/La9BH/
         gyhxjUj/MBEQljdV1FxxTa3M7XYzFDOO/lEMfOAMJ01ySJdT5yCqSQKUEhNCSmYqAuCM
         YIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=puDDZt/C2f5Dzo58o7lKVRrUWtH4KzZHgOy66M1m2I0=;
        fh=q1GXbeqJBr+YITUrlcPuLSvM7suVxjb2vRaZVj6Q51c=;
        b=qCIX+LeGMicStxUqSQJ+cQxB5hf15uUZ04j+7seT9rgb7gp7+39Oz6580Hr96X1ffC
         eE4rsPFL95Wmln6kSh1sAhSLZya9onzB0d7yvBjKtcHEdeKbY2BPBfibTXkQ8CsI0Mi7
         3//wAIBOkT0Hjf6XPaazf63E0fLMq8qI0DNoUTDazYx/xGU5FapiIbB4v/yNHb1C3ksg
         IiuUeuGVjHYwE3C6vBrULTPEumfTCnwMz8dE31KHQ4rQxXySF638bSCw2pXm32RLvtPq
         zFzNmepoT24O538ZNYW6T7RKXD18Pm7ANkBZQoLVqb5JS8pUE9ZtyUv0ygVhfRRMV56Y
         5jlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794338275; x=1794943075; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=puDDZt/C2f5Dzo58o7lKVRrUWtH4KzZHgOy66M1m2I0=;
        b=wG23IavnEf5PBf4OCbe0axelDdxvC0oY3LCq/Qk5QPxH/rJRPbl1XXe8r3rYttBY0E
         fjHM/7cXvWIJOf+q2vNQIwIEjoTrZ4lcPzTPR0Cbory6gtpcZYQ0tn/+iq+VhxnsqAOh
         KOcWZkFlnc03XwyF5ACIQ/5jRaIbKXQNf/1yc+DJPkNi5vpBGaJKAAMxubQtbxkEiH+j
         0nTJQT/37sk8uPHbwHW1hKInsYKMDL7+SMKU7BZGWXjXPlbjMcOy2l6agl9UyQSrvPAw
         LQ8IzBeiVAawq7CUrMxeSucHicW7iOyBOnZJFtiQCNxlMz14X7B4ZKECymH4sJsjiOiR
         lBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794338275; x=1794943075;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=puDDZt/C2f5Dzo58o7lKVRrUWtH4KzZHgOy66M1m2I0=;
        b=bMMTR/GfHQqUHW4fyjCdsYzwlaPo/b2PykI1VXyj7WEZyE4UKn8WP+Zga0siVVOwHX
         v5dCD/XnCfaUhVLjiJp+at0bDVAPOxeAL3hGH3j/umS3UB9dmAgxxFfIvEiqwh/RH/UN
         Ch1QAcIPyQMn110hD31UqpdAhXWZNtQp/8EetW+4HSV+jvL/hcUOMQaT6IdLP0p78Vvt
         2WnIDe4VcQg0A/qnm+LW8yobqUIR8hvgRPkaVmWUqzdTlKieYYKh9wEgmfKqJ0lGWWIi
         ogwG1XJjhXnY26zjBN+WDkGdUb1pmFQPn81N6NSC7soZIKLJU420Vjmv6BqpU9h3L9py
         8RaA==
X-Forwarded-Encrypted: i=1; AL+hErHAgad6vsfv1l6z9HVXckkd9eAWfop/HN/DfK59DLs7llE0xz2l6mt2gHfcQ5/Nod5HH6d2nDqA7A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/xHKMBUgrWrBzekBdSZo7VaZm8/lwuqgFyU8yKIQYB1zhft0gT
	B1RulwTlbmpcd/LjX9bX4nf8bTJTy27TWAQnWyWtNmKj7nnAOf6UrrXBtjB4dvwQ+p79VeY+prE
	NyEqPUW3Sv7U8zvuka9AkMcqo+HH3p+Y=
X-Gm-Gg: AYBFou2hVJSpD0JCauMlVjxp4qpck/9VqiGmw31xV4WFC/l//0u+Sv1XCaC0BMFnld9
	qXU7wuYyw5zFzpXQuCp76avuRlaCMC84XvcXTnm/P2rcSdvCjoWAPMp4WpBLCrrL90OEGlIQKBa
	RyMtp3HIgzihXgn6ELzbzsKwqOCGOJKCiPFnRt3jIkyXEXYT5rIDG4RWNZekc35ramHh2Vy0iTL
	LtKr1f8UZ7+8KTbEmGIApCIJpiMsN4OnsiZRooj2mv/Qqhfd8xykT/NXIGt/fDm31AF99ca+Wtw
	hYcgFSooCfs/CHZWxTlzuybsCcS2lPocIV/bkpxPdOC9YPiTRWnjWhKQXZFfEbxJx+nnNF36EwH
	wtfn7B52dkjNMMV78KmdkAVhLOdPEl1wnDPMs2A==
X-Received: by 2002:a05:690c:a045:b0:8b3:59dd:11bb with SMTP id
 00721157ae682-8b3a80904bbmr1548667b3.32.1794338275490; Tue, 10 Nov 2026
 11:17:55 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108-04-k3-pm-support-v3-0-b9dc0857039b@kernel.org> <20261108-04-k3-pm-support-v3-1-b9dc0857039b@kernel.org>
In-Reply-To: <20261108-04-k3-pm-support-v3-1-b9dc0857039b@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Tue, 10 Nov 2026 20:16:00 +0100
X-Gm-Features: AclHuK8pMvnG1Q-j9dHb2iJ_gKQ1ShQm5guoJXhhleP_Gp1CskmuEJKcLhqrA_k
Message-ID: <CABdCQ=NCwHn_Qtg-KZCRYWrruDWrP5Fdpeq_Ci_vtcbm92hEkw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: power: spacemit: Add power domain
 controller IDs
To: Yixun Lan <dlan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

Patch 1/2 is unchanged from v2.

Tested-by: Iker Pedrosa <ikerpedrosam@gmail.com>
Reviewed-by: Iker Pedrosa <ikerpedrosam@gmail.com>
