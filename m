Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7703B40D594;
	Fri, 11 Sep 2026 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161260; cv=none; b=aw5FbEj5cm0ApEUZxVfTzjGHw195jt8KcKcxM6yjBggiYY4M63tSMg+EUS0R43mtUz51ZXL3diJjTXUcTece8lERNaloAtUcJLl7lglCmnfMT9JIITejfK4Wj07GUtROOVpShQ9dk1F8Q4kclF0yaze8zqHZMAa0ufA7iHA7Zxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161260; c=relaxed/simple;
	bh=Y1VeF939U1I0oF4Z3cLYgYjRC3dKugKxAJsnS1tBSxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pf7h0mPnQQsj5JZ5cG5OgITDBDZhaiUHVjupE7j5z23QzbRHrg8GIEi1ZqQhCRBG+i4Sy7vF+nM/GAmU1sbyr2fi+JtnbCJuX5/+dsu1TMbeOUCvylYBoDT3itVOjfE2djZOH8/w8PI+uSI0Y5YzBcAA85/1d32R/MKT/UbxSrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=GwAG6Ry5; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="GwAG6Ry5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789161250; x=1789766050; i=w_armin@gmx.de;
	bh=Y1VeF939U1I0oF4Z3cLYgYjRC3dKugKxAJsnS1tBSxg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GwAG6Ry5iCtzFM+R8dU1dyvMKtjI5qTs9Yhz7Bq5sXSCKdcfVLX/p3qwwsZod1Of
	 VgNEmeDQCm7E/OssXgRVqG3n0ACpTC89v020TSZPZYkI6xUnHMu59ibfStOcLnTci
	 g5ONt/RYlmpmZAE+YoJh+W8fiYahZyOSn7t8JNpEYWwg6SEtRsNgj6cgMgA8DPbNp
	 7PhIPAiwD/o7GWi2yMauyVnqFb2B8Ct++sSku2byygIf4j6fE5SU/78BLNIhgRSnv
	 l2Fs+RmRg6sf1CkWkj8rRPbCf+vkC1pSB7eSep7ySxSeCXdXptvp+HHnI52XvHCw2
	 oS5if+HhT7dF+GgU6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1wQYYY17RM-00mqkH; Fri, 11
 Sep 2026 23:14:10 +0200
Message-ID: <5b54b08a-4dfd-4efe-b646-821adcd235b2@gmx.de>
Date: Fri, 11 Sep 2026 23:14:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/10] ACPI: processor: thermal: Use
 thermal_cooling_device_create()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede
 <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <2362345.iZASKD2KPV@rafael.j.wysocki> <aqQtIMm-gdJoZAsq@ashevche-desk.local>
 <CAJZ5v0j5B4LFbrhSuw0j=fLcY+cFFTEMvyt_ED-+9j1dvQEqLw@mail.gmail.com>
 <aqQwf3y66lPhTTyf@ashevche-desk.local>
 <CAJZ5v0jV-cMDt0Hhhw8Nnea1jhXfGVUajaomAmSUcmx2sZLb6Q@mail.gmail.com>
 <aqRDC2LZ7m3caTSn@ashevche-desk.local>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <aqRDC2LZ7m3caTSn@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Md78ryZaK5lHbwI5yEX8HGkikGM1KXCnuSkXaAHYdWn2BP9+2lD
 gNfniYmJ8Dp/Y2rYiJ7XzK4c0MZHfsV+6onJfE6+KWpWgxRHsrLHvoqMQe8s+HV/GoguiBd
 wn6VPVSYQBFSwehA4+YtOGsakvSzji8/GIg/LHhTwAlhKThxlGC0PCVZNteDyRe+PlvP34M
 xw8Dh5I7vKEte1tdlpNtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kGxYJw5zDC8=;9XgB/lqhnWj+fur2g9z6N0Ip8YJ
 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

Am 11.09.26 um 20:06 schrieb Andy Shevchenko:

> On Fri, Sep 11, 2026 at 07:01:23PM +0200, Rafael J. Wysocki (Intel) wrot=
e:
>> On Fri, Sep 11, 2026 at 6:47=E2=80=AFPM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>> On Fri, Sep 11, 2026 at 06:36:28PM +0200, Rafael J. Wysocki (Intel) wr=
ote:
>>>> On Fri, Sep 11, 2026 at 6:32=E2=80=AFPM Andy Shevchenko
>>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>>> On Fri, Sep 11, 2026 at 03:02:53PM +0200, Rafael J. Wysocki wrote:
> ...
>
>>>>> Is any user space ABI breakage expected as an outcome of this change=
?
>>>> Not really.
>>> Maybe makes sense to state this clearly in the cover letter?
>> I guess you specifically mean the manually created symbolic links in
>> sysfs that get removed.
>>
>> If so, I'm not aware of anyone using them for anything, but the lack
>> of observation is not proof of nonexistence.
> Yes, I refer to the changes in the sysfs layout / presence / absence.

AFAIK those custom sysfs attributes are not even documented under Document=
ation/ABI, and
thermald also does not seem to use them. I thus think we can safely remove=
 them.

Thanks,
Armin Wolf

