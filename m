From: Ryan Tandy <ryan@nardis.ca>
Subject: Re: [PATCH v4 1/2] power: reset: add linkstation-reset driver
Date: Sun, 8 Jan 2017 21:43:15 -0800
Message-ID: <20170109054315.GB580@kiwi.nardis.ca>
References: <20161227070611.14852-1-rogershimizu@gmail.com>
 <20170107150451.17912-1-rogershimizu@gmail.com>
 <20170107150451.17912-2-rogershimizu@gmail.com>
 <20170108170209.GD573@kiwi.nardis.ca>
 <CAEQ9gEkvj++e7ch40cFqBy3KXg-a=pYnH7cwErMe2RDd2qzQJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36270 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755333AbdAIFnT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 00:43:19 -0500
Received: by mail-pg0-f67.google.com with SMTP id 75so12433587pgf.3
        for <linux-pm@vger.kernel.org>; Sun, 08 Jan 2017 21:43:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAEQ9gEkvj++e7ch40cFqBy3KXg-a=pYnH7cwErMe2RDd2qzQJg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Roger Shimizu <rogershimizu@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Martin Michlmayr <tbm@cyrius.com>, Sylver Bruneau <sylver.bruneau@googlemail.com>, Herbert Valerio Riedel <hvr@gnu.org>, Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jan 09, 2017 at 12:31:44PM +0900, Roger Shimizu wrote:
>This driver, linkstation-reset, can also handle PPC Linkstation after
>it's converted to DT.
>I already considered this and mentioned in previous reply [0].

OK. I was thinking of Sebastian's earlier comment:

On Wed, Dec 21, 2016 at 04:59:29PM +0100, Sebastian Reichel wrote:
>These models can just be added to qnap-poweroff, which handles
>exactly this special case as far as I can see.

and forgot that you planned to handle it in this driver. Sorry for the 
noise.
