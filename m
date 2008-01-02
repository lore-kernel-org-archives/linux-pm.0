From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC] sleepy linux
Date: Wed, 2 Jan 2008 11:52:51 +0100
Message-ID: <200801021152.52639.oliver@neukum.org>
References: <20071225230731.GA29030@elf.ucw.cz> <200712301739.42192.oliver@neukum.org> <20071231144447.GD26339@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757735AbYABKxV@vger.kernel.org>
In-Reply-To: <20071231144447.GD26339@ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Am Montag, 31. Dezember 2007 15:44:47 schrieb Pavel Machek:
> On Sun 2007-12-30 17:39:42, Oliver Neukum wrote:

> > But what's wrong with calling suspend() the conventional way once you've
> > decided to go into sleepy mode?
> 
> I'm not sure if it can be done in non-racy way. It is different from
> "conventional" suspend(): you can still have userland requests after
> this suspend(), and you should abort auto-sleep if you get one. (As
> opposed to blocking in system suspend case).

But we are always racing against hardware in these cases.

Strictly speaking you cannot have pure userland request. If no task
is runnable and no timer about to fire any activity will require kernel
activity unless you are doing direct hardware access from user space
which in the generic case precludes suspension anyway.

	Regards
		Oliver
