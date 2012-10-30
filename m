From: "Konstantin Ryabitsev via RT" <rt@kernel.org>
Subject: [k.org requests #104] Add 2 categories to linux-pm bugzilla
Date: Tue, 30 Oct 2012 15:35:55 +0000
Message-ID: <rt-3.8.13-17380-1351611355-568.104-6-0@kernel.org>
References: <RT-Ticket-104@kernel.org> <508F40D5.2010109@kernel.org> <rt-3.8.13-793-1351610640-515.104-6-0@kernel.org> <1451306.UP2oztoM1Z@vostro.rjw.lan> <rt-3.8.13-17378-1351610911-1063.104-6-0@kernel.org>
Reply-To: rt@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:52648 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932135Ab2J3PgG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 30 Oct 2012 11:36:06 -0400
In-Reply-To: <rt-3.8.13-17378-1351610911-1063.104-6-0@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org

On Tue Oct 30 15:28:31 2012, rjw@sisk.pl wrote:
> Can we arrange things so that the _first_ message from every bug in
> these categories goes to linux-pm@vger.kernel.org and then they are
> assigned to a generic power management entity?

I don't believe bugzilla allows us such flexibility, so someone would
have to manually change the default assignee. However, you could set up
a whine script to send bug summaries to linux-pm, if you wanted to.

Best,
--=20
Konstantin Ryabitsev
Systems Administrator
Linux Foundation, kernel.org
Montr=C3=A9al, Qu=C3=A9bec
