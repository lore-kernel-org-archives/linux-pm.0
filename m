From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/1] suspend: make sync() on suspend-to-RAM optional
Date: Tue, 21 Jul 2015 16:41:12 +0200
Message-ID: <CAJZ5v0gNKRRaXvfqvj4YEjb+7X1aEobfvWuWyAnAcKArcxtZPA@mail.gmail.com>
References: <1436927091-32520-1-git-send-email-lenb@kernel.org>
	<55A668FE.80409@gmail.com>
	<1A7043D5F58CCB44A599DFD55ED4C948468A7978@fmsmsx115.amr.corp.intel.com>
	<1684935.fYtBRJbzgO@vostro.rjw.lan>
	<20150721093806.GA23841@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36272 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbbGUOlN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2015 10:41:13 -0400
In-Reply-To: <20150721093806.GA23841@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Austin S Hemmelgarn <ahferroin7@gmail.com>, Len Brown <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Pavel,

On Tue, Jul 21, 2015 at 11:38 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Sat 2015-07-18 01:54:09, Rafael J. Wysocki wrote:
>> On Wednesday, July 15, 2015 02:58:22 PM Brown, Len wrote:

[cut]

>> > >> Why do you need CONFIG parameter?
>> >
>> > So that an OS that doesn't want to change their user-space,
>> > can build a kernel that does what they want by default.
>> >
>> > Originally I had the config parameter remove this code entirely,
>> > which would achieve the same goal.
>> > But Rafael prefers the sysfs attribute always exist
>> > and the config simply set the default.
>>
>> Indeed.
>>
>> And so I'm queuing this patch up for 4.3 (with a couple of minor fixups).
>
> Please don't.
>
> "OS that doesn't want to change the user-space to speed up suspend by
> few milliseconds" is not a valid reason for asking about million users
> one more config question.

That's your opinion and I beg to differ.

> Affected users can't run mainline kernel
> anyway, and will have to change their userland in non-trivial ways to
> get there.

And I'm not sure what you're talking about here.  Who are the
"affected users" in particular?

Rafael
