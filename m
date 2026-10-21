Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598172;
	b=eWmT0Q5qNgLCxBX75jNVwQjAzruM52zwK2ACaVAUZp+yYT/ekW3Jd6Pvjp2mYBWLgtLZ
	 ruogkGnAPgNhPeK4bE6PWMU/94oDq9DXvy0RogjFzKMbxIJZLKT1ZCxR8vRvXCNTvgIB7
	 1KIbvDfFi8iFXrPYi9xZOEoKF7121eIuOtp8ObpS5LHBFoyDV8xRJk6OuQpo8D2GrHxsj
	 UMFdY5l4jM216pi9hAb5WDn9eZ6TMOxIr8j63K4D2EZWtuy4q5bLvpwo1uJo7otJ9+r9w
	 PbNiVQxuZGAlpxE/Dyb4gF4MV6zWLpv4qnE0SuyRLL+ZlGJvS0JUsSNVtHyDO1QLVGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598172;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=Y6AwjdT9yQmM01ZS1F1iqwMAeAkImNPOEFmbSCC+YIk=;
	b=AYClb/NFoZZMmG38OCABnq4i8y5s2AuHPnqiyEOMmjI6OvLRoETNyuk951XpoUqgrFWj
	 3+MH9B1LxXYB1qge+fuf21bQ4TC1DYM6Nw6qBB+6CbvVNkLsu85RXJ0lBaapo8arC5EJY
	 5NJ3t8WTRZfw7a0/h3LVNBr/6hiytizlDoXkuSMIMmrkgkNaZKs+gxjUxzXBXljGR0F6F
	 rY46zVLHQvXgyikTEa/Se/5EZhE9dL0GnZVhXjfbnYn+jb9AihwFEwZ7wfWIILdlCnkFg
	 6UY2Og8pQ9Cokp6NS2wjhncvpRJP+8MEuZn1+ettbhDb3u5/S+Zdj1GRxMLh91RB3qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FG5ynM2N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77FE606A31B;
	Wed, 21 Oct 2026 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FG5ynM2N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A88B1F000C1;
	Wed, 21 Oct 2026 15:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792598171;
	bh=Y6AwjdT9yQmM01ZS1F1iqwMAeAkImNPOEFmbSCC+YIk=;
	h=From:To:Cc:Subject:Date;
	b=FG5ynM2NSqNFseBrkCrvl08AP3PaMsmS8zA7K6vmH/KvDMuTroLS4flFy29So6JLu
	 Qk9XYvHWEXUbHId8HKAqsJBoO85evn3LuUqzZ+QWegI8zm4RmtTgIfxAk5zoDKLXlu
	 iWT8CuR1s8eik4vD/T4tBv0OMWQs910WQU6cKHOaNY5/jPjHBFRxU9g4gt85Y5IKkQ
	 w9kYaWUt92yP3lipc76WRrvHFsMKKHRflN2uhINlscjjMFoun2yiVd31c1fSaCgUb2
	 D6C9wLIcH/u1xpmH8zZzFiWRK0ZLo2KnzuH9ztWZvemW228vA7HmioWnxZTtIvitfa
	 4a8Da1EnOBlTg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Subject:
 [PATCH v1] intel_idle: Adjust state names and descriptions for _LPI states
Date: Wed, 21 Oct 2026 17:56:08 +0200
Message-ID: <6061409.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The value of the _LPI "State Name" field is used as the description of
the given idle state (that is, the value of it "desc" attribute in
sysfs) which is not consistent with idle state descriptions used when
the idle state information comes from an ACPI _CST object.

To rectify that, use the _LPI "State Name" field value as the value of
the "name" sysfs attribute of a given idle state and use the MWAIT hint
value from the _LPI register address value to derive the value of its
"desc" sysfs attribute in analogy with the _CST case.

Fixes: abc5c103c66d ("intel_idle: Add ACPI _LPI support")
Tested-by: Len Brown <len.brown@intel.com>
Cc: 7.3+ <stable@vger.kernel.org> # 7.3+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/intel_idle.rst |   12 +++++++-----
 drivers/idle/intel_idle.c                   |    9 +++++++--
 2 files changed, 14 insertions(+), 7 deletions(-)

--- a/Documentation/admin-guide/pm/intel_idle.rst
+++ b/Documentation/admin-guide/pm/intel_idle.rst
@@ -145,11 +145,13 @@ for the other idle state types (C2 and C
 the exit latency (again, that is because it reflects the target residency to
 exit latency ratio in the majority of cases for the processor models recognized
 by ``intel_idle``).  The name of the idle state (to be returned by the ``name``
-idle state attribute in ``sysfs``) is either "Cx_LPI" (if it comes from ``_LPI``
-processing) or "Cx_ACPI", where x is the index of that idle state in the final
-list (note that the minimum value of x is 1, because 0 is reserved for the
-"polling" state), and its target residency is based on the exit latency value.
-All of the idle states in the final list are enabled by default in this case.
+idle state attribute in ``sysfs``) either is equal to the state name value that
+comes from ``_LPI`` processing (with the possible fallback to "Cx_LPI" if the
+state name is not provided) or it is "Cx_ACPI", where x is the index of that
+idle state in the final list (note that the minimum value of x is 1, because 0
+is reserved for the "polling" state), and its target residency is based on the
+exit latency value.  All of the idle states in the final list are enabled by
+default in this case.
 
 
 .. _intel-idle-initialization:
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1903,8 +1903,13 @@ static void __init intel_idle_init_cstat
 
 		state = &drv->states[drv->state_count++];
 
-		scnprintf(state->name, CPUIDLE_NAME_LEN, "C%d_LPI", index + 1);
-		strscpy(state->desc, lpi_state->desc);
+		if (strlen(lpi_state->desc) > 0)
+			strscpy(state->name, lpi_state->desc);
+		else
+			scnprintf(state->name, CPUIDLE_NAME_LEN, "C%d_LPI", index + 1);
+
+		scnprintf(state->desc, CPUIDLE_DESC_LEN, "ACPI LPI MWAIT 0x%2llx",
+			  lpi_state->address);
 		state->exit_latency = lpi_state->wake_latency;
 		state->target_residency = lpi_state->min_residency;
 		state->flags = MWAIT2flg(lpi_state->address);



