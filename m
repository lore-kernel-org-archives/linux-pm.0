Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795400923;
	b=oc1pohsDOaz9UMFjLEwvF/rOS7WRfg4LAW/YdtJUKxYOK+Efu0onn9HTLUQnO4Xm7uUv
	 KObcu18x/fE7fqKj0okEjtWqRJbTr/lUnT9yKz/16FMOmVlAH9Y34ax+TEit0nTLBmA7T
	 SCIGeBLE703mpoDNNW3QSoBzlM4uROvoAHwD1fsLQ/k6PjJYk4R5glnEAvIEytBSZi6wq
	 DWg8o0exdy96/COpJuA47MOZbyZSPJwyObA0niko6gVtyY0H0WHGorbIOqaSpA/D/FV+a
	 An2RnRSPSFAYU6fCmF/avEkF7S3oc9Ai1UWF+0kjO3Wcrj1tegOP4Rft+7pqk34aJDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795400923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZicVV9Z+dbEcvbsxd5GYeloidM7KPsn1mE2hWsjYDlc=;
	b=Lsq1naUQLvST5Y83qvbmYxtAFX63xIFpJLgLSZRB4SDE0iQhoHbTW6w7cw3x4qgid5Ik
	 ye+EEoa1APBk/uTTXVEsHogow1uRfiSrk14vkZOsfK4VXmSJmjL7+RDX5UAsXHvCCvKZP
	 pzR5LYDL8E6RyqBC7yyM63SKuKBVvWQrDd+WKt9caeULdzlHipg+TUhel9LJb0Wcz8fcQ
	 J9S4vTO/4YUwMqGyEupqSUqQLTH0WMQBkFkylhJNT3IMtS31B/rZogT9N3lGjglkIyKjf
	 sKu/l0hAtzQBSjTKqJK1n82XaEZ/2BTQZL5iuhGo6m8rL1+kxIDrJGkVLR3eezHMShg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y1VNUVr6;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06868606A31E
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 02:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06868606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y1VNUVr6
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-386ab9ab619so1295774eec.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 18:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795400922; x=1796005722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZicVV9Z+dbEcvbsxd5GYeloidM7KPsn1mE2hWsjYDlc=;
        b=Y1VNUVr6cZxi6mv7oTelykzw32dhCaT4Nul0xpjhZF7276mJ/5rBfU4HjZLSZJNZnm
         6WsiDlMKLMEVujePFH/6AV0cZBl/X5lfHq+cuEyCqFV5SSFKB01dB0XsQQiX4JDcRNYp
         fm7XfDsnwCg9V+3oxAS1lO7Fj6H3kjrLMjasNU+sXhn4brbP/NTN+Wsp3hNdgFZh37GZ
         7ARLvJrrxe+fGrGiMFUPsLg9H3FiBeILJ7kd0tAfQOl/fco+GX71C5jwPDtte1AzDICh
         7vKDo5yfpywIj4czLxiqwgSqj9N79h92h0707pQeVEzlhaUC/9W9T2aiRd20L18DcmlL
         5XhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795400922; x=1796005722;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZicVV9Z+dbEcvbsxd5GYeloidM7KPsn1mE2hWsjYDlc=;
        b=CnMnG52UsHwTHP6vtCGDw7DAmCmD+uUdHJRdtX4gAe/Neoz0w0p3U6NbatNKrRfgur
         mh31LxZ41Zp9Qkl1iIKGvq75RJ+a09q1rNgCCD+Xxyu/O59cP3YmHmL4o4SsFPhwC68+
         y+KlpEOLLpIkpyx/JIjYvvJj1JSElpcfMoD9LNYr4ca3RDJtd1MeawhD3tZ+v7hUCMFo
         V9ZvNqWbrd/+26glJzJ2dxHtY2cY9M3oI114/SGHV+DOxdwA8oHrE6Yx5uMZpQDZIdMc
         RDzIa7JXa3acmhY8h+hEEA65ofqeE6zB0iW8BgiFr4H4VG8hBWC4bvkkmwYK5kcB2HQj
         RLtg==
X-Forwarded-Encrypted: i=1; AL+hErEWAeLCCnRl5ux/h+AQNyUtVjIqGN6evB49zT97M60ueCt9OiIsZJIDsgSCVhoEfTxsOhpt6W0plQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8E8tRnTnt4f8KlhcZcH/9fOhK92M3V2vUWnb9wRmsguNgjOmHV
	C3ZI7CaG4KbyzZCZNe88RdnBxjpGnZoh6dbwUJm/erqDHMa/PSUrVunc
X-Gm-Gg: AZFdTZfulSu6XqTlJu8NQMkQ7H1HTo9Px9+VBrNbZmCwOTeObn8g8bOL5UdRxnQzenS
	blb7hyKfyOXcliyK+20YjTG+0YtpwpRzY8q30gsL7itaiciwOUvwJeuK1NnSE5idP2fIJBiNbpd
	qelpOpG6yuGBXPdkA0lAMIU37PvDOowunHW3OxYBmjEW6RWPTfB6siA3fxUOzdYcRo99YeZg+LN
	CaLDtUsstZnCBYFDwpL2PKDF0HZKbfl9S2YwLSCzFxjyuvgzj9mKSYijC8K449Np2+fNqY4oh1P
	smDaTvOK0J8S0ZK14BzjOHwZaLa3TFyTMakR5jrxb8e8vl8DcLxSwNWv7pyy8y1fETaNoZWnWsY
	i0aYS1asufmPepALzg28b7Rr6quP2nqlf2FPRGMZtLiO7dmUwxLlC65S8n6kDiVO6MJOVB21euR
	r+PKfwKW2sQIvVkCULsQMcwm6TlEHV7PaDA6n4Q0M7xhBxWKC2pmEOMILcxiw1JM4zFNdY2RjLR
	Ie0I63vBJCShOLv4xv9nmJx7uNK4YU+5P8mEvsaNN+W09W3DMmo8IBdyMGYtTTqfyGtF9QumF+C
	LZ8eFtXqKWEpqKWPTuXtEQoapf+TPF1qmLzGgZYyoLHW3Ayc4Dj8inWZFq5s51oMaKQIFcA=
X-Received: by 2002:a05:7300:50c4:b0:386:121c:c275 with SMTP id 5a478bee46e88-386121cc3c8mr9558886eec.10.1795400922103;
        Sun, 22 Nov 2026 18:28:42 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f002:4621:aeeb:e0e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm28632639eec.16.2026.11.22.18.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 18:28:41 -0800 (PST)
Date: Sun, 22 Nov 2026 18:28:38 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Geert Uytterhoeven <geert@kernel.org>
Cc: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, Lee Jones <lee@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, mfd@lists.linux.dev, linux-input@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2 3/4] input: serio: Enable compile-testing for
 SERIO_ASUS_TRANSFORMER_EC
Message-ID: <awOk0yzFfiGt1kro@google.com>
References: <cover.1795355432.git.geert+renesas@glider.be>
 <234c01e4ac98bf72e3e2bbfa7b4fba635530ab8c.1795355432.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <234c01e4ac98bf72e3e2bbfa7b4fba635530ab8c.1795355432.git.geert+renesas@glider.be>

On Sun, Nov 22, 2026 at 02:56:32PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> The Asus Transformer's Dock keyboard and touchpad controller driver
> builds fine when MFD_ASUS_TRANSFORMER_EC is not enabled.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thank you.

-- 
Dmitry
