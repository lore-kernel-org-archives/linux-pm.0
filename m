From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 00/14] Marvell EBU thermal sensor consolidation
Date: Mon, 25 Mar 2013 13:23:32 +0100
Message-ID: <CABJ1b_S9c=tFT17=HycmuRbW1g4y8AvWJpmwMRJwvQ214Yb3fw@mail.gmail.com>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<20130325093001.GH5627@lunn.ch>
	<20130325104513.GC2502@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:64539 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756569Ab3CYMXd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 08:23:33 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so6392863oag.29
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2013 05:23:33 -0700 (PDT)
In-Reply-To: <20130325104513.GC2502@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

On Mon, Mar 25, 2013 at 11:45 AM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> On Mon, Mar 25, 2013 at 10:30:01AM +0100, Andrew Lunn wrote:
>> I've not a strong opinion, but i think separate drivers are better.
>
> Don't you think a single driver could make maintenance cheaper?

Ezequiel, Andrew,

just to sum up my opinion on the whole discussion

+1 for formula fixes for kirkwood and dove
+1 for separate drivers
+1 for thermal-mmio as Jason Gunthorpe suggested

And then port thermal drivers to thermal-mmio..

Sebastian
