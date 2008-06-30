From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [linux-pm] Linux Power Management Mini-Summit -- Ottawa -- July
 22,	2008
Date: Mon, 30 Jun 2008 18:11:52 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162035BBF861D@dlee02.ent.ti.com>
References: <alpine.LFD.1.10.0806251358060.3014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932929AbYF3XNA@vger.kernel.org>
In-Reply-To: <alpine.LFD.1.10.0806251358060.3014@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Linux Power Management List <linux-pm@lists.osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> Send suggestions for topics to linux-pm@lists.osdl.org,
> whether you plan to attend or not.  The attendees will
> form the agenda by consensus at the start of the session.
>
> If you would like to attend, please send a note to
> linux-pm@lists.osdl.org announcing your intent,
> and what you would like to discuss.

I would like to attend.

Main topics of interest would be run time PM.

We currently have ARM systems using cpuidle and going to 0v with full context loss between dynamic ticks.  There are a few areas it would be nice to get feed back on some hacks have had to be employed to get reasonable performance.

For example:
- we are saving driver state based on aggressive clock disables in drivers and only restoring context back on enable on control or event paths.  Doing this at the bottom of a driver stack like MMC means you don't always have good knowledge of what the stack has in store.  As such we add some activity timers to smooth it out.  But it would be nice to have some kind of idea about upper layer activity.

- With dynamic tick running you find needless one shot timer reprogramming (mainly from high interrupts during idle).  This can overflow the timer posting buffer and stall the MPU to a slower clock domain.  This results in really bad throughput.  Just keeping user space active and the periodic timer running instead of 1-shot will result in much better performance.

- How to account for demoted C-States?  Right now if a CPUIDLE BM check forces a state reduction compared to the menu governor chosen C-State there is no path to allow for residency accounting for the actual state entered.

Thanks,
Richard W.
