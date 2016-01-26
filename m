From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] timer: add setup_deferrable_timer macro
Date: Tue, 26 Jan 2016 18:23:07 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601261822220.3886@nanos>
References: <1452619040-27137-1-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37798 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966811AbcAZRYK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jan 2016 12:24:10 -0500
In-Reply-To: <1452619040-27137-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, patchwork-lst@pengutronix.de

On Tue, 12 Jan 2016, Lucas Stach wrote:

> Add the trivial missing macro to setup a deferrable timer.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

@Rafael: Feel free to pick that up along with the other one.

