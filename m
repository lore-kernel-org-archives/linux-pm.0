From: Dan Jacobson <jidanni@jidanni.org>
Subject: pause to allow user to read final screen before poweroff
Date: Tue, 01 Mar 2016 13:42:37 +0800
Message-ID: <878u224uuq.fsf_-_@jidanni.org>
References: <bug-112111-12294@https.bugzilla.kernel.org/>
Reply-To: linux-pm@vger.kernel.org, jidanni@jidanni.org
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:42410 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbcCAFmm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 00:42:42 -0500
Received: from homiemail-a60.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 34975923BF
	for <linux-pm@vger.kernel.org>; Mon, 29 Feb 2016 21:42:42 -0800 (PST)
Received: from homiemail-a60.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a60.g.dreamhost.com (Postfix) with ESMTP id 2F2F73BC06A
	for <linux-pm@vger.kernel.org>; Mon, 29 Feb 2016 21:42:41 -0800 (PST)
Received: from jidanni.org (122-118-149-44.dynamic.hinet.net [122.118.149.44])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jidanni@jidanni.org)
	by homiemail-a60.g.dreamhost.com (Postfix) with ESMTPSA id E99F73BC063
	for <linux-pm@vger.kernel.org>; Mon, 29 Feb 2016 21:42:40 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

How can the user read the final screen before powerdown? I have a proposal:
https://bugzilla.kernel.org/show_bug.cgi?id=112111

b> --- Comment #1 from Aaron Lu <aaron.lu@intel.com> ---
b> bugzilla is not the right place for such discussion, please send your proposal
b> to linux-pm@vger.kernel.org mailing list.
