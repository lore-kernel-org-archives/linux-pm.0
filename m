From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH v6 6/9] thermal: cpu_cooling: implement the power
 cooling device API
Date: Tue, 9 Dec 2014 16:36:46 +0530
Message-ID: <CAKohpomJyucC6pYTTc3iOMWFi0_MnEejVOpttiFR7v6ksFieJg@mail.gmail.com>
References: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
	<1417806260-9264-7-git-send-email-javi.merino@arm.com>
	<CAOh2x==BKyS08th2d4r0Q2UGqhzAwj6sqOgFsH6J0pWup+OU_A@mail.gmail.com>
	<20141208125033.GB2980@e104805>
	<CAKohpokM_8Qm5YH0Xb=n95bP94Qreqpcd1fAyCD2W5u9Pd=ndg@mail.gmail.com>
	<20141208142217.GA1831@e104805>
	<CAKohpomy7=v_qE3B_+hhwdUE8MCJkV7gzmPpUOb==t1BuZAnAA@mail.gmail.com>
	<20141209103249.GB2891@e104805>
	<CAKohpokBVH2gnqBrDffPMcsYx6BNKFvMWkNM4D3DzU8nxb=-xw@mail.gmail.com>
	<20141209110043.GD2891@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:61602 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756520AbaLILGr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Dec 2014 06:06:47 -0500
Received: by mail-ob0-f178.google.com with SMTP id gq1so237908obb.9
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2014 03:06:47 -0800 (PST)
In-Reply-To: <20141209110043.GD2891@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Mark Brown <broonie@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

On 9 December 2014 at 16:30, Javi Merino <javi.merino@arm.com> wrote:
> Ok, how about this then?  I've pasted the whole commit so as to avoid
> confusion.

Yeah, the cpu_dev part looks fine now.
