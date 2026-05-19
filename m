Received: from comms.kousu.ca (comms.kousu.ca [46.23.90.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789126056C;
	Tue, 19 May 2026 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.23.90.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211576; cv=none; b=fallt1+xsn0n2Y+4aKquJxN2LZD6YD/i8QXw+3Bc6T3rv+xEdH0stuaMB4Z0+RYvO+Uh2XZO5ubbM1LKODqxQoBhjVAiuEUQjDZsBZuibYwcph3zVoSnM8mIeJkrE/L4S4xMGGi9ZoeYLUEA5QoRxOVG1LtH+a9sUKQxr2cafQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211576; c=relaxed/simple;
	bh=cHwMJaARA/IKd6jTUeKQL/jjhAGlTHo3byD5ccnvl+w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fMUUJh32jC/5EZpn5MDgo/gy/KOeYBTfVoJHtZLtC/541iBoUtuDzD2gAF9OgVbmTFWmGPOwKTWVpjYuEKRxrNGTAOdPxMg8j7X1GgdIOSlRewjOmjPj4eCKvMStqZDznSet7+nFwV48v7v9E+BHyuqFnSrB/faEsK1BNPyWMb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kousu.ca; spf=pass smtp.mailfrom=kousu.ca; dkim=permerror (0-bit key) header.d=kousu.ca header.i=@kousu.ca header.b=2SVE0/pb; dkim=pass (2048-bit key) header.d=kousu.ca header.i=@kousu.ca header.b=bbBHK0F+; arc=none smtp.client-ip=46.23.90.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kousu.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kousu.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=kousu.ca header.i=@kousu.ca header.b="2SVE0/pb";
	dkim=pass (2048-bit key) header.d=kousu.ca header.i=@kousu.ca header.b="bbBHK0F+"
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=ed25519; bh=cHwMJaAR
	A/IKd6jTUeKQL/jjhAGlTHo3byD5ccnvl+w=; h=references:in-reply-to:
	subject:cc:to:from:date; d=kousu.ca; b=2SVE0/pboCLMoat/88OtiDfPyDrHMeS
	kNCKbMnRodzJ8YYLb2zT4PzTAwhr/5LjWmCA0yClN7RKVsCXYjSJAAA==
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=rsa; bh=cHwMJaARA/IKd6jT
	UeKQL/jjhAGlTHo3byD5ccnvl+w=; h=references:in-reply-to:subject:cc:to:
	from:date; d=kousu.ca; b=bbBHK0F+ETMIdXbIut25aL4fdRR7Q7B/Ypp2BEgINBeuN
	aumR1JbCMb+IMoiaK2MYn6vo6geDffpnN+vHxlDuqR17QQ3e6Rv21PPDmx6RdOp0hDoNTN
	l/PFZ5BOjW6nqA/JIVW7UkjChQTZ/xbzYFIOTIabHniVenbBl7fcVMqAJ1esbTIjfEilJS
	LtMTDdNFtbRuPqJgMC8eELu4RUK7Upw6ANmj/zIewmUOy/0YnTGw/5iL1wfkHNCGXHTEhv
	82j+3YH/ck3WSQF3dG+D8fHRorym0ApOof/eRmyv7dXLPy5+QQTC0cu6K/K8f+mh2xnHf/
	HBm1XU3jCXjVbCOSg==
Received: from ehlo.thunderbird.net (<unknown> [2606:6d00:15:c187:61b4:8831:db57:8e68])
	by comms.kousu.ca (OpenSMTPD) with ESMTPSA id 30f8d29c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 19:26:05 +0200 (CEST)
Date: Tue, 19 May 2026 17:26:00 +0000
From: Nick <nick@kousu.ca>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, regressions@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [REGRESSION] Toshiba Fn keys + lidswitch
In-Reply-To: <12896447.O9o76ZdvQC@rafael.j.wysocki>
References: <E2OXET.4X5GTP37VTNC3@kousu.ca> <CAJZ5v0jVQyWYqPo_MiUwNQb7FLNR_Q_++Xq=xA1owcHpcjN=OA@mail.gmail.com> <12896447.O9o76ZdvQC@rafael.j.wysocki>
Message-ID: <1B3380AD-5B40-4A39-8E61-3F5A41CD6D01@kousu.ca>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On May 19, 2026 5:15:13=E2=80=AFp=2Em=2E UTC, "Rafael J=2E Wysocki" <rafae=
l@kernel=2Eorg> wrote:
>On Tuesday, May 19, 2026 4:08:36 PM CEST Rafael J=2E Wysocki wrote:
>> On Tue, May 12, 2026 at 7:16=E2=80=AFPM Nick <nick@kousu=2Eca> wrote:
>> >
>> > My Toshiba Tecra X40 laptop's function keys no longer send events=2E
>> >
>> > #regzbot introduced: 57c31e6d620f132dcf610b2c52b4cdbd203c6f4a
>> >
>> > Maybe acpi_mark_gpe_for_wake was initializing something particular to
>> > Toshiba hardware?
>>=20
>> Thanks for reporting!
>>=20
>> I think that the problem is acpi_setup_gpe_for_wake() doing too much,
>> I'll send you a patch to test later today=2E
>
>So please let me know if the patch below fixes the problem for you=2E

Excellent! Thank you, I'll be able to try it soon, just as soon as I don't=
 need my laptop functional=2E

- kousu
