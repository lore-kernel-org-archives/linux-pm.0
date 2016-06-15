From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [RFC] Adding PM support to thermal driver
Date: Wed, 15 Jun 2016 14:51:04 -0700
Message-ID: <m2eg7ynmt3.fsf@baylibre.com>
References: <57617ED6.6050305@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33507 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932346AbcFOVvH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 17:51:07 -0400
Received: by mail-pf0-f171.google.com with SMTP id i123so8860344pfg.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2016 14:51:07 -0700 (PDT)
In-Reply-To: <57617ED6.6050305@free.fr> (Mason's message of "Wed, 15 Jun 2016
	18:14:14 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@arm.com>, linux-pm <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Frias <sf84@laposte.net>

Mason <slash.tmp@free.fr> writes:

> I need to support suspend-to-RAM in my platform.
> This platform powers down on suspend, so the contents of device registers are lost.
> Can you tell me if this patch looks OK for adding S2R support?

The idea looks right for ensuring a clean resume after context loss.

However, I'm a bit surprised to see an empty ->suspend hook though.  Is
there nothing to do to gracefully shutdown this hardware?  A quick
glance suggests maybe CMD_OFF should be sent?

Kevin
