From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH] ACPI: replace strlen("string") with
 sizeof("string") -1
Date: Tue, 7 Aug 2012 21:27:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1208072124250.8098-100000@netrider.rowland.org>
References: <5021A372.8030409@pavlinux.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5021A372.8030409@pavlinux.ru>
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Vasilyev <pavel@pavlinux.ru>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 8 Aug 2012, Pavel Vasilyev wrote:

> >>> Yes.  So if s contains "abcde" then
> >>>
> >>> 	memcmp(s, "abc", 3) and strncmp(s, "abc", 3) will both return 0, and
> >>> 	memcmp(s, "abc", 4) and strncmp(s, "abc", 4) will both return 1.
> >>
> >> No matter what is contained in *s, "abcde" or "abcxxx",
> >> are important first N bytes. The second example, you see,
> >> a little bit stupid, and devoid of logic. :)
> >
> > Maybe yes, maybe no.  It all depends on what you want.
> >
> > For example, if you're looking for "on" or "off", what should you do
> > when the user writes "onoff"?  You could accept it as meaning the same
> > as "on", but if you were being careful then you would want to reject it
> > as a meaningless value.
> 
> 
> The users should't be allowed to think!
> There is "on" - the size of 2 bytes, or "off" - 3 bytes,
> other variations - user error.
> 
> We do not create a kernel with artificial intelligence? ;)

Let me rephrase the previous statement, as it appears you did not 
understand what I meant.

If the kernel is testing for "on" or "off", what should it do when the
user writes "onoff"?  The kernel could accept this as meaning the same
as "on", but if the kernel was being careful then it should reject
"onoff" as a meaningless value.  A 2-byte comparison for "on" would
accept "onoff" whereas a 3-byte comparison would not.

Alan Stern

