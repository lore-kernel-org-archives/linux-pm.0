Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E7457E49;
	Fri, 11 Sep 2026 21:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162548; cv=none; b=T8WfqFeKEYkGuyVsEpQbu/DDARMJ9x/R0NVfjpFk6lfpgNv1LJqXK/vvHwMUmZV2EEd3ucoxwjhU6hy5pqHgeWNQC95Knjrou63M1P9TQG24uArHPfyv0YUem5BKpH8h4KeIJCuYNMBFF/ZkHW7P6kFiWDWykVBjEpBNoAIUedA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162548; c=relaxed/simple;
	bh=W4KXX3fdBQTx7RvNGHdkgjdGwoOaGmGgFAMr7ryNdI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRGGLn8t1Ql9HfiQ6F+wsQuMDKK9szijsv/c1uhMsIZWDfyiYUK8Je+i/wRfcOF3Nnd1iAdN8P9sheT0BaFzqGoUdiz+EkWc2z4wWgcCRA/5kU87HJCetb9Sp/aL/9QBGACC3L4BNpD6sJKruWY9VZjX8SgGTgzqyQok0HQqqwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Jqqjj5Nj; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Jqqjj5Nj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789162543; x=1789767343; i=w_armin@gmx.de;
	bh=BIEGw86T9NUN38jdMJyVdZ/p86qzcsXITFSxC4HAI34=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Jqqjj5Nj0l+DqELlw/XYi1a7xgy021SwjfMfllk9CCadh45Vfmi3Y6U8UwP3CS4F
	 YDtffW20j9vQm6TRVgRAhKqyk1Ksw84q/Nh2yx3e9feb135exz2+ZW3mFxIH8G+Ok
	 OaIM/XTYkck1hwnOg53LArFAOPPowywICbZsOP3cH4sfv8lFYbQzo/i9FbOkCWfTq
	 bZqwihWem6iEnAMHnlLKUU7K8TpAzhd64nVZpnVrxEdiowIid8RGpHjmBWGmLVqU0
	 kRIioCIis/L1tQcqob6NwLdH17+kC6sEWqDMpItNKPOEqcZBVrm3yenpm1kT6T0jd
	 RujrEczAsjw9hTfXag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7zFZ-1wjzS93r99-015tPE; Fri, 11
 Sep 2026 23:35:43 +0200
Message-ID: <951189ad-71b6-4776-8484-a207f1efe415@gmx.de>
Date: Fri, 11 Sep 2026 23:35:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/10] ACPI: thermal: Register thermal class cooling
 devices under parents
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede
 <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <1965933.tdWV9SEqCh@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jfVmfGfQaUtM1gI6jesHtLv/k0QzjGK4nVbslQ6e4kM1gH+LTwr
 031Z6kpvfK7OOhby7q/JfO22epIqF+x4dwP2ljlctNd6/9qpFHu755Hxk5rc+31SuFw7gCI
 2fkb2CrYh9rTOgrUCVmWlmpOxQiMP5kk/98Wt6GeWGQLtqGFiFIHFoca/6daNwitWSLBVyx
 R8MJy7zcOEYi+PCsNJ4mw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IsDA9Wu49N4=;830N6SR6Vq/ZRFWcaSa80NYU+OK
 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
 aZmPEKW2eXOeqCsZMkVYqxUHVD3br4E

Am 11.09.26 um 15:00 schrieb Rafael J. Wysocki:

> Hi All,
>
> This series generally changes the way in which thermal class cooling devices
> are used by ACPI device drivers registering them (ACPI processor, ACPI fan,
> and ACPI video) and by the ACPI thermal zone device driver.
>
> First, it causes the thermal class cooling devices to be registered under
> parents in specific locations within the device hierarchy which allows
> their relationships with other devices to be recognized more easily.  It
> also drops custom sysfs attributes registered by the users of the thermal
> class cooling devices because they are not particularly useful any more
> when those devices get proper parents.
>
> Second, it modifies the ACPI thermal zone device driver to use thermal class
> cooling device parent information for binding cooling devices to trip points
> in thermal zones, which was previously done with the help of the devdata
> pointers of the cooling devices and effectively prevented drivers from using
> the devdata pointers for their own purposes as originally intended.
>
> Finally, it updates the ACPI processor and ACPI fan drivers to use the
> devdata pointers of thermal class cooling devices in a bit more efficient
> way.
>
> The first two patches in the series are preliminary fixes preventing
> Sashiko from reporting "pre-existing issues" in the subsequent patches.
>
> The third patch is a thermal core update allowing thermal class cooling
> devices to be registered under proper parents.
>
> The other patches update the ACPI processor, ACPI video, and ACPI fan
> drivers as per the above.
>
> The details are covered by individual patch changelogs.
>
> Thanks!

Nice patch series, it looks mostly good to me. Do you plan something similar for
thermal zones?

Thanks,
Armin Wolf

