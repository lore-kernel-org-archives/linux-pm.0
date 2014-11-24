From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH/RFC 2/3] ARM: shmobile: kzm9g-reference dts: Move Ethernet
 node to BSC
Date: Tue, 25 Nov 2014 00:11:40 +0300
Message-ID: <54739F0C.7040802@cogentembedded.com>
References: <1416859808-18503-1-git-send-email-geert+renesas@glider.be> <1416859808-18503-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:47683 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbaKXVLo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Nov 2014 16:11:44 -0500
Received: by mail-la0-f54.google.com with SMTP id gf13so8178489lab.41
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2014 13:11:43 -0800 (PST)
In-Reply-To: <1416859808-18503-3-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 11/24/2014 11:10 PM, Geert Uytterhoeven wrote:

> Move the Ethernet node from the root of the device tree to the BSC node,
> as it is connected to the Bus State Controller.  This allows the system
> to know the right position of the Ethernet node in the clock and PM
> domain hierarchy.

> Also rename the node's name from "lan9220" to "ethernet", to confirm to

    s/confirm/comply/, you mean?

> ePAPR generic name recomendations.

    Thank you, I've never found the time to rename those device nodes.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

WBR, Sergei

