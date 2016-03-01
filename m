From: =?utf-8?B?56mN5Li55bC8?= Dan Jacobson <jidanni@jidanni.org>
Subject: Re: pause to allow user to read final screen before poweroff
Date: Tue, 01 Mar 2016 14:04:46 +0800
Message-ID: <874mcq4ttt.fsf@jidanni.org>
References: <bug-112111-12294@https.bugzilla.kernel.org/>
Reply-To: jidanni@jidanni.org, linux-pm@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from homie.mail.dreamhost.com ([208.97.132.208]:42842 "EHLO
	homiemail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750760AbcCAGEu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 01:04:50 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: yu chen <yu.chen.surf@gmail.com>
Cc: linux-pm@vger.kernel.org

>>>>> "yc" == yu chen <yu.chen.surf@gmail.com> writes:

yc> Sometimes people use serialport,etc,

Well 99% of simple users have no such equipment.

yc> why do you want to record the last message for poweroff? I know
yc> there is similar scenario for panic of panic_timeout.

I know it is tough to record at this point, so instead I'm proposing
this to just allow the user to have a chance to read, not record.

He might have noticed something funny last poweroff, and would like to
have a chance to see what it says next time, or every time.
