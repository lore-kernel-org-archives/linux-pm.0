From: Ran Shalit <ranshalit@gmail.com>
Subject: Ethernet WOL (wake on lan)
Date: Thu, 5 Mar 2015 18:53:56 +0200
Message-ID: <CAJ2oMhKuDQXnJb795PeqsiOrBNEburB1AayRkGVQM9Tu92n=wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello,

I would please like to ask how I should use therenet WOL (wake on lan) ?
I am using device smsc911x, and I can see in code that there is
reference to WOL.
But I don't understand how this should function.
Should I call smsc911x_suspend() smsc911x_resume() or does it
automatically suspend/resume ?
Generally speaking I rather is to stop/start automatically.

Thanks,
Ran
