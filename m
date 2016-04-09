From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [regression] cross core scheduling frequency drop bisected to
 0c313cb20732
Date: Sat, 09 Apr 2016 18:39:34 +0200
Message-ID: <1460219974.3700.39.camel@gmail.com>
References: <1460092854.4051.1.camel@gmail.com>
	 <20160408064510.GK3448@twins.programming.kicks-ass.net>
	 <1460098254.5582.17.camel@gmail.com> <2428384.mEkP3EOpsR@vostro.rjw.lan>
	 <1460184056.3765.160.camel@gmail.com>
	 <CAJZ5v0ig1qTTMw5GHO_-vuyETD46tin8bS2deyvtw0OvuDSCng@mail.gmail.com>
	 <1460214622.3714.8.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37338 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156AbcDIQjj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 Apr 2016 12:39:39 -0400
In-Reply-To: <1460214622.3714.8.camel@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@redhat.com>


Hm, setting gov=performance, and taking the average of 3 30 second
interval PkgWatt samples as pipe-test runs..

714KHz/28.03Ws = 25.46
877KHz/30.28Ws = 28.96

..for pipe-test, the tradeoff look a bit more like red than green.

	-Mike
