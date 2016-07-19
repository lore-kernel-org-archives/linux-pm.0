From: Lukas Wunner <lukas@wunner.de>
Subject: Re: Sequence of suspend/resume calls
Date: Wed, 20 Jul 2016 01:54:00 +0200
Message-ID: <20160719235400.GB7890@wunner.de>
References: <CANMsd01zGiB8wu3J1sqXGXwsNWq3AkaA26BSQHfPVAGdHwiUeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:50799 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbcGSXxw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2016 19:53:52 -0400
Content-Disposition: inline
In-Reply-To: <CANMsd01zGiB8wu3J1sqXGXwsNWq3AkaA26BSQHfPVAGdHwiUeg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ryan <ryanphilips19@googlemail.com>
Cc: linux-pm@vger.kernel.org

On Mon, Jul 18, 2016 at 06:34:10PM -0700, Ryan wrote:
> Is it possible for the resume function of a particular driver to be
> called before resume function of others are being called?

device_pm_wait_for_dev()

Best regards,

Lukas
