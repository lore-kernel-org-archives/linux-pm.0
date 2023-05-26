Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF969C77B7E
	for <linux-pm@archiver.kernel.org>; Fri, 26 May 2023 02:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjEZCIR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 25 May 2023 22:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjEZCIQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2023 22:08:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9599BE7;
        Thu, 25 May 2023 19:08:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A70E64BE8;
        Fri, 26 May 2023 02:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB496C433EF;
        Fri, 26 May 2023 02:08:12 +0000 (UTC)
Date:   Thu, 25 May 2023 22:08:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-pm@vger.kernel.org
Subject: Re: [BUG 6.4-rc3] BUG: kernel NULL pointer dereference in
 __dev_fwnode
Message-ID: <20230525220806.33e66caf@rorschach.local.home>
In-Reply-To: <20230525164248.wsmyzsv5iwwswntz@mercury.elektranox.org>
References: <20230524131200.0f6fb318@rorschach.local.home>
        <CAHk-=wiNagW7exChQ4YuiRpCDN=kxmUdY5u7ebFux1jgEoL2tg@mail.gmail.com>
        <20230525164248.wsmyzsv5iwwswntz@mercury.elektranox.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 25 May 2023 18:42:48 +0200
Sebastian Reichel <sre@kernel.org> wrote:

> I have a fix for that in my fixes branch, that I planned to send
> this week:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?h=fixes&id=44c524b642996148a8e94f1a1b8751076edcf577

This appears to fix the bug I reported.

Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
