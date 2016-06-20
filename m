From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] thermal: tango: add resume support
Date: Mon, 20 Jun 2016 11:17:21 -0700
Message-ID: <m2k2hjafny.fsf@baylibre.com>
References: <5768138C.6080206@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34102 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbcFTSRY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 14:17:24 -0400
Received: by mail-pa0-f41.google.com with SMTP id bz2so53108413pad.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2016 11:17:23 -0700 (PDT)
In-Reply-To: <5768138C.6080206@free.fr> (Mason's message of "Mon, 20 Jun 2016
	18:02:20 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Frias <sf84@laposte.net>

Mason <slash.tmp@free.fr> writes:

> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Overall looks good, but as I mentioned in the RFC, since you don't have
a ->suspend() method it looks suspicious, so at least the changelog
should describe why you think that doesn't exist.  For that matter, the
changelog needs some more description of the patch well. :)

Kevin
