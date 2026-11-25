Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617693;
	b=DoU7jfWtKVjykidmlz8FoPJ7LcVDEMa8CZyJNOXPBKZruXqXAZf8ZFKE3pXKzdXjZN6P
	 QGuXwEHzjl/45tCiILIFIh/ruZWw89LeTRpKNw1NcYSyImvYaRfHbcvLMuSlu4HKu4jBj
	 T9bnba/1HV+fg9bcUI3Kq7F0c1DPnZzaEvB4ikRkkUWEWhFGVHm3l8AhI3ikkRuEXS44T
	 xKaTJWMiRrcd/8ohM5RttmpsyNTnBqJHPPVfady0IUgwI4svmL7jvG6uLRVDfdcGnhKd7
	 ZjXhkXF5PvPxmPT4JMpQQOPmNOKUpHpTvQShPekn3dN84if+kVjr4Zl31E4hibYp48Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RiFQrHYbOebwg4aSZm1pD7p5ODz57pewOJXxwjk/IsY=;
	b=IwTbww/kLUFLDILySSvapWHskdM9N1H6BPtiO6EGNHDgFsIZE6S1FcJeKLEdhqqJf69z
	 TjbT1z/A4v8bzLY9/rp/CVmvl7NxptiPww/BozYVmdx3Qmgv4bhPrHfU8wrnolMsDdhFs
	 w7MAsyvp0rZlICDq9Tu7M5Im+WXXaF79oNrgGOlLqZxR74SHf/dZTTuHHeUHLM4Clygdi
	 ZmvRgKgUDqq52Aymv2QuYQwx1Msp80s9YBtSVzq1Ww7BAeBoT8ktyAQzsSNBydUP2hXr7
	 soq8qLavSlUcN8u6yTYYf5aoI1noFZT6v0nAMXlHd9SSi4OpVuIGWS1lgwvNRAqOGuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lRNsOJqb;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE87606A326
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 14:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AE87606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lRNsOJqb
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6bab10844b5so5968166a12.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 06:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795617691; x=1796222491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RiFQrHYbOebwg4aSZm1pD7p5ODz57pewOJXxwjk/IsY=;
        b=lRNsOJqbLooDIrdaILNRYzBksZoVQm+MOGWWmHhZTKPuzlOd4BrJtS/qiEiyblwJPB
         3UqD+vZlNF9kJPrul8t7hiVfBg6OTgjBjTKw4AgyoDLH+B9bXC4UxWP+vyXTRnc5c1s6
         OYY3SpDnVP/9dLXd69kKn2ORDPIllG3IRc+sGuul+uh6Qa0/WGSm+xC1ndI3ZhhSv5NL
         vHClbFZLRToGsOtloVhH/iRiZ4QVP95kW5/flAVApjY59rAqq87veOKyL7OxLfI7C83i
         DEVja0SLspaqRCObDoUYxbQPfXtweKFb4tKh0r4fvFVuM1Z4wowpt9/XcaBKg0FvbgcM
         7k5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795617691; x=1796222491;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RiFQrHYbOebwg4aSZm1pD7p5ODz57pewOJXxwjk/IsY=;
        b=tDr8uCXk3V4VuwgUblw/HuSwvvoCDWL49cFuqdnWrec2A2hvBGbreJOdqcdpOJCrt9
         SklWh4Wic6KAxGRB28i8qhY8hJMMbxAIHcJdQXSovwi29p4vZ9PC0VGJvcgw+41heZNC
         a4J6tV31fR3ResB3v6jw5uYfmXBqhLeai1pyA5pJTVoybw5hs84agJ38J3WPTcwln2Ir
         vbMnYW8mJYEBAZIuj1c+rz6Vx2o7MQfbXNiqCJk53/Vrcz+pTY5stxmPenNmILk+1peD
         FNk6fxna4zIZJFn269bqJi4jp145QGdqx6VE9zAMKCS3LSGWOAxe94SY04Tbi9ehrhCz
         4FXQ==
X-Forwarded-Encrypted: i=1; AL+hErF/TG4uSuGU9eGnDPwrf01XqtCxN237chcpvCaO1WES4Lk6iNmmsUPozyhCl+vH8S8z0ZQJxbMotA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/3Vf0dIGhxDRrwAsYAXWCLnu3Vku3AYWEuoqwoWCkY460uoCRH
	H72+hPiEOENIsMWOmxuDqGmJsFnctvDNoQ7swLtcsIz8STPnaXQY1/nG
X-Gm-Gg: AZFdTZdSb4SL33GW36r0RenezubJt5ExToWZ7nCF5OcNDfHsV9RULboMIopiwGCnqhy
	mdFAtuRTj9XELpmc1Wbq6OzWMmXhExcQuB3DZb2j0VtmkQpMPPMPKBQdd3NHHzHkc7+utErNZ3i
	MWgCnM2yH/kXQpHBwaHoxkH/Ja7mVPekQJHD7+Zn5wE3V5SASMC9ai67h08CGo2dKpP3AXW8e5F
	nkE2k6aVZICKV+l1gbBfDJvVYlWZb130EWj7k6ypq9OVqXow0jSwl6tNt5BuUc/SxacQPbjfGvZ
	YzIKIJX0fkI1c22+GzcuQKhEj4w9tOkZ1vlCGjolH6pqn3NacvOijmLJxjvGhwfk2pMsJn8o1jI
	S5zvmPIPFBijQlW1IgTW8iN6QCHlXAhGth5bN7LDBgBGWzcO9Z4nKG6sj7q6RogMFH84WIH+QdY
	a/N6nIBCoUNUux0ii/lmQ3lwLTaIKP6PM15fUtWbGCDR6bTYXKXHHOrnsKGYlDSahKnsIbjGhRy
	/1FcUqrFdfzL0Zljis3AkeXFsj5pvCIfAFSITIo6O0Yh58hp86K/ZpysaiF1nHYKARHP/b1LHeY
	akhrHltQrI+fc5tkYRcFg63cJv0aKOa4qqr1vsseYOYIZwU=
X-Received: by 2002:a17:907:1c93:b0:c51:9d9c:c720 with SMTP id a640c23a62f3a-c519d9cc960mr349270766b.13.1795617691492;
        Wed, 25 Nov 2026 06:41:31 -0800 (PST)
Received: from localhost.localdomain ([195.155.168.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85fdsm653474766b.69.2026.11.25.06.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:41:31 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: s2mu106-fuelgauge: add standalone driver
Date: Wed, 25 Nov 2026 17:41:29 +0300
Message-ID: <20261125144128.3951630-2-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123-tasteful-famous-dragon-00ee8d@quoll>
References: <20261117104328.1176951-1-tadilhusrev@gmail.com> <20261117104328.1176951-3-tadilhusrev@gmail.com> <20261123-tasteful-famous-dragon-00ee8d@quoll>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Nov 23, 2026 at 01:30:48PM +0100, Krzysztof Kozlowski wrote:
> Even less relevant, drop. AI usage goes to changelog.

Will do.

> Drop, drivers should be silent on success.

Ack.

> Why do you need a new driver instead of integrating it into existing
> s2mu005?

I don't. Kaustabh said the same on the earlier series, so the next
version goes back to s2mu005-battery.c, with S2MU106 as its own match
entry that skips the average-monitoring registers it doesn't have. This
standalone series can be dropped.

Adil
