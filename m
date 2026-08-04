Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E2448094C
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879117; cv=none; b=Y/bfPxuZpfdyTMYmO77uBwYqd2OJvswG02EW15k19+lvEHswjyZ2L0OrtR9wMEJk6EAPrMiV3sg1TV8sptu/G/NSBKfbzr1kvocHbHiVM4DCYiDXe/R1LgY2AA5jRRGYQf9Tgmu3S91XHrXsGkIXLqBwTGqpWto9fKQm0POApns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879117; c=relaxed/simple;
	bh=3vxfS/69riCyZNoXsiJy+qHhhZMeQuFWbt0Fw+qo1cQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=k9BC8nNNnbOFLVFtSV8ANgecNsne3IJ8uuvDGYIsNcEaMJX9rfjV/9ucxskOUBNulwOl/+dzSuq/Wt4fC9/hqC2UDvs0v2GkYb2WKTTnX17cvrhtat8RFSOSkqToOOb/GLBfqfGCwhpytGHRqLkDcyJt3Weru4dujviFiUU31uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QA1dAYp4; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QA1dAYp4"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso405208a34.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 14:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785879114; x=1786483914; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:content-type:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=89pw+XY5BbRzs0no33jRqtqZcVlQ3SUK/uwa+AQgu+M=;
        b=QA1dAYp4DgQKrtCb84ElEWRpBaWTRWN+82/TuaXHuZ2AVFnnxCfBU4JIWhxFP2ZqT5
         8k0ywNKwry61NGyARjC6wZS8UaFha5AYiVLA0kQZQkejAUd4gVIKf9lqQHBOPZ50SVi6
         /LtwZnpu+KYfEN5Vs3vY0DyCeHbf9qNmq9bJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879114; x=1786483914;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=89pw+XY5BbRzs0no33jRqtqZcVlQ3SUK/uwa+AQgu+M=;
        b=U29YeLxdA0DiHoQ4oymkspJ+sZXsYp7qZtMzyuUFzDwUWOYpXv+BxngqH5zdv769E1
         k6jP+2TfhFQBDEXnjCyDJoXcajZu8/a0Dn0p7e7ez9bXCWrJrNsAPcis0T6yxyp1PqKg
         vKsCNCWJwg7tLjRDNS5I3NrI24XKAHY/EUOePwu+L1jBumNrTHFHkFP3m7bgzarZA+JG
         D5Kem8o8+KqBTYc9OjaGm33ieV33zxF5yrIJwcVKccFK1/7Qtv3LBsDYVWHyMe9oa4kL
         BIqHlIBzmK1H0XY0mjyf2Of7Oj9OYiCI/g18GMAfuV1S6wNLiakEQ16XGSXwrOtlDvaQ
         bmjg==
X-Forwarded-Encrypted: i=1; AHgh+RoV0WcWlmXuGYGmXmRylKsY78FqeEHAd/V3z2/oIGIlKrQ8cKiNufMLhbZ46E3kNIvWUDgTOokAOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwU3+hD3S74xoTVgGw/f6wzG8vz+xzc0WZoDZjOzZ7PNWTv0o1i
	ooeZ27vGfjH/B35wznPwqHZe0bjIOwBcqshJHb7LLN+YW+t+K1pdXuJg7ZHW3VA+q3c=
X-Gm-Gg: AR+sD12E+vnVECqMwMqSqz/iaoJNxnC04pHqkh/89mfJxEKvvJsZROyNge/sAEoJUzk
	/5LKq8jSZlLUGKisR1ctoQiCU+B7bk5m/ND1rq2RXMyZKCdS0ZSNYLHYSBlj4bYX+daLYSD+xOJ
	gjU9gU2SPwxD36nemzbQrg7/tbLPlV1dpE3R/2eUksk1Z1Og0MdZoYLeD1CU3CXimcq4ce/eUZf
	+kIg+iShIInVmFj0Ri5sfv4ePzF08KRHmZD3EyP3sfWGk12rdXHqNHSU2knW5MlMvfT+8mWpfz3
	I771+GAkNDMWxNXB+mN3qzZCq2DbLIFRPbolTvM19hNy3jJEQh6npqYWcxPNq/aEgepi5y5rZGh
	uVgYoP5slHscm/iQ9cOR6K0gTWtoQsCYZKdwuCPU/vKqx64aWGBzsoJhnYsQxJsnyOhfajFVvr7
	uKZTOEn7T8zQL294LMsdsO2xIYq7JvIu5YfnZMzkbxJM57loggBLmZTeZpSevAqiKo2q9baWwa2
	mXe3jTv4Q==
X-Received: by 2002:a05:6808:c2b4:b0:4a4:ed9a:e7ac with SMTP id 5614622812f47-4afadf225bfmr1190364b6e.1.1785879114085;
        Tue, 04 Aug 2026 14:31:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae45b630sm501966b6e.1.2026.08.04.14.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 14:31:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------GL0sHtqE1xVPGiq00ahlbuk0"
Message-ID: <962d2e30-9270-4652-b802-1676966b7968@linuxfoundation.org>
Date: Tue, 4 Aug 2026 15:31:49 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Thomas Renninger <trenn@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower fixes update for Linux 7.3-rc1

This is a multi-part message in MIME format.
--------------GL0sHtqE1xVPGiq00ahlbuk0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the cpupower update for Linux 7.3-rc1.

Adds support for generic CPPC display that depends only on standardized
fields, improving AMD specific implementation for the same.

Removes conditional return with no effect as part of tree-wide code clean
up effort.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

   Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-7.3-rc1

for you to fetch changes up to adfe0057326ffbc2cd5ff69a57ec0e50b5e74095:

   cpupower: remove conditional return with no effect (2026-08-04 13:12:06 -0600)

----------------------------------------------------------------
linux-cpupower-7.3-rc1

Adds support for generic CPPC display that depends only on standardized
fields, improving AMD specific implementation for the same.

Removes conditional return with no effect as part of tree-wide code clean
up effort.

----------------------------------------------------------------
Jeremy Linton (4):
       cpupower: Add generic CPPC performance display
       cpupower: Build and call CPPC information on non-AMD processors
       cpupower: Print kernel and hardware frequency information
       cpupower: Add libm to cpupower for generic CPPC view

Sang-Heon Jeon (1):
       cpupower: remove conditional return with no effect

  tools/power/cpupower/Makefile                |  6 +--
  tools/power/cpupower/utils/cpufreq-info.c    | 11 +++---
  tools/power/cpupower/utils/helpers/cppc.c    | 56 ++++++++++++++++++++++++++++
  tools/power/cpupower/utils/helpers/helpers.h |  2 +
  tools/power/cpupower/utils/powercap-info.c   |  2 -
  5 files changed, 67 insertions(+), 10 deletions(-)
  create mode 100644 tools/power/cpupower/utils/helpers/cppc.c
----------------------------------------------------------------
--------------GL0sHtqE1xVPGiq00ahlbuk0
Content-Type: text/x-patch; charset=UTF-8; name="linux-cpupower-7.3-rc1.diff"
Content-Disposition: attachment; filename="linux-cpupower-7.3-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlIGIvdG9vbHMvcG93
ZXIvY3B1cG93ZXIvTWFrZWZpbGUKaW5kZXggOTY5NzE2ZGZlOGRlLi5hYjQyOGUzMzZkODcg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCisrKyBiL3Rvb2xz
L3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCkBAIC0xMzEsNyArMTMxLDcgQEAgb3ZlcnJpZGUg
Q0ZMQUdTICs9IC1EVkVSU0lPTj1cIiQoVkVSU0lPTilcIiAtRFBBQ0tBR0U9XCIkKFBBQ0tB
R0UpXCIgXAogCiBVVElMX09CSlMgPSAgdXRpbHMvaGVscGVycy9hbWQubyB1dGlscy9oZWxw
ZXJzL21zci5vIFwKIAl1dGlscy9oZWxwZXJzL3N5c2ZzLm8gdXRpbHMvaGVscGVycy9taXNj
Lm8gdXRpbHMvaGVscGVycy9jcHVpZC5vIFwKLQl1dGlscy9oZWxwZXJzL3BjaS5vIHV0aWxz
L2hlbHBlcnMvYml0bWFzay5vIFwKKwl1dGlscy9oZWxwZXJzL3BjaS5vIHV0aWxzL2hlbHBl
cnMvYml0bWFzay5vIHV0aWxzL2hlbHBlcnMvY3BwYy5vIFwKIAl1dGlscy9pZGxlX21vbml0
b3IvbmhtX2lkbGUubyB1dGlscy9pZGxlX21vbml0b3Ivc25iX2lkbGUubyBcCiAJdXRpbHMv
aWRsZV9tb25pdG9yL2hzd19leHRfaWRsZS5vIFwKIAl1dGlscy9pZGxlX21vbml0b3IvYW1k
X2ZhbTE0aF9pZGxlLm8gdXRpbHMvaWRsZV9tb25pdG9yL2NwdWlkbGVfc3lzZnMubyBcCkBA
IC0yMzYsOSArMjM2LDkgQEAgJChPVVRQVVQpJS5vOiAlLmMKICQoT1VUUFVUKWNwdXBvd2Vy
OiAkKFVUSUxfT0JKUykgJChPVVRQVVQpJChMSUJDUFVQT1dFUikKIAkkKEVDSE8pICIgIEND
ICAgICAgIiAkQAogaWZlcSAoJChzdHJpcCAkKFNUQVRJQykpLHRydWUpCi0JJChRVUlFVCkg
JChDQykgJChDRkxBR1MpICQoTERGTEFHUykgJChVVElMX09CSlMpIC1scnQgLWxwY2kgLUwk
KE9VVFBVVCkgLW8gJEAKKwkkKFFVSUVUKSAkKENDKSAkKENGTEFHUykgJChMREZMQUdTKSAk
KFVUSUxfT0JKUykgLWxtIC1scnQgLWxwY2kgLUwkKE9VVFBVVCkgLW8gJEAKIGVsc2UKLQkk
KFFVSUVUKSAkKENDKSAkKENGTEFHUykgJChMREZMQUdTKSAkKFVUSUxfT0JKUykgLWxjcHVw
b3dlciAtbHJ0IC1scGNpIC1MJChPVVRQVVQpIC1vICRACisJJChRVUlFVCkgJChDQykgJChD
RkxBR1MpICQoTERGTEFHUykgJChVVElMX09CSlMpIC1sbSAtbGNwdXBvd2VyIC1scnQgLWxw
Y2kgLUwkKE9VVFBVVCkgLW8gJEAKIGVuZGlmCiAJJChRVUlFVCkgJChTVFJJUENNRCkgJEAK
IApkaWZmIC0tZ2l0IGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvY3B1ZnJlcS1pbmZv
LmMgYi90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVmcmVxLWluZm8uYwppbmRleCA1
YTI0MmI0OTFhOWQuLjExNjI5YWU0OWY5OCAxMDA2NDQKLS0tIGEvdG9vbHMvcG93ZXIvY3B1
cG93ZXIvdXRpbHMvY3B1ZnJlcS1pbmZvLmMKKysrIGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIv
dXRpbHMvY3B1ZnJlcS1pbmZvLmMKQEAgLTI3MCwxMCArMjcwLDEwIEBAIHN0YXRpYyBpbnQg
Z2V0X2ZyZXFfaGFyZHdhcmUodW5zaWduZWQgaW50IGNwdSwgdW5zaWduZWQgaW50IGh1bWFu
KQogewogCXVuc2lnbmVkIGxvbmcgZnJlcTsKIAotCWlmICghKGNwdXBvd2VyX2NwdV9pbmZv
LmNhcHMgJiBDUFVQT1dFUl9DQVBfQVBFUkYpKQorCWZyZXEgPSBjcHVmcmVxX2dldF9mcmVx
X2hhcmR3YXJlKGNwdSk7CisJaWYgKCEoY3B1cG93ZXJfY3B1X2luZm8uY2FwcyAmIENQVVBP
V0VSX0NBUF9BUEVSRikgJiYgIWZyZXEpCiAJCXJldHVybiAtRUlOVkFMOwogCi0JZnJlcSA9
IGNwdWZyZXFfZ2V0X2ZyZXFfaGFyZHdhcmUoY3B1KTsKIAlwcmludGYoXygiICBjdXJyZW50
IENQVSBmcmVxdWVuY3k6ICIpKTsKIAlpZiAoIWZyZXEpIHsKIAkJcHJpbnRmKCJVbmFibGUg
dG8gY2FsbCBoYXJkd2FyZVxuIik7CkBAIC00NzcsMTIgKzQ3NywxMyBAQCBzdGF0aWMgaW50
IGdldF9sYXRlbmN5KHVuc2lnbmVkIGludCBjcHUsIHVuc2lnbmVkIGludCBodW1hbikKIH0K
IAogLyogLS1wZXJmb3JtYW5jZSAvIC1jICovCi0KIHN0YXRpYyBpbnQgZ2V0X3BlcmZfY2Fw
KHVuc2lnbmVkIGludCBjcHUpCiB7CiAJaWYgKGNwdXBvd2VyX2NwdV9pbmZvLnZlbmRvciA9
PSBYODZfVkVORE9SX0FNRCAmJgogCSAgICBjcHVwb3dlcl9jcHVfaW5mby5jYXBzICYgQ1BV
UE9XRVJfQ0FQX0FNRF9QU1RBVEUpCiAJCWFtZF9wc3RhdGVfc2hvd19wZXJmX2FuZF9mcmVx
KGNwdSwgbm9fcm91bmRpbmcpOworCWVsc2UKKwkJY3BwY19zaG93X3BlcmZfYW5kX2ZyZXEo
Y3B1LCBub19yb3VuZGluZyk7CiAKIAlyZXR1cm4gMDsKIH0KQEAgLTUxMyw4ICs1MTQsOCBA
QCBzdGF0aWMgdm9pZCBkZWJ1Z19vdXRwdXRfb25lKHVuc2lnbmVkIGludCBjcHUpCiAKIAln
ZXRfYXZhaWxhYmxlX2dvdmVybm9ycyhjcHUpOwogCWdldF9wb2xpY3koY3B1KTsKLQlpZiAo
Z2V0X2ZyZXFfaGFyZHdhcmUoY3B1LCAxKSA8IDApCi0JCWdldF9mcmVxX2tlcm5lbChjcHUs
IDEpOworCWdldF9mcmVxX2hhcmR3YXJlKGNwdSwgMSk7CisJZ2V0X2ZyZXFfa2VybmVsKGNw
dSwgMSk7CiAJZ2V0X2Jvb3N0X21vZGUoY3B1KTsKIAlnZXRfcGVyZl9jYXAoY3B1KTsKIH0K
ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2hlbHBlcnMvY3BwYy5j
IGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvaGVscGVycy9jcHBjLmMKbmV3IGZpbGUg
bW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi4zNDkzY2U4NTUxZWEKLS0tIC9kZXYv
bnVsbAorKysgYi90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9oZWxwZXJzL2NwcGMuYwpA
QCAtMCwwICsxLDU2IEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAor
CisjaW5jbHVkZSA8c3RkaW8uaD4KKyNpbmNsdWRlIDxlcnJuby5oPgorI2luY2x1ZGUgPHN0
ZGxpYi5oPgorI2luY2x1ZGUgPHN0cmluZy5oPgorI2luY2x1ZGUgPG1hdGguaD4KKworI2lu
Y2x1ZGUgImhlbHBlcnMvaGVscGVycy5oIgorI2luY2x1ZGUgImNwdWZyZXEuaCIKKyNpbmNs
dWRlICJhY3BpX2NwcGMuaCIKKworI2RlZmluZSBjcHBjX3RvX2ZyZXF1ZW5jeShwZXJmKSAo
cm91bmRmKHNsb3BlICogKHBlcmYpICsgaW50ZXJjZXB0KSkKKwordm9pZCBjcHBjX3Nob3df
cGVyZl9hbmRfZnJlcSh1bnNpZ25lZCBpbnQgY3B1LCBpbnQgbm9fcm91bmRpbmcpCit7CisJ
aW50NjRfdCBub21pbmFsID0gYWNwaV9jcHBjX2dldF9kYXRhKGNwdSwgTk9NSU5BTF9QRVJG
KTsKKwlpbnQ2NF90IG5vbWluYWxfZnJlcSA9IGFjcGlfY3BwY19nZXRfZGF0YShjcHUsIE5P
TUlOQUxfRlJFUSkgKiAxMDAwOworCWludDY0X3QgbG93ZXN0ID0gYWNwaV9jcHBjX2dldF9k
YXRhKGNwdSwgTE9XRVNUX1BFUkYpOworCWludDY0X3QgbG93ZXN0X2ZyZXEgPSBhY3BpX2Nw
cGNfZ2V0X2RhdGEoY3B1LCBMT1dFU1RfRlJFUSkgKiAxMDAwOworCXVuc2lnbmVkIGxvbmcg
bm9uX2xpbmVhciA9IGFjcGlfY3BwY19nZXRfZGF0YShjcHUsIExPV0VTVF9OT05MSU5FQVJf
UEVSRik7CisJdW5zaWduZWQgbG9uZyBoaWdoZXN0ID0gYWNwaV9jcHBjX2dldF9kYXRhKGNw
dSwgSElHSEVTVF9QRVJGKTsKKwlmbG9hdCBzbG9wZSwgaW50ZXJjZXB0OworCisJLyogZG8g
dGhlIG9wdGlvbmFsIGZyZXEgZmllbGRzIGxvb2sgaW52YWxpZD8gKi8KKwlpZiAoIW5vbWlu
YWxfZnJlcSB8fCAhbG93ZXN0X2ZyZXEgfHwgbm9taW5hbCA9PSBsb3dlc3QpCisJCXJldHVy
bjsKKworCXNsb3BlID0gKGZsb2F0KShub21pbmFsX2ZyZXEgLSBsb3dlc3RfZnJlcSkgLyAo
bm9taW5hbCAtIGxvd2VzdCk7CisJaW50ZXJjZXB0ID0gbG93ZXN0X2ZyZXEgLSBzbG9wZSAq
IGxvd2VzdDsKKworCXByaW50ZihfKCIgIENQUEMgbGltaXRzOlxuIikpOworCXByaW50Zihf
KCIgICAgSGlnaGVzdCBQZXJmb3JtYW5jZTogJWx1LiBNYXhpbXVtIEZyZXF1ZW5jeTogIiks
CisJICAgICAgIGhpZ2hlc3QpOworCS8qCisJICogSWYgYm9vc3QgaXNuJ3QgYWN0aXZlLCB0
aGUgY3B1aW5mb19tYXggZG9lc24ndCBpbmRpY2F0ZSByZWFsIG1heAorCSAqIGZyZXF1ZW5j
eS4KKwkgKi8KKwlwcmludF9zcGVlZChjcHBjX3RvX2ZyZXF1ZW5jeShoaWdoZXN0KSwgbm9f
cm91bmRpbmcpOworCXByaW50ZigiLlxuIik7CisKKwlwcmludGYoXygiICAgIE5vbWluYWwg
UGVyZm9ybWFuY2U6ICVsdS4gTm9taW5hbCBGcmVxdWVuY3k6ICIpLAorCSAgICAgICBhY3Bp
X2NwcGNfZ2V0X2RhdGEoY3B1LCBOT01JTkFMX1BFUkYpKTsKKwlwcmludF9zcGVlZChub21p
bmFsX2ZyZXEsICBub19yb3VuZGluZyk7CisJcHJpbnRmKCIuXG4iKTsKKworCXByaW50Zihf
KCIgICAgTG93ZXN0IE5vbi1saW5lYXIgUGVyZm9ybWFuY2U6ICVsdS4gTG93ZXN0IE5vbi1s
aW5lYXIgRnJlcXVlbmN5OiAiKSwKKwkgICAgICAgbm9uX2xpbmVhcik7CisJcHJpbnRfc3Bl
ZWQoY3BwY190b19mcmVxdWVuY3kobm9uX2xpbmVhciksIG5vX3JvdW5kaW5nKTsKKwlwcmlu
dGYoIi5cbiIpOworCisJcHJpbnRmKF8oIiAgICBMb3dlc3QgUGVyZm9ybWFuY2U6ICVsdS4g
TG93ZXN0IEZyZXF1ZW5jeTogIiksCisJICAgICAgIGFjcGlfY3BwY19nZXRfZGF0YShjcHUs
IExPV0VTVF9QRVJGKSk7CisJcHJpbnRfc3BlZWQobG93ZXN0X2ZyZXEsIG5vX3JvdW5kaW5n
KTsKKwlwcmludGYoIi5cbiIpOworfQpkaWZmIC0tZ2l0IGEvdG9vbHMvcG93ZXIvY3B1cG93
ZXIvdXRpbHMvaGVscGVycy9oZWxwZXJzLmggYi90b29scy9wb3dlci9jcHVwb3dlci91dGls
cy9oZWxwZXJzL2hlbHBlcnMuaAppbmRleCBhM2FkODBiOWMyYzIuLjljNTEyNmI2Mzk2NiAx
MDA2NDQKLS0tIGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvaGVscGVycy9oZWxwZXJz
LmgKKysrIGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvaGVscGVycy9oZWxwZXJzLmgK
QEAgLTIyMSw0ICsyMjEsNiBAQCB2b2lkIHByaW50X29ubGluZV9jcHVzKHZvaWQpOwogdm9p
ZCBwcmludF9vZmZsaW5lX2NwdXModm9pZCk7CiB2b2lkIHByaW50X3NwZWVkKHVuc2lnbmVk
IGxvbmcgc3BlZWQsIGludCBub19yb3VuZGluZyk7CiAKK3ZvaWQgY3BwY19zaG93X3BlcmZf
YW5kX2ZyZXEodW5zaWduZWQgaW50IGNwdSwgaW50IG5vX3JvdW5kaW5nKTsKKwogI2VuZGlm
IC8qIF9fQ1BVUE9XRVJVVElMU19IRUxQRVJTX18gKi8KZGlmZiAtLWdpdCBhL3Rvb2xzL3Bv
d2VyL2NwdXBvd2VyL3V0aWxzL3Bvd2VyY2FwLWluZm8uYyBiL3Rvb2xzL3Bvd2VyL2NwdXBv
d2VyL3V0aWxzL3Bvd2VyY2FwLWluZm8uYwppbmRleCBlNTMwMzM0ODgyMTguLjg4YTVlZGI3
NjMxNSAxMDA2NDQKLS0tIGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvcG93ZXJjYXAt
aW5mby5jCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL3Bvd2VyY2FwLWluZm8u
YwpAQCAtNDcsOCArNDcsNiBAQCBzdGF0aWMgaW50IHBvd2VyY2FwX3ByaW50X29uZV96b25l
KHN0cnVjdCBwb3dlcmNhcF96b25lICp6b25lKQogCiAJcHJpbnRmKCJcbiIpOwogCi0JaWYg
KHJldCAhPSAwKQotCQlyZXR1cm4gcmV0OwogCXJldHVybiByZXQ7CiB9CiAK

--------------GL0sHtqE1xVPGiq00ahlbuk0--
