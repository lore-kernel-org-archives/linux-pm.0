From: Vinson Lee <vlee@twopensource.com>
Subject: [stable request 3.4 3.5] intel_idle Ivy Bridge support
Date: Thu, 19 Dec 2013 17:23:17 -0800
Message-ID: <CAHTgTXXuJ8E=XRH8m5fdCwLAWswuG-OLybYGDuuFg9QZ6Y7-Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:46033 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756730Ab3LTBXS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2013 20:23:18 -0500
Received: by mail-oa0-f54.google.com with SMTP id h16so2170765oag.27
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2013 17:23:17 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: stable@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>

Hi.

Please consider backporting these upstream commits to stable trees 3.4 and 3.5.
6edab08c24f9141d69cfa4683a0a027d86ab303e "intel_idle: initial IVB support"
23795e580cad5d6b73d47d51b9074ce3e58bf334 "intel_idle: enable IVB Xeon support"

These patches were already backported to 3.2.y in 3.2.35.

Cheers,
Vinson
