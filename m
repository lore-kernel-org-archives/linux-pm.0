From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: 3.12: kernel panic when resuming from suspend to RAM (x86_64)
Date: Mon, 18 Nov 2013 13:21:33 +0100
Message-ID: <528A064D.5020807@gmail.com>
References: <52888F6D.6000802@gmail.com> <CAC9WiBggfssh+31_MqVCT-hDf2E8zTuc81q-DhLYQuVF053mEA@mail.gmail.com> <20131117220611.GQ27323@pd.tnic> <4636530.OR894YNbbr@vostro.rjw.lan> <20131117224621.GR27323@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:36210 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab3KRMVg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2013 07:21:36 -0500
In-Reply-To: <20131117224621.GR27323@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux PM list <linux-pm@vger.kernel.org>

Le 17/11/2013 23:46, Borislav Petkov a =C3=A9crit :
> On Sun, Nov 17, 2013 at 11:34:20PM +0100, Rafael J. Wysocki wrote:
>> This looks like a softirq bug to me (and related to cpuidle).
>=20
> Reportedly, it happens right after resume from RAM. Francis, is that
> correct?

yes that's correct. I haven't been hit by this issue otherwise.

