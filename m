From: Ian Malone <ibmalone@gmail.com>
Subject: Re: kernels 3.9.5 to 3.10.6 fail to boot on battery, vaio vgn-c2m/w
Date: Sun, 27 Oct 2013 21:54:53 +0000
Message-ID: <CAL3-7MrExuRWc-ugzU4c4y-trQaCfO_UU2c6tt+P4-8fwiWmUg@mail.gmail.com>
References: <CAL3-7MrW0p-YuJBpiguoG7f0j7vgyJALhdSnh81uRM_5TR50Xg@mail.gmail.com>
	<CAOLK0pxpsRWR+oiQjLSpbPWefptZeEx76P+okTSLeYW1qGZ4Vw@mail.gmail.com>
	<CAL3-7Mp4ncq4Q=uxmLR6ykExqu1BTzhJjX3UcyBTfZUPrLUCdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vb0-f49.google.com ([209.85.212.49]:54134 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab3J0Vyy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Oct 2013 17:54:54 -0400
Received: by mail-vb0-f49.google.com with SMTP id w16so3901838vbb.36
        for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2013 14:54:53 -0700 (PDT)
In-Reply-To: <CAL3-7Mp4ncq4Q=uxmLR6ykExqu1BTzhJjX3UcyBTfZUPrLUCdA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi,

Is there anything I can do that will help to resolve this bug?

> https://bugzilla.kernel.org/show_bug.cgi?id=60770
>

Quick summary: removal of idle=mwait has led to laptop failing to boot
on battery. Only known workaround so far is to use idle=poll which
drains battery at an amazing rate.

-- 
imalone
http://ibmalone.blogspot.co.uk
