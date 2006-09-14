From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: PowerOP, Whatchanged/Issues/TODO 2/2
Date: Thu, 14 Sep 2006 18:38:53 +0400
Message-ID: <4509697D.1050107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750872AbWINOiq@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pm list <linux-pm@lists.osdl.org>
Cc: Matthew Locke <matt@nomadgs.com>, Amit Kucheria <amit.kucheria@nokia.com>, Igor Stoppa <igor.stoppa@nokia.com>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

whatchanged:
- optional sysfs interface is added
- code is moved under kernel/power
- Greg's comments on kobject and coding style are addressed

todo/issues:
- better implementation for getting registered operating point names
- move string parsing into powerop generic code
- configfs for operating points creation from user space
- powerop driver module refcounting
