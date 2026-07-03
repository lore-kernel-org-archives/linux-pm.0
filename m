Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7EF2DFA4A;
	Fri,  3 Jul 2026 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783112978; cv=none; b=GdMhDCLvK6VnmbxsoF0fzyuL5rt2jQMbe5f/rprAIKdZzcoSc0fPxe4Vc82k616djlnVqLD/901HiSTjIoLRN3K8oQUDd1OnQDgP76qvvPY/JsBAOwjHn38JHVh5ywFMqag74QzfQRLVvDyhhJ0svMMELlRpoUqULFIC5hGrMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783112978; c=relaxed/simple;
	bh=GZQ1FBSifAsE+04rbRtkuF1fB/OD0zBWi+bNiSovTww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fBOKEcw79jhVnxveKAgzoV++4XWLKgc1slQVCoeCVYMMEYa4mE0ZwaOkdW2SoGThRwn48B2raofndyoL+YZoB0TeEiof1/9GwNNdkWW4wGHwFif4qPI2VplfxdKvJ7+ok/c+a/+YiLVSi/5UNhF7K50B4aE7L07tXPreLMVIaSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7HEqDSY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7HEqDSY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934E31F000E9;
	Fri,  3 Jul 2026 21:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783112977;
	bh=8nPMkOdgH6vPZv3E0L1/87s6y+9ZPPA8sJI8Ebig5cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=S7HEqDSYehX2rE5vhDX8v14E4SNDupI2Ar+VTfduze3wgDCGmtKl3PY0K7NwFtoav
	 vUyQ6t88vQuJXNk2OXcou2i3wHOKRlgG50hgAMRTrA+ZKyj0znPrtm9taYOMsnqKW2
	 e/p889jsPO4pPy1DGhsJaUbljXoOXkU8cawVP4lzbCAXV8CdQSrFn/kkywUirB0Tb/
	 qdMFAN/OfEac0aIrJFBFPZFsEIUEReLQs7fsUymShyoexqeavoi23EWt8wp8lzgbR0
	 w59zXlXKA3/rCUNZLsZSA6fd8xAkkV7eTNHZAQOJaOzjwCnYxUItdanQl2NeIL3h8/
	 8q6xNCGlumizQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>, Sneh Mankad
 <sneh.mankad@oss.qualcomm.com>
Cc: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, Peter Zijlstra
 <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel
 Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Disallow disabling boot CPU based on config
In-Reply-To: <akfHIH_dZrr5bosu@J2N7QTR9R3>
References: <20260703-disable_boot_cpu_offline-v2-1-782d16ff58c3@oss.qualcomm.com>
 <akfHIH_dZrr5bosu@J2N7QTR9R3>
Date: Fri, 03 Jul 2026 23:09:34 +0200
Message-ID: <878q7rlr01.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jul 03 2026 at 15:28, Mark Rutland wrote:
> On Fri, Jul 03, 2026 at 04:50:02PM +0530, Sneh Mankad wrote:
>> +       depends on HOTPLUG_CPU
>> +       depends on SUSPEND
>> +       help
>> +         Disallow boot CPU (CPU0) offline when the suspend_ops->enter()
>> +         has to be executed by boot CPU.
>
> As above, I don't think this makse sense as a config option.

Correct. That's pointless as it can be determined at boot time either
through firmware (ACPI/DT) or if that's not possible for whatever
reasons then a runtime detection quirk which depends on that particular
platform.

