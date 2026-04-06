Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B7A38B7CF
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775500829; cv=none; b=Zrg01u1RNxjwFFDjQDTCuoNvEu2oB5PE8ajtJ3oCX9c5o8cRHpFO1UBvCAuk9zgkgUtVWRuAxuS7/lR+y5O1T6v3tGZA1oNS4Ae09aAr3D6sHwv5BcKv4Al3A9SCtP9rEeoJXFR7pO4bnaXcCZeY1Y7lBwwfBnj5s0tfB0d6xz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775500829; c=relaxed/simple;
	bh=8kUQZCNs26FSinhtPMK6ly0PzsQalFP0oGuZvAN9RP0=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=WizVMppLMoNgIKp3LiiY4dFQSGB3Xps3JgLnduySIrvxeydp24QkGU35yddUCLPZto3OlLk17F1Z9KyeceKU8JDrzyr5jbUKl/Wr9UNdAPNnBpiLm1UPDI9dmonFMJTw7ZLcfLoaJnEVFzsVJ5dx2jP4PPWhpER5bU/k9EOPQDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BxI/Y828; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BxI/Y828"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4233e152457so1272826fac.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 11:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775500823; x=1776105623; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DtrwOauEZjp1CSrLrgAWLX4O2rHkQdkPBv1alt/99Bw=;
        b=BxI/Y8283tyqHuXwvx8UMDGbv6XGhOuLBFyCl/150sO3jAzhVJwqI3klm5sUvVBNH/
         h+YmVuedJKFG0o0rNf0NNssLYfiIFNFt7pPZ7nLfNPoPbV33QM5bhuM8z19nmfFMec+s
         NKjUS2Yr5E3E9nJ3QGoYrAmrtu9+QmeiAy51g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775500823; x=1776105623;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtrwOauEZjp1CSrLrgAWLX4O2rHkQdkPBv1alt/99Bw=;
        b=dKjVzpcAq7YSlCg0KLOfRIA2hejI/fEH++iIkHSxQoMcs+3yBo/HK0387i+H8/ScoE
         w7uhM3kMKyMyYWsDMR/FUpeY78pwA7SZ5bg0zHp5NjglKxjYhHORjdVE0ZzSFuFvH+tu
         zA2ZT8SnSJtXi2vc4etosUAoj9fdhcyGfwNXhjCnr2P6RlxUCJH7RKPnpVTfvyFAorCS
         AkMwHu4L4mJg9L72iPllJLjyzw1eH1AtVqDXtEstOzTLtLG3iZNRQDTD2XvJ8lq4PPUA
         i6TRhHoenwq3GWw7ae5HxES82SmPRGrOmr43jnfUdhCQb4cfsLkC2GLK2eq+NePq0o1W
         1NNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyzffHI54R9U6+0vOgyKfLxGc8kwQk3PrCL1IrnSXoXerXnEIMrJdXIwgzif2qthL1WUlJ7v34Yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/e4FyEUCfykfP4ZtUxwtQVbwpAkQA9UdLiDYERdU9PqNXgaS
	cpRdo7VpMWgd5XYCXpIIIkC3VLHPJqoeIxHpKQCesmn3lLcjylDxm+1ckZYDXB7MviE=
X-Gm-Gg: AeBDiesjqvFdi5arItSiuy5A470kscdQWax2glrzwL5Gd4AP9uheYxglJwO6NSzVQG9
	vkRqnBv+VdZHU/fmBvG0jPEq59I9bjg3nmch2LulSoMw5sKIL4LML8hEQuHUMX6aV1efnLxgJMF
	sBiI4oJgOaeBaV8JSpKMl2YEy9PTJ2H2MANp7luzE4SdWrfL6u+6IHhGGTFjEyxcE8/yuT+RU+8
	AdApVxzO67xyBwL+0boBLI72psVF2emnGM3yVzNxvR22WN0EFZPKGjSE9SfIO3nBHM+qjF3ER6C
	WtJiMoMylaEDRbpGvshKpfbX9NHAU/iY186IjfrrGrciQ7iXleoCeRF1/2VI9mYl8UjlgQ2RMIX
	N8Oc5HpICwpMJ0Q4YlM4tt7ukv9BFhi5N5EBgspRqVB6koTBQ+JWaBmt9IcbtyFmNu5UxiKgnz9
	scjHFHfiXC0mr+GxhgVhdcLlNzRTPwarHZWZM=
X-Received: by 2002:a05:6820:1908:b0:67b:b0bd:8bd2 with SMTP id 006d021491bc7-6822083d572mr7194905eaf.59.1775500823611;
        Mon, 06 Apr 2026 11:40:23 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-680a882d978sm8932531eaf.10.2026.04.06.11.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 11:40:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------FJdVjfzVVDNpa7SwD4CvphGL"
Message-ID: <651e317c-dc31-4895-ac09-2f12398ed3be@linuxfoundation.org>
Date: Mon, 6 Apr 2026 12:40:22 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Thomas Renninger <trenn@suse.com>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, Thomas Renninger <trenn@suse.de>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower next update for Linux 7.1-rc1

This is a multi-part message in MIME format.
--------------FJdVjfzVVDNpa7SwD4CvphGL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the cpupower next update for Linux 7.1-rc1.

- Fixes errors in cpupower-frequency-info short option names
   to its manpage.
- Fixes cpupower-idle-info perf option name to its manpage.
- Adds boost and epp options to cpupower-frequency-info to its
   manpage.
- Adds description for perf-bias option to cpupower-info to its
   manpage.
- Removes unnecessary extern declarations from getopt.h in arguments
   parsing functions in cpufreq-set, cpuidle-info, cpuidle-set,
   cpupower-info, and cpupower-set utilities. These functions are
   defined getopt.h file.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit c369299895a591d96745d6492d4888259b004a9e:

   Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-7.1-rc1

for you to fetch changes up to 2fd3b83cacfb9160b896fb26117328eeb0598c54:

   cpupower: remove extern declarations in cmd functions (2026-04-06 11:25:32 -0600)

----------------------------------------------------------------
linux-cpupower-7.1-rc1

- Fixes errors in cpupower-frequency-info short option names
   to its manpage.
- Fixes cpupower-idle-info perf option name to its manpage.
- Adds boost and epp options to cpupower-frequency-info to its
   manpage.
- Adds description for perf-bias option to cpupower-info to its
   manpage.
- Removes unnecessary extern declarations from getopt.h in arguments
   parsing functions in cpufreq-set, cpuidle-info, cpuidle-set,
   cpupower-info, and cpupower-set utilities. These functions are
   defined getopt.h file.

----------------------------------------------------------------
Kaushlendra Kumar (1):
       cpupower: remove extern declarations in cmd functions

Roberto Ricci (4):
       cpupower-idle-info.1: fix short option names
       cpupower-frequency-info.1: use the proper name of the --perf option
       cpupower-frequency-info.1: document --boost and --epp options
       cpupower-info.1: describe the --perf-bias option

  tools/power/cpupower/man/cpupower-frequency-info.1 | 8 +++++++-
  tools/power/cpupower/man/cpupower-idle-info.1      | 4 ++--
  tools/power/cpupower/man/cpupower-info.1           | 9 ++++++++-
  tools/power/cpupower/utils/cpufreq-info.c          | 2 --
  tools/power/cpupower/utils/cpufreq-set.c           | 2 --
  tools/power/cpupower/utils/cpuidle-info.c          | 2 --
  tools/power/cpupower/utils/cpuidle-set.c           | 2 --
  tools/power/cpupower/utils/cpupower-info.c         | 2 --
  tools/power/cpupower/utils/cpupower-set.c          | 2 --
  9 files changed, 17 insertions(+), 16 deletions(-)
----------------------------------------------------------------
--------------FJdVjfzVVDNpa7SwD4CvphGL
Content-Type: text/x-patch; charset=UTF-8; name="linux-cpupower-7.1-rc1.diff"
Content-Disposition: attachment; filename="linux-cpupower-7.1-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL21hbi9jcHVwb3dlci1mcmVxdWVu
Y3ktaW5mby4xIGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvbWFuL2NwdXBvd2VyLWZyZXF1ZW5j
eS1pbmZvLjEKaW5kZXggNDdmZGQ3MjE4NzQ4Li5iMGQ2OWM5YWRjYmQgMTAwNjQ0Ci0tLSBh
L3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL21hbi9jcHVwb3dlci1mcmVxdWVuY3ktaW5mby4xCisr
KyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL21hbi9jcHVwb3dlci1mcmVxdWVuY3ktaW5mby4x
CkBAIC0zMiw2ICszMiwxMiBAQCBHZXRzIHRoZSBjdXJyZW50bHkgdXNlZCBjcHVmcmVxIHBv
bGljeS4KIFxmQlwtZ1xmUiBcZkJcLVwtZ292ZXJub3JzXGZSCiBEZXRlcm1pbmVzIGF2YWls
YWJsZSBjcHVmcmVxIGdvdmVybm9ycy4KIC5UUCAgCitcZkJcLWJcZlIgXGZCXC1cLWJvb3N0
XGZSCitHZXRzIHRoZSBjdXJyZW50IGJvb3N0IHN0YXRlIHN1cHBvcnQuCisuVFAKK1xmQlwt
elxmUiBcZkJcLVwtZXBwXGZSCitHZXRzIHRoZSBjdXJyZW50IEVQUCAoZW5lcmd5IHBlcmZv
cm1hbmNlIHByZWZlcmVuY2UpLgorLlRQCiBcZkJcLXJcZlIgXGZCXC1cLXJlbGF0ZWRcLWNw
dXNcZlIKIERldGVybWluZXMgd2hpY2ggQ1BVcyBydW4gYXQgdGhlIHNhbWUgaGFyZHdhcmUg
ZnJlcXVlbmN5LgogLlRQICAKQEAgLTUzLDcgKzU5LDcgQEAgaHVtYW5cLXJlYWRhYmxlIG91
dHB1dCBmb3IgdGhlIFwtZiwgXC13LCBcLXMgYW5kIFwteSBwYXJhbWV0ZXJzLgogXGZCXC1u
XGZSIFxmQlwtXC1uby1yb3VuZGluZ1xmUgogT3V0cHV0IGZyZXF1ZW5jaWVzIGFuZCBsYXRl
bmNpZXMgd2l0aG91dCByb3VuZGluZyBvZmYgdmFsdWVzLgogLlRQICAKLVxmQlwtY1xmUiBc
ZkJcLVwtcGVyZlxmUgorXGZCXC1jXGZSIFxmQlwtXC1wZXJmb3JtYW5jZVxmUgogR2V0IHBl
cmZvcm1hbmNlcyBhbmQgZnJlcXVlbmNpZXMgY2FwYWJpbGl0aWVzIG9mIENQUEMsIGJ5IHJl
YWRpbmcgaXQgZnJvbSBoYXJkd2FyZSAob25seSBhdmFpbGFibGUgb24gdGhlIGhhcmR3YXJl
IHdpdGggQ1BQQykuCiAuVFAKIC5TSCAiUkVNQVJLUyIKZGlmZiAtLWdpdCBhL3Rvb2xzL3Bv
d2VyL2NwdXBvd2VyL21hbi9jcHVwb3dlci1pZGxlLWluZm8uMSBiL3Rvb2xzL3Bvd2VyL2Nw
dXBvd2VyL21hbi9jcHVwb3dlci1pZGxlLWluZm8uMQppbmRleCAyMGI2MzQ1YzUzYWQuLmIy
ZjkyYWJhNWY1YiAxMDA2NDQKLS0tIGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvbWFuL2NwdXBv
d2VyLWlkbGUtaW5mby4xCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL21hbi9jcHVwb3dl
ci1pZGxlLWluZm8uMQpAQCAtMTEsMTAgKzExLDEwIEBAIEEgdG9vbCB3aGljaCBwcmludHMg
b3V0IHBlciBjcHUgaWRsZSBpbmZvcm1hdGlvbiBoZWxwZnVsIHRvIGRldmVsb3BlcnMgYW5k
IGludGVyCiAuU0ggIk9QVElPTlMiCiAuTFAKIC5UUAotXGZCXC1mXGZSIFxmQlwtXC1zaWxl
bnRcZlIKK1xmQlwtc1xmUiBcZkJcLVwtc2lsZW50XGZSCiBPbmx5IHByaW50IGEgc3VtbWFy
eSBvZiBhbGwgYXZhaWxhYmxlIEMtc3RhdGVzIGluIHRoZSBzeXN0ZW0uCiAuVFAKLVxmQlwt
ZVxmUiBcZkJcLVwtcHJvY1xmUgorXGZCXC1vXGZSIFxmQlwtXC1wcm9jXGZSCiBkZXByZWNh
dGVkLgogUHJpbnRzIG91dCBpZGxlIGluZm9ybWF0aW9uIGluIG9sZCAvcHJvYy9hY3BpL3By
b2Nlc3Nvci8qL3Bvd2VyIGZvcm1hdC4gVGhpcwogaW50ZXJmYWNlIGhhcyBiZWVuIHJlbW92
ZWQgZnJvbSB0aGUga2VybmVsIGZvciBxdWl0ZSBzb21lIHRpbWUsIGRvIG5vdCBsZXQKZGlm
ZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL21hbi9jcHVwb3dlci1pbmZvLjEgYi90
b29scy9wb3dlci9jcHVwb3dlci9tYW4vY3B1cG93ZXItaW5mby4xCmluZGV4IDM0MGJjZDBi
ZTdkZS4uMWY0MmQ4YzM4OGEwIDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci9t
YW4vY3B1cG93ZXItaW5mby4xCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL21hbi9jcHVw
b3dlci1pbmZvLjEKQEAgLTMsNyArMyw3IEBACiBjcHVwb3dlclwtaW5mbyBcLSBTaG93cyBw
cm9jZXNzb3IgcG93ZXIgcmVsYXRlZCBrZXJuZWwgb3IgaGFyZHdhcmUgY29uZmlndXJhdGlv
bnMKIC5TSCBTWU5PUFNJUwogLmZ0IEIKLS5CIGNwdXBvd2VyIGluZm8gWyBcLWIgXQorLkIg
Y3B1cG93ZXIgaW5mbyBbXGZJb3B0aW9uc1xmUF0KIAogLlNIIERFU0NSSVBUSU9OCiBcZkJj
cHVwb3dlciBpbmZvIFxmUCBzaG93cyBrZXJuZWwgY29uZmlndXJhdGlvbnMgb3IgcHJvY2Vz
c29yIGhhcmR3YXJlCkBAIC0xMyw2ICsxMywxMyBAQCBTb21lIG9wdGlvbnMgYXJlIHBsYXRm
b3JtIHdpZGUsIHNvbWUgYWZmZWN0IHNpbmdsZSBjb3Jlcy4gQnkgZGVmYXVsdCB2YWx1ZXMK
IG9mIGNvcmUgemVybyBhcmUgZGlzcGxheWVkIG9ubHkuIGNwdXBvd2VyIC0tY3B1IGFsbCBj
cHVpbmZvIHdpbGwgc2hvdyB0aGUKIHNldHRpbmdzIG9mIGFsbCBjb3Jlcywgc2VlIGNwdXBv
d2VyKDEpIGhvdyB0byBjaG9vc2Ugc3BlY2lmaWMgY29yZXMuCiAKKy5TSCAiT1BUSU9OUyIK
Ky5MUAorLlRQCitcZkJcLWJcZlIgXGZCXC1cLXBlcmYtYmlhc1xmUgorR2V0cyB0aGUgY3Vy
cmVudCBwZXJmb3JtYW5jZSBiaWFzIHZhbHVlLgorLlRQCisKIC5TSCAiU0VFIEFMU08iCiBP
cHRpb25zIGFyZSBkZXNjcmliZWQgaW4gZGV0YWlsIGluOgogCmRpZmYgLS1naXQgYS90b29s
cy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVmcmVxLWluZm8uYyBiL3Rvb2xzL3Bvd2VyL2Nw
dXBvd2VyL3V0aWxzL2NwdWZyZXEtaW5mby5jCmluZGV4IDVmZTAxZTUxNjgxNy4uNWEyNDJi
NDkxYTlkIDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVmcmVx
LWluZm8uYworKysgYi90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVmcmVxLWluZm8u
YwpAQCAtNTQyLDggKzU0Miw2IEBAIHN0YXRpYyBzdHJ1Y3Qgb3B0aW9uIGluZm9fb3B0c1td
ID0gewogCiBpbnQgY21kX2ZyZXFfaW5mbyhpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiB7Ci0J
ZXh0ZXJuIGNoYXIgKm9wdGFyZzsKLQlleHRlcm4gaW50IG9wdGluZCwgb3B0ZXJyLCBvcHRv
cHQ7CiAJaW50IHJldCA9IDAsIGNvbnQgPSAxOwogCXVuc2lnbmVkIGludCBjcHUgPSAwOwog
CXVuc2lnbmVkIGludCBodW1hbiA9IDA7CmRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVw
b3dlci91dGlscy9jcHVmcmVxLXNldC5jIGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMv
Y3B1ZnJlcS1zZXQuYwppbmRleCBjNWU2MGEzOWNmYTYuLjA2Y2Q0YjI4MDEzMiAxMDA2NDQK
LS0tIGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvY3B1ZnJlcS1zZXQuYworKysgYi90
b29scy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVmcmVxLXNldC5jCkBAIC0xOTUsOCArMTk1
LDYgQEAgc3RhdGljIGludCBkb19vbmVfY3B1KHVuc2lnbmVkIGludCBjcHUsIHN0cnVjdCBj
cHVmcmVxX3BvbGljeSAqbmV3X3BvbCwKIAogaW50IGNtZF9mcmVxX3NldChpbnQgYXJnYywg
Y2hhciAqKmFyZ3YpCiB7Ci0JZXh0ZXJuIGNoYXIgKm9wdGFyZzsKLQlleHRlcm4gaW50IG9w
dGluZCwgb3B0ZXJyLCBvcHRvcHQ7CiAJaW50IHJldCA9IDAsIGNvbnQgPSAxOwogCWludCBk
b3VibGVfcGFybSA9IDAsIHJlbGF0ZWQgPSAwLCBwb2xpY3ljaGFuZ2UgPSAwOwogCXVuc2ln
bmVkIGxvbmcgZnJlcSA9IDA7CmRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci91
dGlscy9jcHVpZGxlLWluZm8uYyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2NwdWlk
bGUtaW5mby5jCmluZGV4IDgxYjQ3NjNhOTdkNi4uY2NiMzcxMjViZDM3IDEwMDY0NAotLS0g
YS90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVpZGxlLWluZm8uYworKysgYi90b29s
cy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVpZGxlLWluZm8uYwpAQCAtMTM5LDggKzEzOSw2
IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjcHVpZGxlX2V4aXQoaW50IGZhaWwpCiAKIGludCBj
bWRfaWRsZV9pbmZvKGludCBhcmdjLCBjaGFyICoqYXJndikKIHsKLQlleHRlcm4gY2hhciAq
b3B0YXJnOwotCWV4dGVybiBpbnQgb3B0aW5kLCBvcHRlcnIsIG9wdG9wdDsKIAlpbnQgcmV0
ID0gMCwgY29udCA9IDEsIG91dHB1dF9wYXJhbSA9IDAsIHZlcmJvc2UgPSAxOwogCXVuc2ln
bmVkIGludCBjcHUgPSAwOwogCmRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci91
dGlscy9jcHVpZGxlLXNldC5jIGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvY3B1aWRs
ZS1zZXQuYwppbmRleCBhNTUxZDFkNGFjNTEuLjcwMzA5NGYxMzQzYyAxMDA2NDQKLS0tIGEv
dG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvY3B1aWRsZS1zZXQuYworKysgYi90b29scy9w
b3dlci9jcHVwb3dlci91dGlscy9jcHVpZGxlLXNldC5jCkBAIC0yNCw4ICsyNCw2IEBAIHN0
YXRpYyBzdHJ1Y3Qgb3B0aW9uIGluZm9fb3B0c1tdID0gewogCiBpbnQgY21kX2lkbGVfc2V0
KGludCBhcmdjLCBjaGFyICoqYXJndikKIHsKLQlleHRlcm4gY2hhciAqb3B0YXJnOwotCWV4
dGVybiBpbnQgb3B0aW5kLCBvcHRlcnIsIG9wdG9wdDsKIAlpbnQgcmV0ID0gMCwgY29udCA9
IDEsIHBhcmFtID0gMCwgZGlzYWJsZWQ7CiAJdW5zaWduZWQgbG9uZyBsb25nIGxhdGVuY3kg
PSAwLCBzdGF0ZV9sYXRlbmN5OwogCXVuc2lnbmVkIGludCBjcHUgPSAwLCBpZGxlc3RhdGUg
PSAwLCBpZGxlc3RhdGVzID0gMDsKZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2Vy
L3V0aWxzL2NwdXBvd2VyLWluZm8uYyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2Nw
dXBvd2VyLWluZm8uYwppbmRleCAxOGZkNzc1MWY1MDkuLjc5MTU0ZDcxZTQ5OCAxMDA2NDQK
LS0tIGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvdXRpbHMvY3B1cG93ZXItaW5mby5jCisrKyBi
L3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL3V0aWxzL2NwdXBvd2VyLWluZm8uYwpAQCAtMjgsOCAr
MjgsNiBAQCBzdGF0aWMgdm9pZCBwcmludF93cm9uZ19hcmdfZXhpdCh2b2lkKQogCiBpbnQg
Y21kX2luZm8oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogewotCWV4dGVybiBjaGFyICpvcHRh
cmc7Ci0JZXh0ZXJuIGludCBvcHRpbmQsIG9wdGVyciwgb3B0b3B0OwogCXVuc2lnbmVkIGlu
dCBjcHU7CiAJc3RydWN0IHV0c25hbWUgdXRzOwogCmRpZmYgLS1naXQgYS90b29scy9wb3dl
ci9jcHVwb3dlci91dGlscy9jcHVwb3dlci1zZXQuYyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2Vy
L3V0aWxzL2NwdXBvd2VyLXNldC5jCmluZGV4IDU1MGE5NDJlNzJjZS4uYzIxNzZiOWZhNTdk
IDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVwb3dlci1zZXQu
YworKysgYi90b29scy9wb3dlci9jcHVwb3dlci91dGlscy9jcHVwb3dlci1zZXQuYwpAQCAt
MzMsOCArMzMsNiBAQCBzdGF0aWMgdm9pZCBwcmludF93cm9uZ19hcmdfZXhpdCh2b2lkKQog
CiBpbnQgY21kX3NldChpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiB7Ci0JZXh0ZXJuIGNoYXIg
Km9wdGFyZzsKLQlleHRlcm4gaW50IG9wdGluZCwgb3B0ZXJyLCBvcHRvcHQ7CiAJdW5zaWdu
ZWQgaW50IGNwdTsKIAlzdHJ1Y3QgdXRzbmFtZSB1dHM7CiAK

--------------FJdVjfzVVDNpa7SwD4CvphGL--
