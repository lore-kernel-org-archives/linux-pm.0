From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] power supply changes for 4.2
Date: Tue, 23 Jun 2015 16:13:34 -0700
Message-ID: <CA+55aFx_X2pj=b6qzx5HcGByLmucKSRrbyCpVmZjo_fQ+yiYxg@mail.gmail.com>
References: <20150623005302.GB24028@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35075 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950AbbFWXNf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 19:13:35 -0400
In-Reply-To: <20150623005302.GB24028@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Mon, Jun 22, 2015 at 5:53 PM, Sebastian Reichel <sre@ring0.de> wrote:
>
>   git://git.infradead.org/battery-2.6.git tags/for-4.2

So I started wondering. Why do you use infradead for one of your
trees, but git.kernel.org for the other (the HSI one)? That just looks
odd to me.

Also, something in your HSI pull request made gmail unhappy, and it
marked it as spam. Do you send the emails differently too?

                Linus
