Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990433;
	b=k6aXOd+U/rqXhYN+hViMVveuE7ncOtafJY/b0Wn25KlATmQJzmQ9s8saFxHu5YzIPf4m
	 OzvQ5OyIthgaPBa5hklB8u6JcB8YFX1lDkFuOjmPsb4iU1heEBk2fYAzyf7hEaAGT0Dcl
	 q4mzF5sDIjONCi9tRS4S37Ak6v5p/VssfjrdRLVSSvxChCTtCpNhJ5LBv6enqdyks+qiO
	 ILgfwHvWshnjxhPDdN7OsDlpfRVZSaAC7rl9YNbxniZ+70xSq4lbozaiEBr0cEI5nJoMX
	 UJFOZ3QzTv92L/Gc2LypF2+GrhwlNanKiShYDB4v4I+KEI9peCxl8LfDUfGXK+RxjvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990433;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:DKIM-Signature;
	bh=xw8y7NipFBtF37TOjU1QzM3pd2cVDyuZyFnPeUbK0KM=;
	b=lHQiKrB2yt19ggiGFOJVeX+bOBeT+k5Gq5GX64mgYO+gXdTAdZ+mGPM7nxowzDdvl6t1
	 9bz/jtYtrg4vIkPEzxSdZa6vist3tSzijmjweCYsdwhkva9MLNbiotkzY0Pgx5/1uHA0C
	 TLrrYR10Sde89enUtaa6kQIG3d6hQZg3LbhwwF8EldylU6VDf0AB6l31Jp7D/oTgzgZLv
	 BiQbxf10RVpB7jEp88Iwv/pdwnWCFcO4PjUMonbAtIobxdMjmBU/d7nzxkJWafmvMAYzd
	 SjuGL2EFk7UlHCpxO+dn3A94Bv5r/AozuOh+Wx4DS8GG7U/MoCRDgO1MVGXt7ibWXDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=QfzpUOnt;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 70B40606A329;
	Fri,  6 Nov 2026 18:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70B40606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=QfzpUOnt
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <zhongqiu.han@oss.qualcomm.com>, Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v5 0/2] cpufreq: acpi-cpufreq: fix P-state index mismatch between perf->states[] and freq_table[]
Date: Sat, 7 Nov 2026 02:40:06 +0800
Message-ID: <20261106184008.1728-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc7.internal.baidu.com (172.31.3.17) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1793990420;
	bh=xw8y7NipFBtF37TOjU1QzM3pd2cVDyuZyFnPeUbK0KM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=QfzpUOntR53qSLC19f8ZPvL6ZBJUKbjAJUi3a/UxXfXxwFTzJfF9b5ioM6x7wUCOf
	 sL3z88irQWF2MfNvk1CKRYkT37rUZWLphspLl69vNYlyNEWKcTZCn+8b2InW4h1NQp
	 y86+deAWF95ttuhURHQEUNkIDae3JSHP1wmQX54aOTfZSpg654b9UV8zlpC7VJ8fKi
	 t5PbSyi3Jlp7fMUWlfZrbiGPLkHmBR5iXm4S8qfvNCQC2EGVoTr5GzqoBEVrEssfdc
	 R5dvKN2VF3fuUbH/ssC7qqa+U4cZyQV0fPlGfo+6HrH0AuwxL9kzeN7smQDK7VHAkv
	 n4Cn71MgnbiFA==

From: Li RongQing <lirongqing@baidu.com>

policy->freq_table is built by filtering out _PSS entries that are not
lower in frequency than the previous one, and the original ACPI P-state
index of each remaining entry is kept in freq_table[].driver_data.  The
index spaces of perf->states[] and freq_table[] therefore differ, and
mixing them up leads to the frequency of one P-state being attributed to
another.

Patch 1/2 is unchanged from v4 and fixes the cached frequency used by
get_cur_freq_on_cpu() to detect a firmware frequency change behind the
OS's back.

Patch 2/2 is new in v5.  As Rafael pointed out, Sashiko observed that
the extract_msr() fallback interferes with 1/2 and can render it
ineffective: when the status read from the hardware matches no
freq_table entry, extract_msr() returns freq_table[0].frequency instead
of reporting the status as unknown.  If the OS is already at the P-state
corresponding to freq_table[0], a firmware switch to a filtered-out
P-state then compares equal to the cached frequency, data->resume is
left clear and the next ->target() call does not rewrite the control
register.  So 1/2 alone does not make the detection work in that case,
and the two patches are posted together rather than separately as I had
suggested earlier.

v4: https://lkml.iu.edu/2609.1/07369.html

Changes since v4:
 - Drop "cpufreq: acpi-cpufreq: fix P-state index mismatch in
   extract_io()", which has been applied.  This series is based on top
   of it.
 - Add 2/2 to stop extract_msr() from masking firmware P-state changes,
   as reported by Sashiko, and note the dependency in 1/2's changelog.
 - 1/2: no functional change; changelog extended to say that it fixes
   only the cached side of the comparison, and a duplicate
   Signed-off-by was removed.

Li RongQing (2):
  cpufreq: acpi-cpufreq: fix P-state index mismatch in
    get_cur_freq_on_cpu()
  cpufreq: acpi-cpufreq: don't mask firmware P-state changes

 drivers/cpufreq/acpi-cpufreq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.9.4

