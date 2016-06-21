From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2] thermal: tango: add resume support
Date: Tue, 21 Jun 2016 07:59:57 -0700
Message-ID: <7hoa6ubn9u.fsf@baylibre.com>
References: <57690362.2000706@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36440 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbcFUPHN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2016 11:07:13 -0400
Received: by mail-pf0-f175.google.com with SMTP id t190so7503041pfb.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Jun 2016 08:07:13 -0700 (PDT)
In-Reply-To: <57690362.2000706@free.fr> (Mason's message of "Tue, 21 Jun 2016
	11:05:38 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Frias <sf84@laposte.net>

Mason <slash.tmp@free.fr> writes:

> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>
> When this platform is suspended, firmware powers the entire SoC down,
> except a few hardware blocks waiting for wakeup events. And there is
> no context to save for this particular block.
>
> Therefore, there is nothing useful for the driver to do on suspend;
> so we define a NULL suspend hook. On resume, the driver initializes
> the block exactly as is done in the probe callback.
>
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
