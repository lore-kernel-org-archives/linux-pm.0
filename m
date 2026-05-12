Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14CB3C345A
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 20:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619144; cv=pass; b=aZzGQI7YmPsjyIhmhPud6MK1fy9LVctR+a+U5C7Mw0qxSnN7gvcPAoM3jSg3p945Qh9EiolSgAUlxaj+Sqg5MCG57GIeB3jVKsgkZqXYMJizzXaGB6Bn8wy14rekduTz7GVVo5/PUe4pBknsW0wXntEb2LLDjH1+ZJO2kdcucFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619144; c=relaxed/simple;
	bh=ANB0b/vNGiR6ZOSQte4+VlBcdVNkD2tKciCjuUvfdHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVlTGyrT/0ZwgPWm4zuRYeRmKQnx2duc0x1buT2Nu15PNUpBosx9AoNX8oIIr3ddFnZoOASpDt1mIWPEUyGl9Xzb8bYLv8qgQqaWzkAMpS5B5beS9xZsDh2xeSJYtBYcXBp7XxtEP+/IeyYzfCt0Nhhw5VAHRjByuQlnvYv0+nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YHwL34S2; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YHwL34S2"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1335cb20406so2277743c88.0
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 13:52:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778619142; cv=none;
        d=google.com; s=arc-20240605;
        b=UOnkYgthUs+/WoM6PE+jdciwH82diEteUAvLDJlDEosEAiAKQYPeBX3/Qj+/MjGw7u
         i3o2vIn12ToF1poVbnpt1IDgSSllSlXN6zuTfYTB3ntsfeVTLoEzUWy3d6qGwmtyH9lj
         tnLhUc0lY7br9NeZ7Gw4t0c0KJpyxNXyVS697HD4uEmDVxLKmA6WQYaMwn0mEVTJCcNn
         vrrvH1n6S1L2PVfQK+kj88kG1ifyqKZtzUdBnoL1T/0b2buFHq7/7MPm91lp1gX8oLbd
         W/QeenTN8t4n1YhyUHKnJy3SZN6mqdhyIlnu8DPELP/S3gQb4Em+sqAC2/g6Bv2+MfrK
         WMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ANB0b/vNGiR6ZOSQte4+VlBcdVNkD2tKciCjuUvfdHg=;
        fh=fmGTA6MlOLaf4oodCahcqlWFI2nDM3vbD8ncAAsb0k8=;
        b=I3vZG1sjD8PKtM4YylUmyW7Bb+u4NhRbZXDC6lKNnwW/Vxzd4PZVOAxExUdFbT40T0
         v56FSK7cwOKhcEx6kv9FGM6eSY6uvvW3fBlY/XMmmHY3DH6S8UtvWtNvvlO3gNfK7yPz
         1UiRY7LDChE3RbCYSvLcc5QLS+ZaDcBGBhISBM+XkOvNS+6/Dba6jcF3m6fUirlmi/+u
         NkA8V0n1NwD5ARB7B5enGeWBAZYaVpx4/tRKmQ3ROeYb7k9w0HMlEcRx5A68o/JFi+lo
         yej5FQrsddcSj42Cq774KRkInW+8/JwLJ9tp8oqboYwbqZvnGFLgWIxd0b9eEvzJ6kIZ
         kHJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778619142; x=1779223942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANB0b/vNGiR6ZOSQte4+VlBcdVNkD2tKciCjuUvfdHg=;
        b=YHwL34S2dw2xnwm18tNPftxLHT58w22kSaSGesuMZadLbAbssPZO9nxCNq0wAzGWSs
         VVdVThyN3nqr4/EG7NLStmsh+CbEM398wf2aUyDbWK7vl59PNC6q52Rjlh9df1PB/KeL
         Ss/NnRS9Itl3iI+XJCSbg2IQlfTwxS7Zs6c8EFtLPgekGNu7Fjho+PHAtYeVSWZZzNP6
         OaHM9/WeN9dF8y9eItMWhupAGlRfpa0sueRJSQgPz2dUOMe2qkpWMUVOdwViI73d6Fic
         WqZem6rMWion+Zxd+RsvEW6A8jr8FB6Y0aweIPqI6S3Rmi6wYm3Ez7Tn0bMI7nPChco7
         vrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619142; x=1779223942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ANB0b/vNGiR6ZOSQte4+VlBcdVNkD2tKciCjuUvfdHg=;
        b=AqsH/m1hwZsfS2I290957BwIGO5KEN1lIjtl4kCtF4islW02mQ8i1gBWwdOWiCRDXU
         KA/obIpUUTfJ+YErKls2Ava91A22bfPnA+SFZIb2+aD4b/Uobc59yEl/X9IWO4J0refC
         M6fzSUkmHh7eZ8SQF3GN13YUms3CB/u/iNMjCpMXCGAx+E9ioY17ptQ7fP3NO7p7v87q
         snGxxjXSegsZWucZB14kJsPZDnb6jVFLJUVd8CKUF34UU0PESCitvwRug4OYOB+MDLgr
         oAoEqcFFy0+htI39MPVfVkiONLIq1qimYIk+2PpN6WxlmOIouZBkBOksBqYCnSpVnCO5
         YxWA==
X-Forwarded-Encrypted: i=1; AFNElJ8sdxU+s81w1AM49d+rHdJK9FGvJKm27cvObjjpkBSO3qVWd98WQlUKc4FxO8rCxuR43uRa/Qn22w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGgD61GpUysiRcPGjmyC/+opXfv2q+lMeCquli8L4fZexeS7P+
	RLdDC0tEDecXPAHg9RneGaZ6hfZVZPsWwGV2OG/XVne/CQ5RGNNFnknwo1FHDHNJTpGSjduTKlV
	t2kmzG1tsCUH5eKmYZXSLIIJ0ybwvBbekuQA39k8=
X-Gm-Gg: Acq92OGW/xPbbhQFagYFb4H+KcPDNnHuvqoXTyiJQHWYrzLfEquF5XLLmR+buzqUFrw
	L6YL27HPRfpUUirrIY4auaShNmOqD1dZvS6IbfH8nikw31vquYYparnCdKhZwUCokeRAP3myIwE
	zdcuKdgKnaPvfkcy9pRyoqAHS5YQD9OVpDZgiaEBMZcqph8NHdbtSdr62c49klVpcPoF4HztKvq
	Ik2UJ6D4TIuThZP2S2O1VWZFagpikzh9XCHUtRfLKhgZ2HQKNtw9hGhFbpbvsrttbJqUqb5fmQW
	fXrajCJpi9sWFiM0MWRys4+YUrMkrgSylhDzKK2ArrgziMv9ydWMUlXk7EnZ5O8PCV5L+o7VBK/
	IFjO9z+ZAS9tSsE4MuNhSOULobfWZ7/md0T+zd9mzTRH8KQ==
X-Received: by 2002:a05:7022:2605:b0:12a:68cc:3efb with SMTP id
 a92af1059eb24-13436682901mr355811c88.16.1778619141463; Tue, 12 May 2026
 13:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512124653.305275-1-qyousef@layalina.io>
In-Reply-To: <20260512124653.305275-1-qyousef@layalina.io>
From: John Stultz <jstultz@google.com>
Date: Tue, 12 May 2026 13:52:09 -0700
X-Gm-Features: AVHnY4Kjvypytru-uOkz10DGAV0M5xtWxU4fYUWzYbZM_wzXuvQoRJLUwHII7bc
Message-ID: <CANDhNCqRU1paGDQPK8nHEA-yejxBm5ATPrNzvqSfnzU09Xk_7Q@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Call update_util_est() after dequeue_entities()
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVHVlLCBNYXkgMTIsIDIwMjYgYXQgNTo0N+KAr0FNIFFhaXMgWW91c2VmIDxxeW91c2VmQGxh
eWFsaW5hLmlvPiB3cm90ZToNCj4NCj4gdXBkYXRlX3V0aWxfZXN0KCkgcmVhZHMgdGFza191dGls
KCkgYXQgZGVxdWV1ZSB3aGljaCBpcyB1cGRhdGVkIGluDQo+IGRlcXVldWVfZW50aXRpZXMoKS4g
VG8gcmVhZCB0aGUgYWNjdXJhdGUgdXRpbF9hdmcgYXQgZGVxdWV1ZSwgbWFrZSBzdXJlDQo+IHRv
IGRvIHRoZSByZWFkIGFmdGVyIGxvYWRfYXZnIGlzIHVwZGF0ZWQgaW4gZGVxdWV1ZV9lbnRpdGll
cygpLg0KPg0KPiB1dGlsX2VzdCBmb3IgYSBwZXJpb2RpYyB0YXNrIGJlZm9yZQ0KPg0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBlcmlvZGljLTMxMTQgdXRpbF9lc3QuZW5xdWV1
ZWQgcnVubmluZw0KPiAgICDilIzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilJANCj4gMTgz4pSkICAgICAgICAgICAgICAgIOKWluKWlyAg
4paQ4paWICAgICAgICAg4paWIOKWl+KWmSAgIOKWlyAgIOKWl+KWmeKWluKWliAgICAgICDilpbi
lpYgICDilpYgICAgICAg4paW4paWICAgICAgICDilpcgIOKWnyAg4paX4paE4paWICAgICAgICAg
IOKUgg0KPiAxMznilKQgICAgICAgICAgICAgICDilpDilpvilojilpzilpnilp7iloDiloTiloTi
lp7ilpriloTilp/ilojilp7ilpnilojiloTilp/iloDilpriloTiloTilp7ilpriloTiloTilp/i
loDiloDilpviloTilp3iloTiloTiloTilpnilojilpvilpvilojilpvilpzilpviloTiloTiloDi
loTilojilpnilpvilpvilpvilpniloTiloDiloTiloTilpbilpziloTilp/ilojilp/iloDilpzi
lp/iloTilpziloDiloTiloTilp/ilpnilpYgICAgIOKUgg0KPiAgOTXilKQgICAgICAgICAgICAg
IOKWkOKWgCAgICDilpggICDilp0gICDilp0gICAgICAgIOKWneKWmCAgICAgICAg4paYICAg4paY
4paYICAgICAgIOKWneKWmCAgICAgICDilp3ilpggIOKWnSAgICDilp0gICAgICAgIOKWgCAgICAg
ICDilIINCj4gICAg4pSCICAgICAgICAgICAgICDilpsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIOKU
gg0KPiAgNTHilKQgICAgICAgICAgICAg4paQ4paYICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDilIIN
Cj4gICA34pSkICAgICAg4paW4paX4paXICDilpfiloTilpAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICDilIINCj4gICAg4pSU4pSs4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSs4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSs4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSs4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSs4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSs4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSs4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSs4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSs4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSs4pSYDQo+ICAgMC4wMCAgICAgIDAuNjUgICAgICAgMS4zMCAgICAgIDEu
OTYgICAgICAgMi42MSAgICAgIDMuMjYgICAgICAgMy45MSAgICAgIDQuNTcgICAgICAgNS4yMiAg
ICAgNS44Nw0KPg0KPiBhbmQgYWZ0ZXINCj4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcGVyaW9kaWMtMjk3NyB1dGlsX2VzdC5lbnF1ZXVlZCBydW5uaW5nDQo+ICAgICAg4pSM
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQDQo+
IDE1Ny4w4pSkICAgICAgICAgICAgICAg4paZ4paEIOKWl+KWhCAg4paX4paE4paE4paEIOKWl+KW
hCAg4paX4paE4paE4paE4paX4paE4paEICDilpfiloTiloTilpYg4paEICAg4paE4paE4paEICAg
4paEICDiloTilpbilpYgIOKWhOKWhOKWhOKWhOKWhOKWluKWluKWneKWmeKWhOKWhOKWhOKWhOKW
hOKWhOKWliDilpfiloQgICAgICAgICAgIOKUgg0KPiAxMTkuNeKUpCAgICAgICAgICAgICDilpfi
loTilozilpjiloDiloAg4paA4paA4paAIOKWneKWgOKWgOKWmOKWneKWgOKWgOKWgCDilp3iloDi
lpgg4pad4paA4paA4paYIOKWgOKWneKWgOKWmOKWgOKWgOKWgOKWmOKWneKWgOKWgOKWgOKWgOKW
gOKWgOKWgOKWmOKWneKWneKWgOKWgCDiloAgICDilp3ilp3iloAgIOKWgCAgIOKWgOKWgOKWgOKW
gCAgICAgICAgICAgIOKUgg0KPiAgODIuMOKUpCAgICAgICAgICAgICDilp8gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAg4pSCDQo+ICAgICAg4pSCICAgICAgICAgICAgIOKWjCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICDilIINCj4gIDQ0LjXilKQgICAgICAgICAgICAg4paMICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IOKUgg0KPiAgIDcuMOKUpCAgICAgIOKWlyAgIOKWl+KWliDilowgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAg4pSCDQo+ICAgICAg4pSU4pSs4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSs4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSs4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSs
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSs4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSs4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSs4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSs4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSs4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSs4pSYDQo+ICAgICAwLjAwICAgICAgMC42NSAgICAgIDEuMzAgICAgICAgMS45
NSAgICAgIDIuNjAgICAgICAzLjI1ICAgICAgMy45MCAgICAgICA0LjU2ICAgICAgNS4yMSAgICAg
NS44Ng0KPg0KPiBOb3RlIGhvdyB0aGUgc2lnbmFsIGlzIG5vaXNpZXIgYW5kIGNhbiBwZWFrIHRv
IDE4MyB2cyAxNTcgbm93Lg0KPg0KPiBGaXhlczogYjU1OTQ1YzUwMGM1ICgic2NoZWQ6IEZpeCBw
aWNrX25leHRfdGFza19mYWlyKCkgdnMgdHJ5X3RvX3dha2VfdXAoKSByYWNlIikNCj4gU2lnbmVk
LW9mZi1ieTogUWFpcyBZb3VzZWYgPHF5b3VzZWZAbGF5YWxpbmEuaW8+DQo+IC0tLQ0KPg0KPiBU
aGlzIGlzIHNwbGl0IGZyb20gWzFdIHNlcmllcyB3aGVyZSBJIHN0dW1ibGVkIHVwb24gdGhpcyBw
cm9ibGVtLiBBRkFJQ1MgaXQNCj4gbmVlZHMgYmFja3BvcnRpbmcgYWxsIHRoZSB3YXkgdG8gNi4x
MiBMVFMuDQo+DQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjYwNTA0MDIw
MDAzLjcxMzA2LTEtcXlvdXNlZkBsYXlhbGluYS5pby8NCj4NCj4gIGtlcm5lbC9zY2hlZC9mYWly
LmMgfCA1ICsrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvZmFpci5jIGIva2VybmVsL3Nj
aGVkL2ZhaXIuYw0KPiBpbmRleCA3Mjg5NjU4NTE4NDIuLjk2YmE5N2U1ZjRhZSAxMDA2NDQNCj4g
LS0tIGEva2VybmVsL3NjaGVkL2ZhaXIuYw0KPiArKysgYi9rZXJuZWwvc2NoZWQvZmFpci5jDQo+
IEBAIC03NDAxLDYgKzc0MDEsOCBAQCBzdGF0aWMgaW50IGRlcXVldWVfZW50aXRpZXMoc3RydWN0
IHJxICpycSwgc3RydWN0IHNjaGVkX2VudGl0eSAqc2UsIGludCBmbGFncykNCj4gICAqLw0KPiAg
c3RhdGljIGJvb2wgZGVxdWV1ZV90YXNrX2ZhaXIoc3RydWN0IHJxICpycSwgc3RydWN0IHRhc2tf
c3RydWN0ICpwLCBpbnQgZmxhZ3MpDQo+ICB7DQo+ICsgICAgICAgaW50IHJldDsNCj4gKw0KPiAg
ICAgICAgIGlmICh0YXNrX2lzX3Rocm90dGxlZChwKSkgew0KPiAgICAgICAgICAgICAgICAgZGVx
dWV1ZV90aHJvdHRsZWRfdGFzayhwLCBmbGFncyk7DQo+ICAgICAgICAgICAgICAgICByZXR1cm4g
dHJ1ZTsNCj4gQEAgLTc0MDksOCArNzQxMSw5IEBAIHN0YXRpYyBib29sIGRlcXVldWVfdGFza19m
YWlyKHN0cnVjdCBycSAqcnEsIHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgaW50IGZsYWdzKQ0KPiAg
ICAgICAgIGlmICghcC0+c2Uuc2NoZWRfZGVsYXllZCkNCj4gICAgICAgICAgICAgICAgIHV0aWxf
ZXN0X2RlcXVldWUoJnJxLT5jZnMsIHApOw0KPg0KPiArICAgICAgIHJldCA9IGRlcXVldWVfZW50
aXRpZXMocnEsICZwLT5zZSwgZmxhZ3MpOw0KPiAgICAgICAgIHV0aWxfZXN0X3VwZGF0ZSgmcnEt
PmNmcywgcCwgZmxhZ3MgJiBERVFVRVVFX1NMRUVQKTsNCj4gLSAgICAgICBpZiAoZGVxdWV1ZV9l
bnRpdGllcyhycSwgJnAtPnNlLCBmbGFncykgPCAwKQ0KDQpIcm0sIHNvIHRoZSBTYXNoaWtvIHRv
b2wgcmFpc2VkIGEgcmVhc29uYWJsZSBjb25jZXJuIG9uIHRoZSBlYXJsaWVyDQp2ZXJzaW9uIG9m
IHRoaXM6DQogIGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MDUwNDAyMDAwMy43
MTMwNi0xLXF5b3VzZWYlNDBsYXlhbGluYS5pbz9wYXJ0PTEyDQoNClNwZWNpZmljYWxseSwgd2Ug
c2hvdWxkbid0IHJlZmVyZW5jZSBwIGFmdGVyIGRlcXVldWVfZW50aXRpZXMoKSBvciB3ZQ0Kcmlz
ayByYWNpbmcgd2l0aCBpdCBiZWluZyB3b2tlbiB1cCwgcnVubmluZywgYW5kIG1heWJlIGV4aXRp
bmcgb24NCmFub3RoZXIgY3B1Lg0KQW5kIHRoaXMgbW92ZXMgdGhlIHV0aWxfZXN0X3VwZGF0KCkg
Y2FsbCB0byBhZnRlciBkZXF1ZXVlIGZpbmlzaGVzLg0KDQpNYXliZSB0aGVyZSdzIHNvbWUgd2F5
IHRvIGhhdmUgdXRpbF9lc3RfdXBkYXRlKCkgY29tcGVuc2F0ZSBmb3IgdGhlDQp1bmZpbmlzaGVk
IGFjY291bnRpbmcgdGhhdCB3aWxsIGJlIGRvbmUgaW4gZGVxdWV1ZV9lbnRpdGllcygpPw0KDQp0
aGFua3MNCi1qb2huDQo=
