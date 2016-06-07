From: Dan Jacobson <jidanni@jidanni.org>
Subject: Re: pause to allow user to read final screen before poweroff
Date: Tue, 07 Jun 2016 08:50:00 +0800
Message-ID: <87twh5zutj.fsf@jidanni.org>
References: <bug-112111-12294@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:49314 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbcFGAuG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jun 2016 20:50:06 -0400
Received: from homiemail-a37.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
	by hapkido.dreamhost.com (Postfix) with ESMTP id F0EF78779C
	for <linux-pm@vger.kernel.org>; Mon,  6 Jun 2016 17:50:05 -0700 (PDT)
Received: from homiemail-a37.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a37.g.dreamhost.com (Postfix) with ESMTP id C6070208069
	for <linux-pm@vger.kernel.org>; Mon,  6 Jun 2016 17:50:03 -0700 (PDT)
Received: from jidanni.org (122-118-144-16.dynamic.hinet.net [122.118.144.16])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: jidanni@jidanni.org)
	by homiemail-a37.g.dreamhost.com (Postfix) with ESMTPSA id 88ADE208063
	for <linux-pm@vger.kernel.org>; Mon,  6 Jun 2016 17:50:03 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

OK I can use
# systemctl halt
