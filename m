From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2 v3] speed up cpu_up()
Date: Fri, 08 May 2015 22:43:06 +0200
Message-ID: <2116679.yOmM0yGbfx@vostro.rjw.lan>
References: <1431107287-22022-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61541 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932369AbbEHUSC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 16:18:02 -0400
In-Reply-To: <1431107287-22022-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, May 08, 2015 01:48:05 PM Len Brown wrote:
> Thanks for the feedback, here is a simplifed pair of patches.
> 
> I also like the x2apic optimization, since it addresses additional delays.
>  -- though we may be able to optimize those in the non-x2apic case too.

For both [1-2/2]:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

