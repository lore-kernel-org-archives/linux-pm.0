From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH] regulator: max77693: Add max77693 regualtor driver.
Date: Mon, 24 Jun 2013 10:54:26 +0900
Message-ID: <51C7A6D2.8060709@samsung.com>
References: <1371711806-18826-1-git-send-email-jonghwa3.lee@samsung.com>
 <20130621151930.GB27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:33830 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab3FXBya (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2013 21:54:30 -0400
In-reply-to: <20130621151930.GB27646@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Myungjoo Ham <myungjoo.ham@samsung.com>

Hi,
On 2013=EB=85=84 06=EC=9B=94 22=EC=9D=BC 00:19, Mark Brown wrote:

> On Thu, Jun 20, 2013 at 04:03:26PM +0900, Jonghwa Lee wrote:
>> This patch adds new regulator driver to support max77693 chip's regu=
lators.
>> max77693 has two linear voltage regulators and one current regulator=
 which
>> can be controlled through I2C bus. This driver also supports device =
tree.
>=20
> This is fine but doesn't have a binding document which is needed for =
new
> DT bindings.
>=20


I'd like to add binding document to max77693 mfd's but it is still in p=
rogress
(https://lkml.org/lkml/2013/4/9/221). I think I can updates it when the=
 patch
is merged. Do you think I have to wait for merging? Or just add documen=
t under
regulator/ this time ,and then move it to mfd/ later? Which one do you =
think better?

> A comment in the is_enabled() function explaining that more than one =
bit
> might be set (or replacing it with the generic function) would also b=
e
> good.


Yes, the charger regulator needs two bits for checking enabling. I'll a=
dd the
comment about it.

Thanks,
Jonghwa

