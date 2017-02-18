From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v6 0/8] Runtime PM for Thunderbolt on Macs
Date: Sat, 18 Feb 2017 10:52:50 +0100
Message-ID: <20170218095250.GC1335@wunner.de>
References: <cover.1486913733.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:55163 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbdBRJwp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Feb 2017 04:52:45 -0500
Content-Disposition: inline
In-Reply-To: <cover.1486913733.git.lukas@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pm@vger.kernel.org

Hi Rafael,

On Sun, Feb 12, 2017 at 05:07:45PM +0100, Lukas Wunner wrote:
> Power down Thunderbolt controllers on Macs when nothing is plugged in
> to save around 2W per controller and fix a power regression introduced
> in v3.17 that affects millions of machines (all Macs with Thunderbolt)

Patches 4, 5 and 6 of this series pertain to the PM subsystem:
https://patchwork.kernel.org/patch/9568441/
https://patchwork.kernel.org/patch/9568443/
https://patchwork.kernel.org/patch/9568445/

I've been posting these unmodified over the course of four iterations
since mid December but haven't seen comments from you.  Are there any
objections?  If not, would it be possible for you to include them in
your second pull for 4.11?  This would help greatly as I wouldn't have
to post them over and over again.

Thanks,

Lukas
