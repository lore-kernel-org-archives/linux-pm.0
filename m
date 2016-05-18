From: "Andrew F. Davis" <afd@ti.com>
Subject: Should 9aafabc7fece be reverted?
Date: Wed, 18 May 2016 11:58:45 -0500
Message-ID: <573C9F45.5090109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39222 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932350AbcERQ7Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2016 12:59:16 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: linux-pm@vger.kernel.org

Hello all,

Why do we need this patch? I removed giving each battery a number in its
name intentionally. It doesn't seem to be needed anymore, and only two
old drivers out of the ~70 power supply drivers do this.

Also I don't see this in my mailbox archive, was I CC'd on this patch?

Thanks,
Andrew
