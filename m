From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH] thermal: tango: add resume support
Date: Tue, 21 Jun 2016 11:01:00 +0200
Message-ID: <5769024C.1070806@free.fr>
References: <5768138C.6080206@free.fr> <m2k2hjafny.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:49188 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbcFUJLT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2016 05:11:19 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 3EBEE2D211
	for <linux-pm@vger.kernel.org>; Tue, 21 Jun 2016 11:02:17 +0200 (CEST)
In-Reply-To: <m2k2hjafny.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Frias <sf84@laposte.net>

On 20/06/2016 20:17, Kevin Hilman wrote:

> Overall looks good, but as I mentioned in the RFC, since you don't have
> a ->suspend() method it looks suspicious, so at least the changelog
> should describe why you think that doesn't exist.  For that matter, the
> changelog needs some more description of the patch well. :)

Patch with improved commit message incoming.

Regards.

